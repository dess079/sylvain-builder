#!/usr/bin/env python3
"""Print a portable SHA-256 fingerprint of the current Git worktree."""

from __future__ import annotations

import hashlib
import subprocess
from pathlib import Path


EXCLUDED = Path('.sylvain/reports/security-scan-current.json')


def git_output(*args: str) -> bytes:
    result = subprocess.run(['git', *args], capture_output=True, check=False)
    return result.stdout if result.returncode == 0 else b''


digest = hashlib.sha256()
digest.update(git_output('diff', '--binary', 'HEAD'))

for raw_path in git_output('ls-files', '--others', '--exclude-standard', '-z').split(b'\0'):
    if not raw_path:
        continue

    relative_path = Path(raw_path.decode('utf-8', errors='surrogateescape'))
    if relative_path == EXCLUDED:
        continue

    digest.update(b'untracked:')
    digest.update(raw_path)
    digest.update(b'\n')

    with relative_path.open('rb') as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b''):
            digest.update(chunk)

print(digest.hexdigest())
