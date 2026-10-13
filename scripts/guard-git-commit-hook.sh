#!/usr/bin/env bash
# VS Code-compatible PreToolUse hook. It reads the event from stdin and rejects
# a git commit unless a successful scan matches the current worktree exactly.
set -euo pipefail

event="$(cat)"
if ! python3 - "$event" <<'PY'
import json
import re
import sys

try:
    event = json.loads(sys.argv[1])
except json.JSONDecodeError:
    sys.exit(1)

tool_input = event.get('tool_input', event.get('toolArgs', ''))
if isinstance(tool_input, dict):
    command = ' '.join(str(value) for value in tool_input.values())
else:
    command = str(tool_input)
sys.exit(0 if re.search(r'(^|[;&|]\s*|\s)git\s+commit(?:\s|$)', command) else 1)
PY
then
  exit 0
fi

worktree_hash() {
  {
    git diff --binary HEAD 2>/dev/null
    while IFS= read -r -d '' file; do
      case "$file" in
        .sylvain/reports/security-scan-current.json) continue ;;
      esac
      printf 'untracked:%s\n' "$file"
      shasum -a 256 "$file"
    done < <(git ls-files --others --exclude-standard -z | LC_ALL=C sort -z)
  } | shasum -a 256 | awk '{print $1}'
}

head_sha="$(git rev-parse HEAD 2>/dev/null || printf 'UNBORN')"
tree_hash="$(worktree_hash)"
report=".sylvain/reports/security-scan-current.json"

if python3 - "$report" "$head_sha" "$tree_hash" <<'PY'
from datetime import datetime, timezone
import json
import sys

try:
    with open(sys.argv[1], encoding='utf-8') as source:
        report = json.load(source)
    completed = datetime.fromisoformat(report['completedAt'].replace('Z', '+00:00'))
    fresh = (datetime.now(timezone.utc) - completed).total_seconds() <= 1800
    valid = (
        report['result'] == 'passed'
        and report['gitHead'] == sys.argv[2]
        and report['worktreeHash'] == sys.argv[3]
        and fresh
    )
except (FileNotFoundError, KeyError, ValueError, json.JSONDecodeError):
    valid = False
sys.exit(0 if valid else 1)
PY
then
  exit 0
fi

printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Run bash scripts/security-scan.sh after the final change. The passing report must match this worktree and be less than 30 minutes old."}}'
exit 2
