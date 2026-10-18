#!/usr/bin/env python3
"""Small Linux resource collector, SQLite history, Telegram checker and read API."""
import argparse
import base64
from contextlib import contextmanager
import datetime as dt
import fcntl
import http.client
import json
import os
from pathlib import Path
import re
import socket
import sqlite3
import time
import urllib.parse
import urllib.request
from http.server import BaseHTTPRequestHandler, HTTPServer
from socketserver import ThreadingMixIn

CONFIG = Path(os.environ.get('VPS_MONITOR_CONFIG', '/etc/vps-resource-monitor/config.json'))
DATA = Path(os.environ.get('VPS_MONITOR_DATA', '/var/lib/vps-resource-monitor'))
TYPES = {'cpu', 'ram', 'swap', 'disk', 'network', 'nginx_requests'}
DEFAULT_THRESHOLDS = {'cpu': 75, 'ram': 90, 'disk': 80, 'network': 80}
SPEED_TEST_HOST = 'speed.cloudflare.com'
SPEED_TEST_BYTES = 50_000_000
NGINX_TIME = re.compile(rb'\[([^\]]+)\]')


def config():
    c = json.loads(CONFIG.read_text())
    c['server_id'] = c.get('server_id') or socket.gethostname()
    return c


@contextmanager
def connect(readonly=False):
    path = DATA / 'metrics.sqlite3'
    db = sqlite3.connect(f'file:{path}?mode=ro' if readonly else str(path), uri=readonly, timeout=2)
    db.row_factory = sqlite3.Row
    db.execute('PRAGMA busy_timeout=2000')
    try:
        with db:
            yield db
    finally:
        db.close()


def init():
    DATA.mkdir(parents=True, exist_ok=True)
    with connect() as db:
        db.execute('PRAGMA journal_mode=WAL')
        db.executescript('''
        CREATE TABLE IF NOT EXISTS samples (
          id INTEGER PRIMARY KEY AUTOINCREMENT, ts INTEGER NOT NULL,
          server_id TEXT NOT NULL, type TEXT NOT NULL, object TEXT NOT NULL,
          percent REAL, values_json TEXT NOT NULL);
        CREATE INDEX IF NOT EXISTS samples_time ON samples(ts,id);
        CREATE INDEX IF NOT EXISTS samples_filter ON samples(type,object,ts,id);
        CREATE TABLE IF NOT EXISTS state (key TEXT PRIMARY KEY, value TEXT NOT NULL);
        CREATE TABLE IF NOT EXISTS alerts (
          id INTEGER PRIMARY KEY AUTOINCREMENT, ts INTEGER NOT NULL,
          server_id TEXT NOT NULL, details_json TEXT NOT NULL, sent INTEGER NOT NULL);
        CREATE INDEX IF NOT EXISTS alerts_time ON alerts(ts,id);
        ''')
        rows = db.execute("SELECT id,values_json FROM samples WHERE type='network'").fetchall()
        updates = []
        for row in rows:
            values = json.loads(row['values_json'])
            if 'rx_total_mb' in values or 'tx_total_mb' in values:
                values.pop('rx_total_mb', None)
                values.pop('tx_total_mb', None)
                updates.append((json.dumps(values), row['id']))
        db.executemany('UPDATE samples SET values_json=? WHERE id=?', updates)


def percent(used, total):
    return round(used * 100 / total, 3) if total else None


def snapshot():
    cpu = list(map(int, Path('/proc/stat').read_text().splitlines()[0].split()[1:9]))
    mem = {}
    for line in Path('/proc/meminfo').read_text().splitlines():
        k, value = line.split(':', 1)
        mem[k] = int(value.split()[0]) * 1024
    net = {}
    for line in Path('/proc/net/dev').read_text().splitlines()[2:]:
        name, values = line.split(':', 1)
        parts = values.split()
        net[name.strip()] = [int(parts[0]), int(parts[8])]
    return {'cpu': cpu, 'mem': mem, 'net': net,
            'boot': Path('/proc/sys/kernel/random/boot_id').read_text().strip(),
            'mono': time.monotonic()}


