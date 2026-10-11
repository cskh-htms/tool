#!/usr/bin/env bash
# VPS-Bench v2: standalone network test. Copy this file alone to Ubuntu/Debian.
set -euo pipefail
export LC_ALL=C
export LANG=C
# Let --help run even before python3 is installed.
if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]] && ! command -v python3 >/dev/null; then
    echo 'Chay: sudo bash test-mang.sh; --seconds N; --rounds N; --no-install; --quick'
    exit 0
fi
install=1
for arg in "$@"; do
    [[ "$arg" != "--no-install" ]] || install=0
done
if ! command -v python3 >/dev/null; then
    if [[ "$install" == 0 || "$EUID" != 0 ]] || ! command -v apt-get >/dev/null; then
        echo 'Can python3. Tren Ubuntu/Debian: sudo apt-get install -y python3' >&2
        exit 1
    fi
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3
fi

exec python3 - "$@" <<'PYTHON'
import argparse
import datetime
import fcntl
import json
import math
import os
from pathlib import Path
import platform
import re
import shutil
import signal
import statistics
import subprocess
import sys
import tempfile
import time

VERSION = '2.0.0'
BASE = {'cpu_single': 1000, 'cpu_multi': 2000,
        'ram_read': 10240, 'ram_write': 10240,  # MiB/s
        'download': 500, 'upload': 500,         # Mbps
        'seq_read': 512, 'seq_write': 512,      # MiB/s
        'rand_read': 10000, 'rand_write': 10000,  # IOPS
        'read_p95': 2, 'write_p95': 2}          # milliseconds
# Independent component scores; no combined VPS score.

COMPONENT = 'network'
p = argparse.ArgumentParser(description='VPS-Bench: '+COMPONENT+' doc lap, Ubuntu/Debian')
p.add_argument('--seconds', type=int, default=10, help='Giay moi chieu iperf3; Speedtest tu quyet dinh thoi gian')
p.add_argument('--rounds', type=int, default=2, help='So luot, mac dinh 2')
p.add_argument('--output-dir', default='./vps-bench-results')
p.add_argument('--no-install', action='store_true')
p.add_argument('--quick', action='store_true', help='3 giay x 1 luot, chi kiem tra')
p.add_argument('--vn-server-id', type=int, default=26853, help='ID Speedtest VN, mac dinh Viettel TP.HCM 26853; 0=tu chon VN')
p.add_argument('--vn-host', default='', help='Dau do iperf3 rieng tai VN, neu muon')
p.add_argument('--vn-port', type=int, default=5201)
p.set_defaults(**{'skip_network': False, 'disk_dir': '.', 'sustained': 0})
args = p.parse_args()
if not 1 <= args.seconds <= 120 or not 1 <= args.rounds <= 10:
    p.error('--seconds: 1..120; --rounds: 1..10')
if args.sustained and not 10 <= args.sustained <= 3600:
    p.error('--sustained: 10..3600 giay')
if not 1 <= args.vn_port <= 65535 or args.vn_host.startswith('-') or any(c.isspace() for c in args.vn_host):
    p.error('Dia chi/cong mang khong hop le')
if args.vn_server_id is not None and args.vn_server_id < 0:
    p.error('--vn-server-id phai >= 0')

disk_dir = Path(args.disk_dir).resolve()
if not disk_dir.is_dir():
    p.error('--disk-dir phai la thu muc da ton tai')
