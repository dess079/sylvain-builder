---
applyTo: "**"
description: Global rules for sylvain-builder. Always active.
---

# Global rules

## File size — review threshold

Keep source files cohesive. A generated source file over **300 lines** requires an explicit review: split it only when a real responsibility boundary exists. Generated artifacts, migrations, configuration, lockfiles and templates are exempt. Never fragment cohesive code merely to meet a line count.

## Documentation — MANDATORY

- Java: public APIs and non-obvious domain decisions have useful Javadoc. Do not narrate self-evident accessors or implementation details.
- TypeScript: exported public components, hooks and functions have TSDoc when their contract is not apparent from types and names.
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

Reply in the user's language. Be concise and factual.

## Git

Conventional Commits: `<type>(<scope>): <description>`. One PR = one subject.

## Code style — VERTICAL BREATHING ROOM

Never write compact, wall-of-code blocks.

- **Inside any method / function**: insert a blank line between distinct logical sections — variable declarations, guard clauses, main logic, return statement.
- **Java**: blank line between field groups, between steps in a constructor/service method, and between chained-call blocks (e.g. `ChatClient.prompt()…`).
- **TypeScript / TSX**: blank line between hook calls, between derived values, between event handlers, and before the `return` / JSX block.
- A single blank line is enough — never add two or more consecutive blank lines.
