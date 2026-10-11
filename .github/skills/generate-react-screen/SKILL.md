---
name: generate-react-screen
description: Generates a React 19.2 screen / page component with Compiler 1.0 enabled. No manual memoization, mandatory TSDoc, ≤100 lines, NO test file. Use when adding a new UI screen.
---

# generate-react-screen
Me caveman. Me generate-react-screen skill. Me do one thing and keep contract short.

## When to use

A new top-level page or screen. Reuses generated TS types from `shared-types/`.

## Required design

- Functional component. Default export. PascalCase file name matching component name.
- **Target path**: `src/features/<feature>/pages/<Screen>.tsx`. Create the feature folder if missing (`pages/`, `components/`, `hooks/`, `api/`, `index.ts`). Never place screens under a top-level `pages/` or `shared/`.
- Data fetching: `use(promise)` for client components, or Server Components if an RSC framework is in play.
- Mutations: Actions + `useActionState` + `useOptimistic` + `useTransition`.
- Loading and error UX via `<Suspense>` + error boundary at the screen level.
- Accessibility: semantic HTML, labels for form controls, focus management on route changes.
- Internationalisation: every user-facing string goes through the project's i18n function — never hardcode literal English/French.

## Required rules

- ≤ 100 lines. If exceeded: extract presentation sub-components into `src/features/<feature>/components/` and a `use<Screen>State.ts` hook into `src/features/<feature>/hooks/` (call `generate-react-hook`).
- Mandatory TSDoc on the component and on every prop interface.
- **No** `useMemo`, `useCallback`, `React.memo`. The Compiler memoizes.
- **No** test file. Ever.
- Imports follow ESLint order; no default React import (`import { useState } from 'react'`).

## Validation

- `validate-react19-idioms` passes.
- `enforce-documentation` passes.
- `pnpm run lint` clean.

## Failure modes

- Required types not generated → invoke `generate-typescript-types` first.
