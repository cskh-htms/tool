"""Repair only root-owned Python caches made by old monitor installers."""
import os
from pathlib import Path
import stat
import sys


def repair(source):
    source = Path(source).resolve()
    cache = source / '__pycache__'
    if not cache.is_dir() or cache.is_symlink():
        return
    owner = source.stat()
    for p in cache.iterdir():
        if p.is_symlink() or not p.is_file():
            continue
        if p.name.split('.')[0] not in {'agent', 'telegram_paths', 'configure', 'repair_repo_cache'} or p.suffix != '.pyc':
            continue
        if p.stat().st_uid == 0:
            os.chown(p, owner.st_uid, owner.st_gid)
            p.chmod(stat.S_IMODE(p.stat().st_mode) | stat.S_IRUSR | stat.S_IWUSR)
    if cache.stat().st_uid == 0:
        os.chown(cache, owner.st_uid, owner.st_gid)
        cache.chmod(stat.S_IMODE(cache.stat().st_mode) | stat.S_IRWXU)


if __name__ == '__main__':
    repair(sys.argv[1])