out_root = Path(args.output_dir).resolve()
out_root.mkdir(parents=True, exist_ok=True)
# Serialize benchmarks to avoid competing with another instance on this machine.
lock_path = Path('/tmp/vps-bench-v1.lock')
flags = os.O_CREAT | os.O_RDWR | getattr(os, 'O_NOFOLLOW', 0)
lock_fd = os.open(str(lock_path), flags, 0o600)
try:
    fcntl.flock(lock_fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
except BlockingIOError:
    sys.exit('Mot VPS-Bench khac dang chay. Hay doi no ket thuc.')

duration = 3 if args.quick else args.seconds
rounds = 1 if args.quick else args.rounds
sustain_time = args.sustained
disk_size = 128 * 1024**2 if args.quick else 2 * 1024**3
report_dir = Path(tempfile.mkdtemp(prefix=datetime.datetime.now().strftime('%Y%m%d-%H%M%S-'),
                                 dir=str(out_root)))
profile = f'{COMPONENT}-v2-{duration}s-{rounds}rounds-sustained{sustain_time}'
if args.quick:
    profile += '-quick'
report = {'benchmark': 'VPS-Bench', 'version': VERSION, 'profile': profile,
          'started_at': datetime.datetime.now(datetime.timezone.utc).isoformat(),
          'component': COMPONENT, 'baselines': BASE, 'metrics': {}, 'scores': {},
          'score_rules': {'cpu': '20% single + 80% multi; optional sustained caps multi at sustained median',
                          'ram': '50% read + 50% write; capacity excluded',
                          'network': '50% download + 50% upload',
                          'io': '25% sequential + 50% random IOPS + 25% inverse p95 latency',
                          'latency_subscore_cap': 500,
                          'baseline_status': 'fixed conventional references, not calibrated hardware'},
          'errors': [], 'warnings': [], 'tools': {},
          'config': {'seconds': duration, 'rounds': rounds, 'sustain_seconds': sustain_time,
                     'disk_bytes': disk_size, 'disk_dir': str(disk_dir),
                     'network_method': 'iperf3-TCP-4-streams' if args.vn_host else 'speedtest-cli-HTTP-4-threads',
                     'vn_host': args.vn_host or None, 'vn_port': args.vn_port,
                     'endpoint_location': 'Vietnam, operator supplied' if args.vn_host else None}}
active = None

def stop(signum, frame):
    raise KeyboardInterrupt

signal.signal(signal.SIGTERM, stop)

def run(cmd, name, timeout):
    global active
    log = report_dir / (name + '.log')
    with log.open('w', encoding='utf-8') as f:
        f.write('COMMAND: ' + json.dumps(cmd) + '\n')
        f.flush()
        active = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                  text=True, start_new_session=True)
        try:
            output, _ = active.communicate(timeout=timeout)
        except BaseException as e:
            os.killpg(active.pid, signal.SIGTERM)
            try:
                partial, _ = active.communicate(timeout=3)
            except subprocess.TimeoutExpired:
                os.killpg(active.pid, signal.SIGKILL)
                partial, _ = active.communicate()
            f.write(partial or '')
            if isinstance(e, subprocess.TimeoutExpired):
                raise RuntimeError(f'{name}: qua thoi gian {timeout}s; xem {log.name}') from None
            raise
        finally:
            proc = active
            active = None
        f.write(output)
    if proc.returncode:
        raise RuntimeError(f'{name}: exit {proc.returncode}; xem {log.name}')
    return output

def value(x):
    x = float(x)
    if not math.isfinite(x) or x <= 0:
        raise ValueError('Ket qua khong hop le/khong du du lieu')
    return x

def collect(key, samples, unit):
    vals = [value(x) for x in samples]
    if len(vals) != rounds:
        raise ValueError('Khong du so luot do')
    mid = statistics.median(vals)
    report['metrics'][key] = {'samples': vals, 'median': mid, 'min': min(vals),
                             'max': max(vals), 'unit': unit,
                             'spread_percent': (max(vals)-min(vals))/mid*100}
    if len(vals) > 1 and (max(vals)-min(vals))/mid > .2:
        report['warnings'].append(f'{key}: dao dong tren 20%, nen do lai vao gio khac')
    return mid

def score(key):
    return report['metrics'][key]['median'] / BASE[key] * 100

def guarded(label, fn):
    print(label, flush=True)
    try:
        fn()
    except (Exception,) as e:
        report['errors'].append(f'{label}: {e}')
        print(f'  CHUA DO DUOC: {e}', flush=True)

