---
name: enforce-file-size-limit
description: Enforces the 100-line cap on every generated file. Read-only — reports files to split. Generated OpenAPI files are exempt.
---

# enforce-file-size-limit
Me caveman. Me enforce-file-size-limit skill. Me do one thing and keep contract short.

## When to use

After every batch of file writes, and at the start of `quality-gate`.

## What it does

- Runs `wc -l` on every changed file in the working tree.
- Compares against the **100-line hard cap** (LF newlines, blank lines included).
- Exempts files explicitly marked generated (header `// @generated` for TS, `/* @generated */` for Java) — typically the OpenAPI types output.

## Output

`.sylvain/reports/size-<timestamp>.md` with one row per offending file:

| File | Lines | Recommended split |
|---|---|---|

Recommended splits use the patterns from `instructions/global.instructions.md`:

- React component → sub-component + `use<Name>State.ts` hook.
- React hook → split per responsibility.
- TS utility → split per responsibility.
- Java class → service / helper / DTO / mapper.
- Spring controller → split per resource.

## Blocking rules

Any non-exempt file > 100 lines → `blocked`. The skill does **not** edit files; it routes back to the responsible builder agent.

## Failure modes

- Symlink loops or binary files → ignored.
