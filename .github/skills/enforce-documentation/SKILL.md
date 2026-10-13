---
name: enforce-documentation
description: Verifies useful documentation on non-obvious public Java and TypeScript contracts. Read-only.
---

# enforce-documentation
Me caveman. Me enforce-documentation skill. Me do one thing and keep contract short.

## When to use

After every batch of file writes, before `quality-gate` finishes.

## What it checks

**Java**

- Public class or method with non-obvious domain semantics → has useful Javadoc.
- `@deprecated` Javadoc when an element is annotated `@Deprecated`.

**TypeScript / React**

- Exported function, component or hook with a non-obvious contract → has useful TSDoc.

## Output

`.sylvain/reports/docs-<timestamp>.md` listing missing docs by file + symbol.

## Blocking rules

Any missing required doc → `blocked`, route back to the responsible builder agent.

## Non-goals

- Does not judge documentation quality. A bad one-line summary still passes; humans do that review.
- Does not enforce private-method docs on Java when method ≤ 4 lines.