def memory_info():
    result = {}
    for line in Path('/proc/meminfo').read_text().splitlines():
        key, val = line.split(':', 1)
        result[key] = int(val.split()[0]) * 1024
    # Respect the common cgroup v2 memory limit, including containerized VPS.
    try:
        relative = next(line.split(':', 2)[2] for line in Path('/proc/self/cgroup').read_text().splitlines()
                        if line.startswith('0::'))
        cgroup = Path('/sys/fs/cgroup') / relative.lstrip('/')
        # Namespace mount can already be rooted at this cgroup.
        if not (cgroup / 'memory.max').exists():
            cgroup = Path('/sys/fs/cgroup')
        raw = (cgroup / 'memory.max').read_text().strip()
        if raw != 'max':
            limit = int(raw)
            current = int((cgroup / 'memory.current').read_text())
            result['MemTotal'] = min(result['MemTotal'], limit)
            result['MemAvailable'] = min(result['MemAvailable'], max(0, limit-current))
    except (OSError, StopIteration, ValueError):
        pass
    return result

def cpu_stat():
    vals = [int(v) for v in Path('/proc/stat').read_text().splitlines()[0].split()[1:]]
    return sum(vals[:8]), vals[7] if len(vals) > 7 else 0

def dependencies():
    tools = ['sysbench'] if COMPONENT in ('cpu', 'ram') else ['fio'] if COMPONENT == 'io' else ['iperf3'] if args.vn_host else []
    missing = [tool for tool in tools
               if not shutil.which(tool)]
    if not args.vn_host and not args.skip_network:
        probe = subprocess.run([sys.executable, '-c', 'import speedtest'], capture_output=True)
        if probe.returncode:
            missing.append('speedtest-cli')
    if missing:
        if args.no_install or os.geteuid() != 0 or not shutil.which('apt-get'):
            raise RuntimeError('Thieu ' + ', '.join(missing) +
                               '. Chay sudo bash test-mang.sh hoac cai bang apt-get.')
        print('Dang cai: ' + ', '.join(missing), flush=True)
        env = os.environ.copy()
        env['DEBIAN_FRONTEND'] = 'noninteractive'
        subprocess.run(['apt-get', 'update'], check=True, env=env)
        # Prevent iperf3 package prompts from enabling a background test server.
        if 'iperf3' in missing and shutil.which('debconf-set-selections'):
            subprocess.run(['debconf-set-selections'],
                           input='iperf3 iperf3/start_daemon boolean false\n',
                           text=True, check=True, env=env)
        subprocess.run(['apt-get', 'install', '-y', *missing], check=True, env=env)
    for tool in tools:
        version = run([tool, '--version'], 'version-' + tool, 15).strip()
        report['tools'][tool] = version
        if tool == 'fio' and not re.search(r'\bfio-\d', version):
            raise RuntimeError('Lenh fio khong phai Flexible I/O Tester')
    if not args.vn_host and not args.skip_network:
        report['tools']['speedtest-cli'] = run(
            [sys.executable, '-m', 'speedtest', '--version'], 'version-speedtest', 15).strip()





