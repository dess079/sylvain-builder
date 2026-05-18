---
applyTo: "**/*.{ts,tsx,js,jsx}"
description: React 19.2 + Compiler 1.0 + TypeScript 6 + Vite 8 idioms (May 2026).
---

# Frontend rules — React 19.2.6 / Compiler 1.0 / TS 6 / Vite 8

## React 19 idioms (mandatory)

- React Compiler is **enabled** — do **not** write `useMemo`, `useCallback`, or `React.memo` manually. The compiler memoizes for you.
- Server data fetching: prefer Server Components (when an RSC framework is used) or `use(promise)` in client components.
- Mutations: use **Actions** + `useActionState` + `useOptimistic` + `useTransition`. No raw `fetch` + manual `setState` chains.
- Effects: avoid `useEffect` for derived state, computations, or event handling. Use `useEffectEvent` for non-reactive event-like values.
- `forwardRef` is no longer required — `ref` is a prop.
- Strict purity: components and hooks must be pure (Rules of React).

## TypeScript

- `strict: true`, `noUncheckedIndexedAccess: true`, `verbatimModuleSyntax: true`.
- Prefer `type` for unions/aliases, `interface` only for object contracts that get extended.
- No `any`. `unknown` then narrow.
- Types come from the OpenAPI contract (skill `generate-typescript-types`) — never re-declare backend DTOs by hand.

## NO TESTS

This codebase has **no frontend tests**. Do not create files matching `*.test.{ts,tsx,js,jsx}`, `*.spec.*`, `__tests__/`, Jest/Vitest configs, RTL imports. If asked to test the UI, refuse and route the user to the backend test suite.

## Documentation

Every component, hook, and exported function carries TSDoc with a one-line summary, `@param`, `@returns`. Internal helpers ≥ 5 lines also documented.

## Folder layout — feature-based (mandatory)

The UI is organised **by feature (bounded context)**, mirroring the backend modules. Never group by technical type at the root (no top-level `components/`, `hooks/`, `pages/` holding cross-feature code).

```
src/
  features/
    <feature>/                 # e.g. users, orders, invoices
      pages/                   # route-level screens
      components/              # presentation sub-components, feature-scoped
      hooks/                   # use<Feature>*.ts
      api/                     # thin wrappers over generated OpenAPI client
      types.ts                 # feature-local types (DTOs come from shared-types)
      index.ts                 # public surface of the feature
  shared/                      # ONLY truly cross-feature code
    ui/                        # design-system primitives
    lib/                       # framework-agnostic helpers
    i18n/
  app/                         # router, providers, layout shell
  main.tsx
```

Rules:
- A feature folder owns its screens, components, hooks and API calls. Cross-feature imports go through `shared/` or another feature's `index.ts` barrel — never reach into a sibling's internals.
- A new screen lives in `src/features/<feature>/pages/`. If no feature fits, create one; do not dump into `shared/`.
- Promote code to `shared/` only when it is used by ≥ 2 features and has no domain semantics.

## Performance

- React Compiler handles memoization. Focus on data shape, not memo gymnastics.
- Suspense boundaries around data-fetching subtrees.
- `useTransition` for non-urgent state updates.
- `useDeferredValue` for derived expensive renders.

## vite.config.ts contract

Every Vite project must use `@vitejs/plugin-react` with `babel-plugin-react-compiler` enabled and `build.target: 'es2024'`. See `templates/package.template.json` for pinned versions. Node ≥ 22.12 required (Vite 8 drops Node 18).
