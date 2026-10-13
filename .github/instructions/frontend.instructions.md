---
applyTo: "**/*.{tsx,jsx}"
description: React 19.3 + Compiler 1.0 + TypeScript 7 + Vite 8 + MUI 9 idioms (October 2026).
---

# Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9

## React 19 idioms (mandatory)

- React Compiler is **enabled** — do **not** write `useMemo`, `useCallback`, or `React.memo` manually. The compiler memoizes for you.
- Server data fetching: prefer Server Components (when an RSC framework is used) or `use(promise)` in client components.
- Mutations: use **Actions** + `useActionState` + `useOptimistic` + `useTransition`. No raw `fetch` + manual `setState` chains.
- Effects: avoid `useEffect` for derived state, computations, or event handling. Use `useEffectEvent` for non-reactive event-like values.
- `forwardRef` is no longer required — `ref` is a prop.
- Strict purity: components and hooks must be pure (Rules of React).

## Shared UI library (mandatory)

- Read `.sylvain/shared-components.json` and inspect the public package exports
  before creating a component, hook or MUI composition. Import only from the
  `shared-components` package root.
- Every toolbar uses `MenuBar` where it fits; a justified custom toolbar still
  includes the existing `ThemeSelector` and `PreferencesPanel` (settings gear).
- An AI screen uses `AiChatPanel`, or composes `AiPromptCard` and
  `AiResponseBlock`. Do not recreate these surfaces in an application.
- A generic, backend-agnostic component useful to two applications belongs in
  `shared-components`, with tests and a public root export. Keep application
  code feature-specific.

## Visual direction (on demand)

- For a new screen or substantial visual refactor, use `frontend-design` to
  create an intentional direction grounded in the product rather than generic
  generated UI defaults.
- For a major UI decision, complex interaction or visual QA, use
  `ui-ux-pro-max` and query only the relevant local guidance. Its output is
  advisory and never overrides the product brief, MUI, accessibility or this
  shared-components policy.
- Express palette, spacing, typography and states through the MUI theme and
  semantic tokens. Do not introduce Tailwind, shadcn or a competing UI library.
- Persist a generated design-system document only when it is a useful durable
  product contract; never overwrite one without explicit approval.

## TypeScript

- `strict: true`, `noUncheckedIndexedAccess: true`, `verbatimModuleSyntax: true`.
- Prefer `type` for unions/aliases, `interface` only for object contracts that get extended.
- No `any`. `unknown` then narrow.
- Types come from the OpenAPI contract (skill `generate-typescript-types`) — never re-declare backend DTOs by hand.

## Tests

- Add focused Vitest + React Testing Library tests for changed user-visible behaviour, hooks and error/loading states.
- Prefer interaction and accessibility assertions over implementation details. Mock network boundaries, not components under test.
- Use browser E2E tests only for critical cross-boundary journeys; keep them outside unit-test feedback loops.

## Documentation

Document exported public contracts when types and names do not make the intent clear. Avoid boilerplate comments that duplicate TypeScript types.

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

Every Vite project must use `@vitejs/plugin-react` with the React Compiler preset through `@rolldown/plugin-babel`, and `build.target: 'es2024'`. Use Node 26 LTS and exact versions from `.sylvain/compatibility-matrix.json`.