def interfaces(c, net):
    if c.get('network_interfaces'):
        return [n for n in c['network_interfaces'] if n in net]
    return [n for n in net if (Path('/sys/class/net') / n / 'device').exists()]


def speed_test(direction, size=SPEED_TEST_BYTES):
    conn = http.client.HTTPSConnection(SPEED_TEST_HOST, timeout=30)
    try:
        conn.connect()
        if direction == 'download':
            conn.request('GET', f'/__down?bytes={size}&cb={time.time_ns()}')
            response = conn.getresponse()
            if response.status != 200:
                raise OSError(f'speed test returned HTTP {response.status}')
            started = time.monotonic()
            transferred = 0
            while True:
                chunk = response.read(1024 * 1024)
                if not chunk:
                    break
                transferred += len(chunk)
        else:
            chunk = bytes(1024 * 1024)
            conn.putrequest('POST', '/__up')
            conn.putheader('Content-Type', 'application/octet-stream')
            conn.putheader('Content-Length', str(size))
            conn.endheaders()
            started = time.monotonic()
            remaining = size
            while remaining:
                part = chunk[:min(len(chunk), remaining)]
                conn.send(part)
                remaining -= len(part)
            response = conn.getresponse()
            if response.status < 200 or response.status >= 300:
                raise OSError(f'speed test returned HTTP {response.status}')
            response.read()
            transferred = size
        elapsed = time.monotonic() - started
        if transferred != size or elapsed <= 0:
            raise OSError('incomplete speed test transfer')
        return transferred * 8 / elapsed / 1_000_000
    finally:
        conn.close()


def measure_network_capacity(c):
    """Use short real transfers to estimate the best observed rate per direction."""
    names = interfaces(c, snapshot()['net'])
    if not names:
        return None
    measured = {'download': [], 'upload': []}
    for direction in measured:
        for _ in range(2):
            try:
                measured[direction].append(speed_test(direction))
            except Exception:
                continue
    download = max(measured['download'], default=0)
    upload = max(measured['upload'], default=0)
    if not download and not upload:
        return None
    rx = download or upload
    tx = upload or download
    return {
        'network_capacity_mbps': {name: max(rx, tx) for name in names},
        'network_capacity_rx_mbps': {name: rx for name in names},
        'network_capacity_tx_mbps': {name: tx for name in names},
        'network_capacity_source': f'measured upload/download via {SPEED_TEST_HOST} at {int(time.time())}',
    }


def disks(c):
    wanted = c.get('disk_mounts', [])
    result = []
    for line in Path('/proc/self/mountinfo').read_text().splitlines():
        left, right = line.split(' - ', 1)
        fields, fs = left.split(), right.split()
        mount = re.sub(r'\\([0-7]{3})', lambda m: chr(int(m[1], 8)), fields[4])
        # Loop-backed snap images are read-only and intentionally full.
        if ('ro' in fields[5].split(',') or 'ro' in fs[2].split(',')
                or fs[0] in {'squashfs', 'iso9660'} or fs[1].startswith('/dev/loop')):
            continue
        if (mount in wanted) if wanted else fs[1].startswith('/dev/'):
            if mount not in result:
                result.append(mount)
    return result


