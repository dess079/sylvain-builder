---
name: enforce-documentation
description: Verifies that every public Java class/method and every TS exported component/hook/function carries Javadoc / TSDoc. Read-only.
---

# enforce-documentation

## When to use

After every batch of file writes, before `quality-gate` finishes.

## What it checks

**Java**

- Public class → has Javadoc with a one-line summary.
- Public method → has Javadoc, with `@param` for each parameter and `@return` if non-void.
- Non-trivial private method (≥ 5 lines) → has at least a one-line comment.
- `@deprecated` Javadoc when an element is annotated `@Deprecated`.

**TypeScript / React**

- Exported function / component / hook → has TSDoc with one-line summary, `@param`, `@returns`.
- Prop / parameter interfaces → each property has a TSDoc line.
- Internal helpers ≥ 5 lines → at least one comment.

## Output

`.sylvain/reports/docs-<timestamp>.md` listing missing docs by file + symbol.

## Blocking rules

Any missing required doc → `blocked`, route back to the responsible builder agent.

## Non-goals

- Does not judge documentation quality. A bad one-line summary still passes; humans do that review.
- Does not enforce private-method docs on Java when method ≤ 4 lines.
