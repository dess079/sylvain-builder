#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import json
from pathlib import Path

path = Path('.sylvain/todo.json')
if not path.exists():
    summary = ''
else:
    data = json.loads(path.read_text(encoding='utf-8'))
    tasks = data.get('tasks', [])
    current = data.get('currentTaskId')
    selected = [task for task in tasks if task.get('id') == current]
    selected.extend(
        task for task in tasks
        if task.get('status') == 'blocked' and task.get('id') != current
    )
    selected = selected[:3]
    if selected:
        lines = [f"{task.get('id')}: {task.get('status')} — {task.get('title')}" for task in selected]
        summary = 'Active sylvain todos:\n' + '\n'.join(lines)
    else:
        summary = ''

print(json.dumps({'hookSpecificOutput': {'hookEventName': 'SessionStart', 'additionalContext': summary}}))
PY
