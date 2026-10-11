#!/usr/bin/env bash
# VPS-Bench v2: standalone cpu test. Copy this file alone to Ubuntu/Debian.
set -euo pipefail
export LC_ALL=C
export LANG=C
# Let --help run even before python3 is installed.
if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]] && ! command -v python3 >/dev/null; then
    echo 'Chay: sudo bash test-cpu.sh; --seconds N; --rounds N; --no-install; --quick'
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

COMPONENT = 'cpu'
p = argparse.ArgumentParser(description='VPS-Bench: '+COMPONENT+' doc lap, Ubuntu/Debian')
p.add_argument('--seconds', type=int, default=10, help='Giay moi bai con, mac dinh 10')
p.add_argument('--rounds', type=int, default=2, help='So luot, mac dinh 2')
p.add_argument('--output-dir', default='./vps-bench-results')
p.add_argument('--no-install', action='store_true')
p.add_argument('--quick', action='store_true', help='3 giay x 1 luot, chi kiem tra')
p.add_argument('--sustained', type=int, default=0, help='Them bai CPU chay lien tuc N giay, mac dinh tat')
p.set_defaults(**{'vn_host': '', 'vn_port': 5201, 'vn_server_id': None, 'skip_network': True, 'disk_dir': '.'})
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
                               '. Chay sudo bash test-cpu.sh hoac cai bang apt-get.')
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

def cpu_test():
    threads = len(os.sched_getaffinity(0))
    report['machine']['available_cpu_threads'] = threads
    for key, count in [('cpu_single', 1), ('cpu_multi', threads)]:
        samples = []
        for n in range(rounds):
            print(f'  {key}: luot {n+1}/{rounds}, {count} luong', flush=True)
            text = run(['sysbench', 'cpu', '--cpu-max-prime=20000',
                        f'--threads={count}', f'--time={duration}', '--events=0', 'run'],
                       f'{key}-{n+1}', duration+45)
            samples.append(float(re.search(r'events per second:\s*([\d.]+)', text)[1]))
        collect(key, samples, 'events/s')
    report['scores']['cpu'] = .2*score('cpu_single') + .8*score('cpu_multi')

def sustained_test():
    text = run(['sysbench', 'cpu', '--cpu-max-prime=20000',
                f"--threads={report['machine']['available_cpu_threads']}",
                f'--time={sustain_time}', '--events=0', '--report-interval=1', 'run'],
               'cpu-sustained', sustain_time+45)
    samples = [float(x) for x in re.findall(r'eps:\s*([\d.]+)', text)]
    if len(samples) < 4:
        raise ValueError('Khong co du mau CPU sustained')
    part = max(1, len(samples)//3)
    first, last = statistics.median(samples[:part]), statistics.median(samples[-part:])
    report['sustained_cpu'] = {'seconds': sustain_time, 'samples_eps': samples,
                              'first_third_eps': first, 'last_third_eps': last,
                              'drop_percent': (first-last)/value(first)*100}
    effective = min(report['metrics']['cpu_multi']['median'], statistics.median(samples))
    report['sustained_cpu']['effective_multi_eps'] = effective
    report['scores']['cpu'] = .2*score('cpu_single') + .8*effective/BASE['cpu_multi']*100
    if last < first*.85:
        report['warnings'].append('CPU giam tren 15% trong bai chay lien tuc')






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
    guarded('Dang do cpu...', cpu_test)
    if args.sustained and 'cpu' in report['scores']:
        guarded('Do CPU lien tuc...', sustained_test)
        if 'sustained_cpu' not in report:
            report['scores'].pop('cpu', None)
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
