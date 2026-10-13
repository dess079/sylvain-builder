---
description: Plan and build a new full-stack feature end-to-end (backend + frontend + tests + security + quality).
agent: sylvain
argument-hint: <short feature description>
---

# /new-feature

Plan and implement the feature described after the slash command. Workflow:

1. Call `manage-task-todo` to break the work down.
2. Hand off to `architect` for structure / contracts.
3. Hand off to `backend-builder` (which will auto-call `generate-junit-test` after each piece).
4. Hand off to `frontend-builder` (which invokes `reuse-shared-components`; toolbars and AI screens use the library's existing surfaces).
5. Hand off to `security-guardian`.
6. Hand off to `quality-gate`.
7. Return a final summary.

Honour every rule in `.github/instructions/*.instructions.md`.
