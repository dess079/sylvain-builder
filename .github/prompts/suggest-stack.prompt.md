---
name: suggest-stack
description: Cross-checks the locked compatibility matrix against the verified latest versions (May 2026 baseline) and proposes a diff. Read-only.
agent: sylvain
argument-hint: "[backend|frontend|all]"
---

Run the `suggest-latest-stack` skill with scope `${input:scope:all}`.

Steps:

1. Read `.sylvain/compatibility-matrix.json`.
2. For each tracked component, fetch the official sources listed in `instructions/web-references.instructions.md`.
3. Produce the drift table (Component | Locked | Latest stable | Drift | CVE since lock | ADR required?).
4. Group findings into: **Safe bumps**, **ADR-required bumps**, **Status quo**.
5. Append a `suggestion` task to `.sylvain/todo.json` via `manage-task-todo` so the developer can confirm later.
6. **Do not edit** the matrix or any project file. Only propose.

Reply in the developer's language.