SPEEDTEST_WORKER = r'''
import json, sys, speedtest, urllib.request, xml.etree.ElementTree as ET
mode, server_id = sys.argv[1:3]
st = speedtest.Speedtest(secure=True, timeout=10)
# The ordinary server list may contain only nearby foreign endpoints when the
# VPS is overseas. Seed verified VN endpoints so discovery never goes abroad.
# Source: https://c.speedtest.net/speedtest-servers-static.php, 2026-10-11.
vn = [
 {'id':'17758','name':'Ho Chi Minh','sponsor':'VNPT-NET','cc':'VN','country':'Vietnam',
  'lat':'10.7500','lon':'106.6667','host':'speedtest3.vtn.com.vn:8080',
  'url':'http://speedtest3.vtn.com.vn:8080/speedtest/upload.php'},
 {'id':'26853','name':'Ho Chi Minh','sponsor':'Viettel Network','cc':'VN','country':'Vietnam',
  'lat':'10.7500','lon':'106.6667','host':'speedtestkv3b.viettel.vn:8080',
  'url':'http://speedtestkv3b.viettel.vn:8080/speedtest/upload.php'},
 {'id':'55435','name':'Da Nang','sponsor':'MobiFone','cc':'VN','country':'Vietnam',
  'lat':'16.0545','lon':'108.0717','host':'dn1.mobifone.vn:8080',
  'url':'http://dn1.mobifone.vn:8080/speedtest/upload.php'},
]
try:
    request = urllib.request.Request('https://c.speedtest.net/speedtest-servers-static.php',
                                     headers={'User-Agent':'Mozilla/5.0'})
    root = ET.fromstring(urllib.request.urlopen(request, timeout=10).read())
    updated = [dict(s.attrib) for s in root.iter('server') if s.get('cc','').upper() == 'VN']
    by_id = {s['id']:s for s in vn}
    by_id.update({s['id']:s for s in updated})
    vn = list(by_id.values())
except (OSError, ET.ParseError):
    pass
if server_id:
    vn = [s for s in vn if str(s['id']) == server_id]
if not vn:
    raise RuntimeError('Khong tim thay may chu Speedtest Viet Nam; khong dung may chu quoc te')
# Ensure best-server selection only probes Vietnamese test endpoints.
for s in vn:
    s['d'] = speedtest.distance(st.lat_lon, (float(s['lat']),float(s['lon'])))
st.get_best_server(servers=vn)
if st.results.server.get('cc', '').upper() != 'VN':
    raise RuntimeError('Dau do khong thuoc VN')
if st.results.server.get('latency', 3600000) >= 3600000:
    raise RuntimeError('Tat ca dau do Viet Nam khong truy cap duoc')
if mode == 'discover':
    print(json.dumps(st.results.server))
else:
    st.download(threads=4)
    st.upload(threads=4, pre_allocate=False)
    print(json.dumps(st.results.dict()))
'''

def public_network_test():
    server_id = str(args.vn_server_id or '')
    server = json.loads(run([sys.executable, '-c', SPEEDTEST_WORKER, 'discover', server_id],
                            'network-vn-discover', 120))
    if server.get('cc', '').upper() != 'VN':
        raise RuntimeError('Tu choi dau do khong phai Viet Nam')
    server_id = str(server['id'])
    report['network_server'] = server
    print(f"  Speedtest Viet Nam: {server.get('sponsor')} / {server.get('name')} / ID {server_id}", flush=True)
    samples = {'download': [], 'upload': []}
    total_bytes = 0
    for n in range(rounds):
        print(f'  Mang: luot {n+1}/{rounds}', flush=True)
        data = json.loads(run([sys.executable, '-c', SPEEDTEST_WORKER, 'test', server_id],
                              f'network-vn-{n+1}', 180))
        if str(data['server']['id']) != server_id or data['server'].get('cc', '').upper() != 'VN':
            raise RuntimeError('Dau do da thay doi, khong tinh diem')
        for key in samples:
            samples[key].append(value(data[key])/1e6)
        total_bytes += data.get('bytes_received', 0) + data.get('bytes_sent', 0)
    for key, vals in samples.items():
        collect(key, vals, 'Mbps')
    report['network_measured_bytes'] = total_bytes
    report['scores']['network'] = (score('download')+score('upload'))/2
    report['warnings'].append(f'De so sanh VPS khac, dung --vn-server-id {server_id} va cung phien ban cong cu.')
    report['warnings'].append('Speedtest-cli HTTP co the bi gioi han boi CPU/Python/dau do; khong khang dinh toc do toi da cong mang.')