def make_samples(c, now, previous):
    rows = []
    def add(kind, obj, pct, values):
        rows.append((kind, obj, pct, values))
    elapsed = now['mono'] - previous['mono'] if previous else 0
    valid = bool(previous and now['boot'] == previous['boot'] and 0 < elapsed <= 180)
    if valid:
        delta = [a-b for a, b in zip(now['cpu'], previous['cpu'])]
        total = sum(delta)
        if total > 0 and min(delta) >= 0:
            add('cpu', 'all', percent(total-delta[3]-delta[4], total),
                {'iowait_percent': percent(delta[4], total), 'interval_seconds': elapsed,
                 'cores': os.cpu_count(), 'load_average': list(os.getloadavg())})
    m = now['mem']
    total, available = m['MemTotal'], m['MemAvailable']
    add('ram', 'all', percent(total-available, total),
        {'total_mb': total/1048576, 'used_mb': (total-available)/1048576, 'available_mb': available/1048576})
    total, free = m['SwapTotal'], m['SwapFree']
    add('swap', 'all', percent(total-free, total), {'total_mb': total/1048576, 'used_mb': (total-free)/1048576})
    for mount in disks(c):
        s = os.statvfs(mount)
        used = (s.f_blocks-s.f_bfree)*s.f_frsize
        avail = s.f_bavail*s.f_frsize
        add('disk', mount, percent(used, used+avail),
            {'total_gb': s.f_blocks*s.f_frsize/1073741824, 'used_gb': used/1073741824,
             'available_gb': avail/1073741824})
    for name in interfaces(c, now['net']):
        counters = now['net'][name]
        values = {'rx_mbps': None, 'tx_mbps': None, 'rx_mb_s': None, 'tx_mb_s': None}
        legacy_capacity = c.get('network_capacity_mbps', {}).get(name, 0)
        rx_capacity = c.get('network_capacity_rx_mbps', {}).get(name, legacy_capacity)
        tx_capacity = c.get('network_capacity_tx_mbps', {}).get(name, legacy_capacity)
        if rx_capacity > 0:
            values['rx_capacity_mbps'] = rx_capacity
        if tx_capacity > 0:
            values['tx_capacity_mbps'] = tx_capacity
        pct = None
        if valid and name in previous['net']:
            delta = [a-b for a,b in zip(counters, previous['net'][name])]
            if min(delta) >= 0:
                rx, tx = [v*8/elapsed/1000000 for v in delta]
                values.update(rx_mbps=rx, tx_mbps=tx, rx_mb_s=rx/8, tx_mb_s=tx/8,
                              interval_seconds=elapsed)
                percentages = []
                if rx_capacity > 0:
                    values['rx_percent'] = round(rx * 100 / rx_capacity, 6)
                    percentages.append(values['rx_percent'])
                if tx_capacity > 0:
                    values['tx_percent'] = round(tx * 100 / tx_capacity, 6)
                    percentages.append(values['tx_percent'])
                if percentages:
                    pct = max(percentages)
        add('network', name, pct, values)
    return rows


def collect(c):
    with connect() as db:
        old = db.execute("SELECT value FROM state WHERE key='previous'").fetchone()
    now = snapshot()
    rows = make_samples(c, now, json.loads(old[0]) if old else None)
    stamp = int(time.time())
    with connect() as db:
        db.executemany('INSERT INTO samples(ts,server_id,type,object,percent,values_json) VALUES(?,?,?,?,?,?)',
                       [(stamp,c['server_id'],kind,obj,pct,json.dumps(values)) for kind,obj,pct,values in rows])
        db.execute("INSERT OR REPLACE INTO state VALUES('previous',?)", (json.dumps(now),))
    print(f'Collected {len(rows)} resource records')


def nginx_line_minute(line):
    match = NGINX_TIME.search(line)
    if not match:
        return None
    try:
        stamp = dt.datetime.strptime(match.group(1).decode('ascii'), '%d/%b/%Y:%H:%M:%S %z').timestamp()
    except (UnicodeDecodeError, ValueError, OverflowError):
        return None
    return int(stamp) // 60 * 60


def read_nginx_log(path, offset, expected_inode=None):
    counts = {}
    with path.open('rb') as stream:
        info = os.fstat(stream.fileno())
        if expected_inode is not None and info.st_ino != expected_inode:
            return None
        if offset > info.st_size:
            offset = 0
        stream.seek(offset)
        while True:
            line_start = stream.tell()
            line = stream.readline()
            if not line:
                break
            if not line.endswith(b'\n'):
                stream.seek(line_start)
                break
            minute = nginx_line_minute(line)
            if minute is not None:
                counts[minute] = counts.get(minute, 0) + 1
        return {'inode': info.st_ino, 'offset': stream.tell()}, counts


