#!/usr/bin/env bash
set -euo pipefail
sudo -u vps-resource-monitor env VPS_MONITOR_TELEGRAM=/etc/vps-resource-monitor/telegram.env python3 /opt/vps-resource-monitor/agent.py validate
sudo -u vps-resource-monitor python3 /opt/vps-resource-monitor/agent.py check --dry-run
port="$(sudo python3 -c 'import json; print(json.load(open("/etc/vps-resource-monitor/config.json"))["port"])')"
python3 - "$port" <<'PY'
import json,sys,urllib.request
for endpoint in ('health','metrics?type=ram&limit=2'):
    with urllib.request.urlopen('http://127.0.0.1:'+sys.argv[1]+'/api/v1/'+endpoint,timeout=5) as response:
        print(json.dumps(json.load(response),indent=2))
PY
