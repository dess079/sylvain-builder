---
name: progressive-build-verify
description: Compiles, lints and tests after each feature increment. Catches regressions early. Read-only on source — only runs commands.
---

# progressive-build-verify
Me caveman. Me progressive-build-verify skill. Me do one thing and keep contract short.

## When to use

- At the end of `backend-builder` or `frontend-builder`.
- Inside `quality-gate` as the final step.

## Steps

**Backend**

1. `mvn -q -T 1C compile` — fast feedback.
2. `mvn -q -T 1C test` — unit tests.
3. `mvn -q -DskipITs=false verify` — integration tests if any IT exists.
4. Capture failures into `.sylvain/reports/build-<timestamp>.md`.

**Frontend**

1. `pnpm run lint` — ESLint with `eslint-plugin-react-hooks` v7.
2. `pnpm run build` — Vite production build.
3. (No test step. Frontend has no tests by policy.)

## Output

A single Markdown report listing what passed, what failed, and the first 50 lines of error output for any failure.

## Blocking rules

- Any failing step → `blocked`. Route back to the responsible builder agent.
- Build time blow-up (> 2× recent baseline) → flag as `warning`, not blocking.

## Failure modes

- Maven or pnpm not available → `blocked` with install instructions.