def nginx_collect(c):
    """Count new Nginx access-log lines into completed one-minute SQLite samples."""
    path = Path(c.get('nginx_access_log', '/var/log/nginx/access.log'))
    if not path.is_file():
        raise FileNotFoundError(f'Nginx access log not found: {path}')
    with connect() as db:
        row = db.execute("SELECT value FROM state WHERE key='nginx_log_cursor'").fetchone()
        cursor = json.loads(row[0]) if row else None

    counts = {}
    previous_inode = cursor.get('inode') if cursor else None
    previous_offset = cursor.get('offset', 0) if cursor else 0
    if cursor:
        counts.update({int(minute):int(count) for minute,count in cursor.get('pending', {}).items()})
    current_info = path.stat()
    if previous_inode is not None and current_info.st_ino != previous_inode:
        rotated = Path(str(path) + '.1')
        if rotated.exists():
            old_result = read_nginx_log(rotated, previous_offset, previous_inode)
            if old_result:
                _, old_counts = old_result
                for minute, count in old_counts.items():
                    counts[minute] = counts.get(minute, 0) + count
        result = read_nginx_log(path, 0)
    else:
        result = read_nginx_log(path, previous_offset, previous_inode)
    if result is None:
        result = read_nginx_log(path, 0)
    cursor, new_counts = result
    for minute, count in new_counts.items():
        counts[minute] = counts.get(minute, 0) + count

    now = int(time.time())
    current_minute = now // 60 * 60
    # Even a quiet minute gets a zero sample so the API shows the actual rate.
    counts.setdefault(current_minute - 60, 0)
    cutoff = current_minute - int(c.get('retention_days', 5)) * 86400
    pending = {str(minute):count for minute,count in counts.items() if minute >= current_minute}
    with connect() as db:
        for minute, count in sorted(counts.items()):
            if minute >= current_minute or minute < cutoff:
                continue
            end = minute + 60
            old = db.execute("SELECT id,values_json FROM samples WHERE type='nginx_requests' AND object='nginx' AND ts=? ORDER BY id DESC LIMIT 1", (end,)).fetchone()
            if old:
                values = json.loads(old['values_json'])
                count += int(values.get('request_count', 0))
                db.execute('UPDATE samples SET percent=NULL,values_json=? WHERE id=?',
                           (json.dumps({'request_count':count,'window_start':minute,'window_end':end}), old['id']))
            else:
                db.execute('INSERT INTO samples(ts,server_id,type,object,percent,values_json) VALUES(?,?,?,?,?,?)',
                           (end,c['server_id'],'nginx_requests','nginx',None,
                            json.dumps({'request_count':count,'window_start':minute,'window_end':end})))
        cursor['pending'] = pending
        db.execute("INSERT OR REPLACE INTO state VALUES('nginx_log_cursor',?)", (json.dumps(cursor),))
    print(f'Collected Nginx access requests for {len(counts)} minute bucket(s)')


def credentials(path):
    values = {}
    for line in Path(path).read_text(encoding='utf-8-sig').splitlines():
        match = re.match(r'\s*(?:export\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*[:=]\s*(.*?)\s*$', line)
        if match:
            values[match[1]] = match[2].strip().strip('\"\'')
    token, chat = values.get('TOKEN_ADMIN_MONITOR'), values.get('ID_CHANNEL_MONITOR')
    if not token or not chat:
        raise ValueError('Telegram file requires TOKEN_ADMIN_MONITOR and ID_CHANNEL_MONITOR')
    return token, chat


