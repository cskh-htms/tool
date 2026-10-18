"""Choose the exact Telegram env file; never scan backup files or other users."""
from pathlib import Path
import os
import pwd


def deployment_homes(repo, environ=None):
    """Use local account database, never a username from a cloned site profile."""
    env = os.environ if environ is None else environ
    users = [env.get('DEPLOY_USER'), env.get('SUDO_USER')]
    homes = []
    for user in users:
        if user:
            try:
                home = Path(pwd.getpwnam(user).pw_dir)
            except KeyError:
                raise ValueError('Unknown deployment user: ' + user) from None
            if home not in homes:
                homes.append(home)
    # Also works for root invoking a checkout owned by the deployment account.
    for uid in (Path(repo).stat().st_uid, os.getuid()):
        home = Path(pwd.getpwuid(uid).pw_dir)
        if home not in homes:
            homes.append(home)
    return homes


def resolve_telegram(homes, explicit=None, existing=None):
    if explicit:
        candidate = Path(explicit).expanduser().resolve()
        if not candidate.is_file():
            raise ValueError('TELEGRAM_ENV does not point to a file')
        return candidate
    for home in homes:
        candidate = Path(home) / 'telegram' / '.env.telegram'
        if candidate.is_file():
            return candidate.resolve()
    if existing and Path(existing).is_file():
        return Path(existing).resolve()
    raise ValueError('Không tìm thấy ~/telegram/.env.telegram của user triển khai. '
                     'Chỉ rõ TELEGRAM_ENV=/home/USER/telegram/.env.telegram')
