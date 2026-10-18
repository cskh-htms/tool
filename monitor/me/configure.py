"""Validate and stage installer configuration before stopping existing services."""
import json
import os
from pathlib import Path
import socket
import sys
sys.dont_write_bytecode = True
from agent import credentials, DEFAULT_THRESHOLDS, measure_network_capacity
from telegram_paths import deployment_homes, resolve_telegram


def prepare(source, destination, stage, repo):
    defaults = json.loads((source / 'config.example.json').read_text())
    config_file = destination / 'config.json'
    if config_file.exists():
        defaults.update(json.loads(config_file.read_text()))
    c = defaults
    c.pop('threshold_percent', None)
    c['thresholds_percent'] = {**DEFAULT_THRESHOLDS, **c.get('thresholds_percent', {})}
    if any(not isinstance(v,(int,float)) or not 0 <= v <= 100 for v in c['thresholds_percent'].values()):
        raise ValueError('Resource thresholds must be 0..100')
    if not isinstance(c.get('nginx_alert_threshold_per_minute', 1000), int) or c.get('nginx_alert_threshold_per_minute', 1000) < 1:
        raise ValueError('Nginx request threshold must be a positive integer per minute')
    c.setdefault('nginx_access_log', '/var/log/nginx/access.log')
    measured = measure_network_capacity(c)
    if measured:
        c.update(measured)
    else:
        for key in ('network_capacity_mbps', 'network_capacity_rx_mbps',
                    'network_capacity_tx_mbps', 'network_capacity_source'):
            c.pop(key, None)
    c.pop('network_capacity_baseline_mbps', None)
    chosen = resolve_telegram(deployment_homes(repo), os.environ.get('TELEGRAM_ENV'),
                              c.get('telegram_source') or c.get('telegram_env'))
    token, chat = credentials(chosen)
    if not 1 <= int(c['port']) <= 65535:
        raise ValueError('API port must be 1..65535')
    c['telegram_source'] = str(chosen)
    c['telegram_env'] = str(destination / 'telegram.env')
    if not c.get('server_id'):
        machine = Path('/etc/machine-id').read_text().strip()[:12]
        c['server_id'] = socket.gethostname() + '-' + machine
    c['retention_days'] = 5
    (stage / 'config.json').write_text(json.dumps(c, indent=2) + '\n')
    (stage / 'telegram.env').write_text('TOKEN_ADMIN_MONITOR=' + token + '\nID_CHANNEL_MONITOR=' + chat + '\n')
    for name in ('config.json', 'telegram.env'):
        (stage / name).chmod(0o600)
    print('File Telegram monitor: ' + str(chosen))


if __name__ == '__main__':
    try:
        prepare(*(Path(arg) for arg in sys.argv[1:]))
    except Exception as exc:
        print('Không thể chuẩn bị cấu hình: ' + str(exc), file=sys.stderr)
        raise SystemExit(1)
