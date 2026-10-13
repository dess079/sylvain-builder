---
name: generate-react-hook
description: Generates a custom React 19.3 hook respecting the Rules of React and covered by focused tests. Use when extracting reusable stateful logic from a screen.
---

# generate-react-hook
Me caveman. Me generate-react-hook skill. Me do one thing and keep contract short.

## When to use

A screen has more than ~30 lines of stateful logic, or the same logic is needed in multiple screens.

## Required behaviour

- **Target path**: `src/features/<feature>/hooks/use<Name>.ts` when the hook is feature-scoped. Promote to `src/shared/hooks/` only if consumed by ≥ 2 features and free of domain semantics.
- Pure: same inputs → same outputs (excluding side effects scheduled via React).
- Returns a stable, minimal API (one object literal or a tuple). No "kitchen sink" returns.
- Side effects: prefer Actions / `useTransition` / `useEffectEvent` over `useEffect`.
- For async data: return a `use(promise)` result, not a manually-managed `{ data, loading, error }`.
- For mutations: expose an Action returning `[state, formAction, isPending]`.

## Required rules

- Over 300 lines: review cohesion and split only at a meaningful responsibility boundary.
- Add TSDoc where the public contract is not self-explanatory.
- No manual memoization.
- No business logic — that belongs to the backend or to a service module.

## Validation

- `validate-react19-idioms` passes.
- ESLint `react-hooks` v5+ clean (Rules of Hooks + Rules of React).
- A focused hook test covers its public behaviour.
- Used in at least one screen before merge.

## Failure modes

- Hook tries to read DOM during render → reject, restructure.
- Hook depends on a context provider that isn't mounted → require provider injection in the calling screen first.