def overloaded(db, c, stamp):
    latest = db.execute('SELECT MAX(ts) FROM samples').fetchone()[0]
    if latest is None or stamp-latest > 150:
        raise RuntimeError('Collector data is missing or stale')
    rows = db.execute('SELECT type,object,ts,percent FROM samples WHERE ts>? AND ts<=? AND percent IS NOT NULL ORDER BY ts,id',
                      (stamp-300, stamp)).fetchall()
    thresholds = {**DEFAULT_THRESHOLDS, **c.get('thresholds_percent', {})}
    mounts = set(disks(c))
    groups = {}
    for r in rows:
        if r['type'] not in DEFAULT_THRESHOLDS:
            continue
        if r['type'] == 'disk' and r['object'] not in mounts:
            continue
        # Reinstall/manual collection must not give one minute extra weight.
        groups.setdefault((r['type'],r['object']), {})[r['ts']//60] = r
    alerts = []
    for (kind,obj), minute_rows in sorted(groups.items()):
        values = list(minute_rows.values())[-5:]
        if stamp-values[-1]['ts'] > 150:
            continue
        if len(values) < 5:
            continue
        value = sum(r['percent'] for r in values)/len(values)
        if value > thresholds[kind]:
            alerts.append({'type': kind, 'object': obj, 'percent': round(value,2),
                           'threshold_percent': thresholds[kind], 'samples': len(values)})
    return alerts


def nginx_overloaded(db, c, stamp):
    threshold = int(c.get('nginx_alert_threshold_per_minute', 1000))
    current_end = stamp // 60 * 60
    rows = db.execute("""SELECT ts,values_json FROM samples
      WHERE type='nginx_requests' AND object='nginx' AND ts IN (?,?) ORDER BY ts""",
      (current_end - 60, current_end)).fetchall()
    alerts = []
    for row in rows:
        count = int(json.loads(row['values_json']).get('request_count', 0))
        if count > threshold:
            alerts.append({'type':'nginx_requests','object':'nginx','request_count':count,
                           'threshold_per_minute':threshold,'window_start':row['ts']-60,
                           'window_end':row['ts']})
    return alerts


def alert_message(c, alerts, stamp):
    title = ' '.join(str(c.get('server_name') or socket.gethostname()).split())
    labels = {'cpu': 'CPU', 'ram': 'RAM', 'disk': 'Ổ cứng', 'network': 'Network'}
    details = []
    for a in alerts:
        if a['type'] == 'nginx_requests':
            details.append(f"Nginx: {a['request_count']} request/phút (ngưỡng {a['threshold_per_minute']})")
            continue
        label = labels[a['type']]
        if a['type'] in {'disk','network'}:
            label += ' ' + ' '.join(str(a['object']).split())
        details.append(f"{label}: {a['percent']:.2f}%")
    date = dt.datetime.fromtimestamp(stamp, dt.timezone(dt.timedelta(hours=7))).strftime('%d/%m/%Y %H:%M')
    resource_details = [detail for detail in details if not detail.startswith('Nginx:')]
    nginx_details = [detail for detail in details if detail.startswith('Nginx:')]
    lines = [f"VPS {title}"]
    if resource_details:
        lines.append(' | '.join(resource_details) + ' (TB 5 phút)')
    lines.extend(nginx_details)
    lines.append(f'{date} (UTC+7)')
    return '\n'.join(lines)


def check(c, dry=False):
    stamp = int(time.time())
    with connect(readonly=True) as db:
        alerts = overloaded(db,c,stamp) + nginx_overloaded(db,c,stamp)
    if not alerts:
        print('No resource exceeds threshold')
        return
    if dry:
        print(json.dumps(alerts))
        return
    token, chat = credentials(os.environ.get('VPS_MONITOR_TELEGRAM', c['telegram_env']))
    message = alert_message(c, alerts, stamp)
    sent = False
    try:
        req = urllib.request.Request(f'https://api.telegram.org/bot{token}/sendMessage',
              data=urllib.parse.urlencode({'chat_id':chat,'text':message}).encode(), method='POST')
        with urllib.request.urlopen(req,timeout=10) as response:
            if not json.load(response).get('ok'):
                raise RuntimeError('Telegram rejected alert')
        sent = True
    except Exception:
        raise RuntimeError('Telegram delivery failed; verify credentials and connectivity') from None
    finally:
        with connect() as db:
            db.execute('INSERT INTO alerts(ts,server_id,details_json,sent) VALUES(?,?,?,?)',
                       (stamp,c['server_id'],json.dumps(alerts),int(sent)))


def cleanup(c):
    cutoff = int(time.time())-int(c['retention_days'])*86400
    for table in ('samples','alerts'):
        while True:
            with connect() as db:
                count = db.execute(f'DELETE FROM {table} WHERE id IN (SELECT id FROM {table} WHERE ts<? LIMIT 500)',(cutoff,)).rowcount
            if count < 500:
                break
    print('Retention cleanup completed')


def parse_time(value):
    if value.isdigit():
        return int(value)
    parsed = dt.datetime.fromisoformat(value.replace('Z','+00:00'))
    if parsed.tzinfo is None:
        raise ValueError('ISO timestamps require timezone')
    return int(parsed.timestamp())


def history(db, c, params, table='samples'):
    allowed = {'limit','cursor','from','to'} | ({'type','object','resolution'} if table=='samples' else set())
    if set(params)-allowed or any(len(v)!=1 for v in params.values()):
        raise ValueError('Unknown or duplicate query parameter')
    p = {k:v[0] for k,v in params.items()}
    limit = int(p.get('limit',c['api_default_limit']))
    if not 1 <= limit <= c['api_max_limit']:
        raise ValueError(f"limit must be 1..{c['api_max_limit']}")
    if p.get('resolution','minute') != 'minute':
        raise ValueError('Only minute resolution is supported')
    low = max(int(time.time())-c['retention_days']*86400, parse_time(p['from']) if 'from' in p else 0)
    high = parse_time(p['to']) if 'to' in p else int(time.time())
    if low > high:
        raise ValueError('Invalid time range')
    where, args = ['ts>=?','ts<=?'], [low,high]
    if 'type' in p:
        if p['type'] not in TYPES:
            raise ValueError('Invalid resource type')
        where.append('type=?'); args.append(p['type'])
    if 'object' in p:
        where.append('object=?'); args.append(p['object'])
    if 'cursor' in p:
        try:
            cursor = json.loads(base64.urlsafe_b64decode(p['cursor']))
            ts, ident = int(cursor[0]), int(cursor[1])
        except Exception:
            raise ValueError('Invalid cursor') from None
        where.append('(ts<? OR (ts=? AND id<?))'); args.extend([ts,ts,ident])
    args.append(limit+1)
    rows = db.execute(f"SELECT * FROM {table} WHERE {' AND '.join(where)} ORDER BY ts DESC,id DESC LIMIT ?",args).fetchall()
    more = len(rows)>limit
    result = [decode(r) for r in rows[:limit]]
    cursor = base64.urlsafe_b64encode(json.dumps([rows[limit-1]['ts'],rows[limit-1]['id']]).encode()).decode() if more else None
    return {'data':result,'count':len(result),'next_cursor':cursor}


def decode(row):
    r = dict(row)
    for key in ('values_json','details_json'):
        if key in r:
            r['values' if key=='values_json' else 'details'] = json.loads(r.pop(key))
    return r


class BoundedServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True
    request_queue_size = 8
    def __init__(self,*args):
        self.slots = __import__('threading').BoundedSemaphore(4)
        super().__init__(*args)
    def process_request(self,request,address):
        if not self.slots.acquire(False):
            request.close()
            return
        try:
            super().process_request(request,address)
        except Exception:
            self.slots.release()
            raise
    def process_request_thread(self,request,address):
        try:
            super().process_request_thread(request,address)
        finally:
            self.slots.release()


def serve(c):
    class Handler(BaseHTTPRequestHandler):
        def setup(self):
            self.request.settimeout(5)
            super().setup()
        def log_message(self,*args):
            pass
        def do_GET(self):
            try:
                if len(self.path)>4096:
                    raise ValueError('URL too long')
                url = urllib.parse.urlsplit(self.path)
                params = urllib.parse.parse_qs(url.query,keep_blank_values=True)
                with connect(readonly=True) as db:
                    if url.path == '/api/v1/metrics':
                        result = history(db,c,params)
                    elif url.path == '/api/v1/alerts':
                        result = history(db,c,params,'alerts')
                    elif url.path == '/api/v1/health':
                        last = db.execute('SELECT MAX(ts) FROM samples').fetchone()[0]
                        stale = last is None or time.time()-last>150
                        result = {'server_id':c['server_id'],'last_sample_at':last,'stale':stale}
                    elif url.path == '/api/v1/latest':
                        result = {'data':[decode(r) for r in db.execute('''SELECT s.* FROM samples s
                          JOIN (SELECT type,object,MAX(id) AS id FROM samples WHERE ts>=? GROUP BY type,object) x
                          ON s.id=x.id ORDER BY s.type,s.object''',(int(time.time())-c['retention_days']*86400,))]}
                    elif url.path == '/api/v1/info':
                        result = {'server_id':c['server_id'],'hostname':socket.gethostname(),'cores':os.cpu_count(),
                                  'retention_days':c['retention_days'],'units':{'percent':'%','memory':'MiB','disk':'GiB','network':'Mbps','network_mb_s':'MB/s'},
                                  'network_capacity_source':c.get('network_capacity_source'),
                                  'network_capacity_rx_mbps':c.get('network_capacity_rx_mbps',{}),
                                  'network_capacity_tx_mbps':c.get('network_capacity_tx_mbps',{}),
                                  'nginx_access_log':c.get('nginx_access_log','/var/log/nginx/access.log'),
                                  'nginx_alert_threshold_per_minute':c.get('nginx_alert_threshold_per_minute',1000),
                                  'objects':[dict(r) for r in db.execute('SELECT DISTINCT type,object FROM samples WHERE ts>=?',(int(time.time())-c['retention_days']*86400,))]}
                    else:
                        self.reply(404,{'error':'Not found'}); return
                self.reply(200,result)
            except (ValueError,TypeError,OverflowError):
                self.reply(400,{'error':'Invalid parameters; limit 1..1000, type cpu/ram/swap/disk/network, ISO timezone or Unix time'})
            except Exception:
                self.reply(503,{'error':'Data temporarily unavailable'})
        def reply(self,status,payload):
            data = json.dumps(payload,allow_nan=False).encode()
            self.send_response(status)
            self.send_header('Content-Type','application/json; charset=utf-8')
            self.send_header('Content-Length',str(len(data)))
            self.send_header('Cache-Control','no-store')
            self.end_headers()
            self.wfile.write(data)
    BoundedServer(('0.0.0.0',int(c['port'])),Handler).serve_forever()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('command',choices=['init','collect','nginx','check','cleanup','api','validate'])
    parser.add_argument('--dry-run',action='store_true')
    args = parser.parse_args()
    c = config()
    if args.command == 'validate':
        credentials(os.environ.get('VPS_MONITOR_TELEGRAM', c['telegram_env']))
        print('Telegram configuration valid (no message sent)')
        return
    if args.command == 'api':
        serve(c); return
    DATA.mkdir(parents=True,exist_ok=True)
    with (DATA/'job.lock').open('a') as lock:
        try:
            fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
        except BlockingIOError:
            print('Another job is running; skipping'); return
        {'init':init,'collect':lambda:collect(c),'nginx':lambda:nginx_collect(c),
         'check':lambda:check(c,args.dry_run),
         'cleanup':lambda:cleanup(c)}[args.command]()


if __name__ == '__main__':
    try:
        main()
    except Exception as exc:
        print(f'{type(exc).__name__}: {exc}',file=__import__('sys').stderr)
        raise SystemExit(1)