def network_test():
    if args.skip_network:
        raise RuntimeError('Da chon --skip-network')
    if not args.vn_host:
        return public_network_test()
    print(f'  Dau do Viet Nam do ban cung cap: {args.vn_host}:{args.vn_port}', flush=True)
    total_bytes = 0
    for key, reverse in [('upload', False), ('download', True)]:
        samples = []
        for n in range(rounds):
            cmd = ['iperf3', '-c', args.vn_host, '-p', str(args.vn_port), '-P', '4',
                   '-t', str(duration), '-O', '2', '--connect-timeout', '5000', '-J']
            if reverse:
                cmd.append('-R')
            raw = run(cmd, f'network-{key}-{n+1}', duration+35)
            data = json.loads(raw)
            if data.get('error'):
                raise RuntimeError(data['error'])
            stats = data['end']['sum_received']
            samples.append(stats['bits_per_second']/1e6)
            total_bytes += stats.get('bytes', 0)
        collect(key, samples, 'Mbps')
    report['network_measured_bytes'] = total_bytes
    report['scores']['network'] = (score('download')+score('upload'))/2
    report['warnings'].append('So sanh diem mang chi khi cung dau do Viet Nam va phuong phap iperf3.')

def finish():
    scores = report['scores']
    report['complete'] = COMPONENT in scores
    report['finished_at'] = datetime.datetime.now(datetime.timezone.utc).isoformat()
    points = f'{scores[COMPONENT]:.1f}' if report['complete'] else 'CHUA DO DUOC'
    label = {'cpu':'CPU','ram':'RAM','network':'MANG','io':'I/O'}[COMPONENT]
    lines = ['', '========== KET QUA '+label+' ==========',
             f'VPS-Bench {VERSION} | {profile}', 'DIEM '+label+' : '+points,
             '100 la moc co dinh; diem co the vuot 100.']
    if args.quick:
        lines.append('QUICK chi kiem tra; khong so sanh voi profile mac dinh.')
    for key, metric in report['metrics'].items():
        lines.append(f"{key}: {metric['median']:.2f} {metric['unit']} | dao dong {metric['spread_percent']:.1f}%")
    for category in ['errors', 'warnings']:
        for item in report[category]:
            lines.append(('LOI: ' if category == 'errors' else 'GHI CHU: ')+item)
    lines.append('Bao cao: '+str(report_dir))
    text = '\n'.join(lines)+'\n'
    (report_dir/'report.json').write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n')
    (report_dir/'report.txt').write_text(text)
    print(text, flush=True)

print(f'VPS-Bench {VERSION} | {profile} | bao cao: {report_dir}', flush=True)
print('Chi benchmark '+COMPONENT+'.', flush=True)
if COMPONENT == 'network':
    print('Chi do mang toi may chu Viet Nam.', flush=True)
before = cpu_stat()
try:
    mem = memory_info()
    report['machine'] = {'hostname': platform.node(), 'kernel': platform.release(),
                         'architecture': platform.machine(), 'load_before': os.getloadavg(),
                         'memory_total_bytes': mem['MemTotal'],
                         'memory_available_before_bytes': mem['MemAvailable'],
                         'python': platform.python_version()}
    for name, path in [('cpuinfo', '/proc/cpuinfo'), ('cgroup', '/proc/self/cgroup')]:
        (report_dir/(name+'.txt')).write_text(Path(path).read_text())
    dependencies()
    guarded('Dang do network...', network_test)
except KeyboardInterrupt:
    report['errors'].append('Nguoi dung dung benchmark; ket qua chua hoan tat.')
except Exception as e:
    report['errors'].append(str(e))
finally:
    after = cpu_stat()
    elapsed_ticks = after[0]-before[0]
    report['machine_cpu_steal_percent'] = ((after[1]-before[1])/elapsed_ticks*100
                                         if elapsed_ticks > 0 else None)
    if (report['machine_cpu_steal_percent'] or 0) > 5:
        report['warnings'].append('CPU steal trung binh tren 5% (toan may); co the tranh chap tai nguyen host.')
    finish()
sys.exit(0 if report['complete'] else 2)
PYTHON
