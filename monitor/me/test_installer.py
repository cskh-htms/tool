"""Run the actual installer twice in an isolated filesystem with simulated systemd.

No host services, users or files under /etc are changed. Real Python/SQLite,
install, bash and systemd-analyze verify are used.
"""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


MOCK = '''#!/usr/bin/env python3
import json,os,sys,subprocess
from pathlib import Path
tool=Path(sys.argv[0]).name
args=sys.argv[1:]
if tool=='id':
    raise SystemExit(0)
if tool=='runuser':
    raise SystemExit(subprocess.call(args[3:]))
if tool=='install':
    clean=[]
    i=0
    while i<len(args):
        if args[i] in ('-o','-g'): i+=2
        else: clean.append(args[i]); i+=1
    raise SystemExit(subprocess.call(['/usr/bin/install']+clean))
statefile=Path(os.environ['MOCK_STATE'])
s=json.loads(statefile.read_text()) if statefile.exists() else {'enabled':[], 'active':[], 'calls':[]}
cmd=args[0]
units=[a for a in args[1:] if not a.startswith('-')]
if cmd=='cat':
    raise SystemExit(0 if (Path(os.environ['MOCK_UNITS'])/units[0]).exists() else 1)
if cmd=='is-active':
    raise SystemExit(0 if all(u in s['active'] for u in units) else 1)
s['calls'].append(args)
if cmd=='stop': s['active']=[u for u in s['active'] if u not in units]
if cmd=='enable': s['enabled']=sorted(set(s['enabled']+units))
if cmd=='restart': s['active']=sorted(set(s['active']+units))
statefile.write_text(json.dumps(s))
'''


class InstallerTests(unittest.TestCase):
    def test_install_twice_preserves_data_and_invalid_config_keeps_service_running(self):
        original = Path(__file__).resolve().parents[2]
        with tempfile.TemporaryDirectory(prefix='monitor-install-') as folder:
            root=Path(folder)
            repo=root/'checkout with spaces'
            shutil.copytree(original/'monitor/me',repo/'monitor/me')
            (repo/'scripts/monitor-me').mkdir(parents=True)
            script=(original/'scripts/monitor-me/install.sh').read_text()
            script=script.replace('if (( EUID != 0 )); then','if false; then')
            script=script.replace('if [[ ! -f /etc/debian_version || ! -d /run/systemd/system ]]; then','if false; then')
            paths=('/etc/vps-resource-monitor','/opt/vps-resource-monitor',
                   '/var/lib/vps-resource-monitor','/etc/systemd/system','/run/lock')
            for path in paths:
                script=script.replace(path,str(root)+path)
            (root/'run/lock').mkdir(parents=True)
            units=root/'etc/systemd/system';units.mkdir(parents=True)
            installer=repo/'scripts/monitor-me/install.sh';installer.write_text(script)
            for name in ('status','test','uninstall'):
                shutil.copyfile(original/'scripts/monitor-me'/(name+'.sh'),installer.parent/(name+'.sh'))
            binary=root/'bin';binary.mkdir()
            mock=binary/'mock';mock.write_text(MOCK);mock.chmod(0o755)
            for name in ('systemctl','runuser','install','id'):
                (binary/name).symlink_to(mock)
            telegram=root/'user_one_htms/telegram/.env.telegram'
            telegram.parent.mkdir(parents=True)
            telegram.write_text('TOKEN_ADMIN_MONITOR=123:TEST\nID_CHANNEL_MONITOR=-100123\n')
            config=root/'etc/vps-resource-monitor/config.json'
            data=root/'var/lib/vps-resource-monitor'
            state=root/'systemd-state.json'
            env=dict(os.environ,PATH=str(binary)+':'+os.environ['PATH'],TELEGRAM_ENV=str(telegram),
                     VPS_MONITOR_CONFIG=str(config),VPS_MONITOR_DATA=str(data),
                     MOCK_STATE=str(state),MOCK_UNITS=str(units))
            def run():
                return subprocess.run(['bash',str(installer)],env=env,cwd='/tmp',capture_output=True,text=True)
            first=run()
            self.assertEqual(first.returncode,0,first.stdout+first.stderr)
            settings=json.loads(config.read_text());settings['port']=9201;settings['server_id']='keep-id'
            config.write_text(json.dumps(settings))
            import sqlite3
            with sqlite3.connect(data/'metrics.sqlite3') as db:
                db.execute("INSERT INTO state VALUES('keep-test','preserved')")
            second=run()
            self.assertEqual(second.returncode,0,second.stdout+second.stderr)
            self.assertEqual(json.loads(config.read_text())['port'],9201)
            self.assertEqual(json.loads(config.read_text())['server_id'],'keep-id')
            with sqlite3.connect(data/'metrics.sqlite3') as db:
                self.assertEqual(db.execute("SELECT value FROM state WHERE key='keep-test'").fetchone()[0],'preserved')
            systemd=json.loads(state.read_text())
            self.assertEqual(len(systemd['enabled']),5)
            self.assertEqual(len(list(units.glob('*.service'))),5)
            self.assertEqual(len(list(units.glob('*.timer'))),4)
            self.assertIn('StartLimitIntervalSec=0',(units/'vps-resource-collect.service').read_text())
            self.assertIn('StartLimitIntervalSec=300',(units/'vps-resource-api.service').read_text())
            self.assertIn('vps-resource-api.service',systemd['active'])
            before=state.read_text()
            telegram.write_text('WRONG=value\n')
            third=run()
            self.assertNotEqual(third.returncode,0)
            self.assertEqual(state.read_text(),before)
            for unit in units.glob('*'):
                self.assertNotIn(str(repo),unit.read_text())
            installed=root/'opt/vps-resource-monitor'
            self.assertTrue((installed/'scripts/status.sh').is_file())
            # Hide the checkout and original Telegram file; installed service
            # must still validate credentials and collect real host metrics.
            repo.rename(root/'checkout-hidden')
            telegram.unlink()
            for job in ('validate','collect','check'):
                args=['python3','-B',str(installed/'agent.py'),job]
                if job=='check':args.append('--dry-run')
                r=subprocess.run(args,env=env,capture_output=True,text=True)
                self.assertEqual(r.returncode,0,r.stdout+r.stderr)


if __name__=='__main__': unittest.main()
