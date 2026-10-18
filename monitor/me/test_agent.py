import importlib.util
import json
from pathlib import Path
import tempfile
import time
import unittest
import sys
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('agent', Path(__file__).with_name('agent.py'))
agent = importlib.util.module_from_spec(spec)
spec.loader.exec_module(agent)
sys.path.insert(0,str(Path(__file__).parent))
from telegram_paths import resolve_telegram, deployment_homes
from configure import prepare


class MonitorTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.old = agent.DATA
        agent.DATA = Path(self.tmp.name)
        agent.init()
        self.c = {'server_id':'test','thresholds_percent':dict(agent.DEFAULT_THRESHOLDS),'retention_days':5,
                  'api_default_limit':100,'api_max_limit':1000,
                  'network_interfaces':['eth0'],'network_capacity_mbps':{'eth0':100}}
        self.stamp = int(time.time())

    def tearDown(self):
        agent.DATA = self.old
        self.tmp.cleanup()

    def insert(self, ts, kind='ram', pct=80, obj='all'):
        with agent.connect() as db:
            db.execute('INSERT INTO samples(ts,server_id,type,object,percent,values_json) VALUES(?,?,?,?,?,?)',
                       (ts,'test',kind,obj,pct,'{}'))

    def test_quiet_for_normal_ram_and_old_snap_records(self):
        for seconds in (240,180,120,60,0):
            self.insert(self.stamp-seconds,'ram',86)
            self.insert(self.stamp-seconds,'swap',100)
            self.insert(self.stamp-seconds,'disk',100,'/snap/core/123')
            self.insert(self.stamp-seconds,'disk',25,'/')
        with patch.object(agent,'disks',return_value=['/']),patch.object(agent,'credentials',side_effect=AssertionError('must be silent')):
            agent.check(self.c)

    def test_individual_thresholds_and_average_for_every_type(self):
        for kind,threshold in agent.DEFAULT_THRESHOLDS.items():
            obj='/' if kind=='disk' else 'all'
            # Four low minutes and one spike: average stays below threshold.
            for seconds in (240,180,120,60):self.insert(self.stamp-seconds,kind,threshold-10,obj)
            self.insert(self.stamp,kind,100,obj)
        with patch.object(agent,'disks',return_value=['/']),agent.connect() as db:
            self.assertEqual(agent.overloaded(db,self.c,self.stamp),[])
            db.execute('DELETE FROM samples')
        for kind,threshold in agent.DEFAULT_THRESHOLDS.items():
            obj='/' if kind=='disk' else 'all'
            for seconds in (240,180,120,60,0):self.insert(self.stamp-seconds,kind,threshold,obj)
        with patch.object(agent,'disks',return_value=['/']),agent.connect() as db:
            self.assertEqual(agent.overloaded(db,self.c,self.stamp),[])
            db.execute('UPDATE samples SET percent=percent+1')
            alerts=agent.overloaded(db,self.c,self.stamp)
            self.assertEqual({a['type'] for a in alerts},set(agent.DEFAULT_THRESHOLDS))
            self.assertTrue(all(a['samples']==5 for a in alerts))

    def test_readonly_and_loop_mounts_are_excluded(self):
        mounts='\n'.join([
          '1 0 8:1 / / rw,relatime - ext4 /dev/nvme0n1p1 rw',
          '2 1 7:1 / /snap/core/1 ro - squashfs /dev/loop1 ro',
          '3 1 8:2 / /readonly ro - ext4 /dev/sda2 ro',
          '4 1 8:3 / /data rw - ext4 /dev/sda3 rw'])
        with patch('pathlib.Path.read_text',return_value=mounts):
            self.assertEqual(agent.disks({}),['/','/data'])
            self.assertEqual(agent.disks({'disk_mounts':['/snap/core/1']}),[])

    def test_message_is_exactly_three_lines(self):
        message=agent.alert_message({'server_name':'Web VPS'},[
            {'type':'cpu','object':'all','percent':82.5},
            {'type':'disk','object':'/','percent':85}],self.stamp)
        self.assertEqual(len(message.splitlines()),3)
        self.assertEqual(message.splitlines()[0],'VPS Web VPS')
        self.assertIn('CPU: 82.50%',message.splitlines()[1])
        self.assertIn('Ổ cứng /: 85.00%',message.splitlines()[1])
        self.assertRegex(message.splitlines()[2],r'^\d{2}/\d{2}/\d{4} \d{2}:\d{2} \(UTC\+7\)$')

    def test_alert_window_threshold_and_staleness(self):
        for seconds in (240,180,120,60,0):
            self.insert(self.stamp-seconds,'cpu')
        with agent.connect() as db:
            self.assertEqual(agent.overloaded(db,self.c,self.stamp)[0]['percent'],80)
            self.c['thresholds_percent']['cpu']=80
            self.assertEqual(agent.overloaded(db,self.c,self.stamp),[])
            with self.assertRaises(RuntimeError):
                agent.overloaded(db,self.c,self.stamp+200)

    def test_pagination_same_timestamp_and_new_insert(self):
        for _ in range(5): self.insert(self.stamp)
        with agent.connect() as db:
            page=agent.history(db,self.c,{'limit':['2'],'type':['ram']})
        self.insert(self.stamp)
        with agent.connect() as db:
            next_page=agent.history(db,self.c,{'limit':['2'],'type':['ram'],'cursor':[page['next_cursor']]})
            self.assertEqual([r['id'] for r in page['data']], [5,4])
            self.assertEqual([r['id'] for r in next_page['data']], [3,2])
            for params in ({'limit':['1001']},{'type':['wrong']},{'cursor':['bad']},{'limit':['1','2']}):
                with self.assertRaises(ValueError): agent.history(db,self.c,params)

    def test_retention_hides_then_deletes_old_records(self):
        self.insert(self.stamp-6*86400)
        self.insert(self.stamp)
        with agent.connect() as db:
            self.assertEqual(agent.history(db,self.c,{})['count'],1)
        agent.cleanup(self.c)
        with agent.connect() as db:
            self.assertEqual(db.execute('SELECT COUNT(*) FROM samples').fetchone()[0],1)

    def test_counter_rates_and_reboot(self):
        previous={'boot':'a','mono':100,'cpu':[100,0,0,100,0,0,0,0],'net':{'eth0':[0,0]}}
        now={'boot':'a','mono':160,'cpu':[160,0,0,120,0,0,0,0],'net':{'eth0':[600000000,0]},
             'mem':{'MemTotal':1000000,'MemAvailable':200000,'SwapTotal':0,'SwapFree':0}}
        with patch.object(agent,'disks',return_value=[]):
            rows=agent.make_samples(self.c,now,previous)
            self.assertEqual(next(r[2] for r in rows if r[0]=='cpu'),75)
            self.assertEqual(next(r[2] for r in rows if r[0]=='network'),80)
            now['boot']='b'
            rows=agent.make_samples(self.c,now,previous)
            self.assertFalse(any(r[0]=='cpu' for r in rows))
            self.assertIsNone(next(r[2] for r in rows if r[0]=='network'))

    def test_exact_telegram_file_ignores_backups_and_other_users(self):
        home = Path(self.tmp.name)/'ubuntu'
        folder = home/'telegram'
        folder.mkdir(parents=True)
        expected = folder/'.env.telegram'
        expected.write_text('test')
        (folder/'.env.telegram.backup').write_text('test')
        other = Path(self.tmp.name)/'codexops/telegram/.env.telegram'
        other.parent.mkdir(parents=True)
        other.write_text('test')
        self.assertEqual(resolve_telegram([home,other.parent.parent],existing=str(other)),expected)
        self.assertEqual(resolve_telegram([home],explicit=str(other)),other)
        expected.unlink()
        with self.assertRaises(ValueError): resolve_telegram([home])

    def test_local_account_home_does_not_use_site_profile(self):
        from types import SimpleNamespace
        repo=Path(self.tmp.name)
        for user in ('user_one_htms', 'ubuntu'):
            home=repo/user
            with patch('telegram_paths.pwd.getpwnam',return_value=SimpleNamespace(pw_dir=str(home))), \
                 patch('telegram_paths.pwd.getpwuid',return_value=SimpleNamespace(pw_dir='/root')):
                homes=deployment_homes(repo,{'SUDO_USER':user})
                self.assertEqual(homes[0],home)
                self.assertNotIn(Path('/home/ubuntu'),homes)

    def test_reconfigure_preserves_settings_and_invalid_file_is_not_written(self):
        root=Path(self.tmp.name)
        source=Path(__file__).parent
        dest=root/'settings'; dest.mkdir()
        stage=root/'stage'; stage.mkdir()
        home=root/'user_one_htms'; (home/'telegram').mkdir(parents=True)
        telegram=home/'telegram/.env.telegram'
        telegram.write_text('TOKEN_ADMIN_MONITOR=123:TEST\nID_CHANNEL_MONITOR=-100123\n')
        saved={'port':9200,'server_id':'custom-id','thresholds_percent':{'cpu':81,'ram':90,'disk':80,'network':80},
               'network_capacity_mbps':{'ens5':500}}
        (dest/'config.json').write_text(json.dumps(saved))
        with patch('configure.deployment_homes',return_value=[home]),patch.dict('os.environ',{},clear=True):
            prepare(source,dest,stage,root)
            result=json.loads((stage/'config.json').read_text())
            for key,value in saved.items(): self.assertEqual(result[key],value)
            self.assertEqual(result['telegram_source'],str(telegram))
            self.assertEqual(result['telegram_env'],str(dest/'telegram.env'))
            self.assertEqual(result['retention_days'],5)
            self.assertEqual(json.loads((dest/'config.json').read_text()),saved)
            telegram.write_text('WRONG=bad\n')
            (stage/'config.json').unlink()
            with self.assertRaises(ValueError): prepare(source,dest,stage,root)
            self.assertFalse((stage/'config.json').exists())


if __name__ == '__main__': unittest.main()
