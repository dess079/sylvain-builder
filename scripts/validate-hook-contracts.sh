#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
cd "$root"

non_commit='{"tool_name":"Bash","tool_input":{"command":"git status --short"}}'
commit='{"tool_name":"Bash","tool_input":{"command":"git commit -m test"}}'
report='.sylvain/reports/security-scan-current.json'
backup=''

if [ -f "$report" ]; then
  backup="$(mktemp)"
  cp "$report" "$backup"
fi
cleanup() {
  rm -f "$report"
  if [ -n "$backup" ]; then mv "$backup" "$report"; fi
}
trap cleanup EXIT

printf '%s' "$non_commit" | bash scripts/guard-git-commit-hook.sh

# The denial case must be independent of an existing fresh scan report.
rm -f "$report"

set +e
printf '%s' "$commit" | bash scripts/guard-git-commit-hook.sh >/dev/null
status=$?
set -e

if [ "$status" -ne 2 ]; then
  echo "FAIL: the commit guard must deny a commit without a current passing scan." >&2
  exit 1
fi

mkdir -p "$(dirname "$report")"
head_sha="$(git rev-parse HEAD 2>/dev/null || printf 'UNBORN')"
tree_hash="$(python3 scripts/worktree-hash.py)"

python3 - "$report" "$head_sha" "$tree_hash" <<'PY'
from datetime import datetime, timezone
import json
import sys

with open(sys.argv[1], 'w', encoding='utf-8') as target:
    json.dump({
        'result': 'passed',
        'gitHead': sys.argv[2],
        'worktreeHash': sys.argv[3],
        'completedAt': datetime.now(timezone.utc).isoformat(),
        'checks': ['test'],
    }, target)
PY

printf '%s' "$commit" | bash scripts/guard-git-commit-hook.sh
