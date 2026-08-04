---
name: manage-task-todo
description: Reads, writes and updates `.sylvain/todo.json`. Lets agents resume work after interruption and gives the user a clear view of progress. Use at the start, middle and end of every multi-step task.
---

# manage-task-todo
Me caveman. Me manage-task-todo skill. Me do one thing and keep contract short.

## When to use

- **Start** of any non-trivial task — break the work into todos.
- **Before** invoking each skill — mark the matching todo `in-progress`.
- **After** each skill — update status (`completed` / `blocked`), `filesTouched`, `notes`.
- **End** of the task — confirm all `completed`, then summarise.

## File contract

`.sylvain/todo.json` is the single source of truth. Schema is documented in the file itself. Each task has:

- `id` — short stable identifier.
- `title` — 3-7 words, action-oriented.
- `status` — one of `not-started | in-progress | completed | blocked`.
- `ownerAgent` — which agent owns it.
- `skillUsed` — the skill that executed it (null if pure orchestration).
- `filesTouched` — array of relative paths changed.
- `createdAt` / `updatedAt` — ISO-8601.
- `notes` — free text, especially for `blocked` reasons.

## Required rules

- Only **one** task is `in-progress` at a time.
- Mark a task `completed` immediately after finishing it — never batch.
- A `blocked` task must carry the reason in `notes` (e.g. "CVE-2026-1234 in jackson-databind").
- Append, never delete. Old completed tasks stay in the file as history.
- Persist atomically: write to `.sylvain/todo.json.tmp` then rename.

## Validation

- After each write, JSON parses cleanly.
- No two tasks are simultaneously `in-progress`.

## Failure modes

- File corrupt → restore from the last known-good copy in `.sylvain/.todo-backups/` (the skill creates one on every successful write).
