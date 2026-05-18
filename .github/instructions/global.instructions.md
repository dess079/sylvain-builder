---
applyTo: "**"
description: Global rules for sylvain-builder. Always active.
---

# Global rules

## File size — HARD CAP

Every file written or modified must stay **≤ 100 lines**. After any write, mentally `wc -l`. If exceeded, split before considering the task done. Good split candidates: column definitions, detail panels, fetch logic, dialog content, utility functions, mappers.

## Documentation — MANDATORY

- Java: every class, public method, and non-trivial private method has Javadoc.
- TypeScript: every component, hook, and exported function has TSDoc/JSDoc with `@param`, `@returns`, and a one-line summary.
- No comment-out code. No TODO without a linked task ID in `.sylvain/todo.json`.

## Agent ↔ skill discipline

- Agents must NOT contain domain logic — they only route to skills.
- Skills must NOT contain code examples. They describe the contract, the invariants, and the validation steps. If a literal file is needed, it lives in `templates/`.
- Each skill = one responsibility.

## Todo list — PERSISTENT

Every non-trivial task starts by invoking `manage-task-todo` to record steps in `.sylvain/todo.json`. The list is updated as work progresses so an interrupted session can resume cleanly.

## Stack lock

Versions are locked in `.sylvain/compatibility-matrix.json`. Do not introduce a dependency that violates it without an ADR entry.

## Security

A HIGH or CRITICAL CVE detected on a dependency stops the workflow. Generated code must respect OWASP Top 10 (input validation, output encoding, no hardcoded secrets, no SSRF, no SQLi, no prompt-injection vectors for Spring AI).

## Language

Reply in the language the developer uses (French or English). Be concise and impersonal.

## Git

Conventional Commits: `<type>(<scope>): <description>`. One PR = one subject.

## Code style — VERTICAL BREATHING ROOM

Never write compact, wall-of-code blocks.

- **Inside any method / function**: insert a blank line between distinct logical sections — variable declarations, guard clauses, main logic, return statement.
- **Java**: blank line between field groups, between steps in a constructor/service method, and between chained-call blocks (e.g. `ChatClient.prompt()…`).
- **TypeScript / TSX**: blank line between hook calls, between derived values, between event handlers, and before the `return` / JSX block.
- A single blank line is enough — never add two or more consecutive blank lines.
