---
name: validate-react19-idioms
description: Validates that generated React 19.3 / Compiler 1.0 code follows October 2026 idioms. Read-only. Reports anti-patterns to fix.
---

# validate-react19-idioms
Me caveman. Me validate-react19-idioms skill. Me do one thing and keep contract short.

## When to use

After any frontend file is generated or modified, before handing off to `quality-gate`.

## Anti-patterns to flag

- `useMemo`, `useCallback`, `React.memo` — the Compiler handles memoization.
- `forwardRef` — `ref` is now a regular prop in React 19.
- Manually managed `{ data, loading, error }` for fetch — should be `use(promise)` + `<Suspense>` + error boundary.
- `useEffect` for derived state, computations, or one-shot events on mount.
- Manual `setState` chains for mutations — should be Actions + `useActionState` + `useOptimistic`.
- Class components.
- Default React import (`import React from 'react'`) when only hooks are used.
- `any` in a type annotation.
- Re-declared backend types instead of importing from `shared-types`.
- Hardcoded user-facing strings (must go through i18n).
- `dangerouslySetInnerHTML` without an explicit sanitiser.

## Test-quality anti-patterns

- Tests that assert internal component state, mock React itself, or omit changed loading/error/interaction behaviour → flag for correction.

## Output

`.sylvain/reports/react19-idioms-<timestamp>.md` with file + line + suggested fix.

## Blocking rules

Any anti-pattern in the list → `blocked`, route back to `frontend-builder`.
