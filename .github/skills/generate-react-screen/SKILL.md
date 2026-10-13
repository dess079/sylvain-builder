---
name: generate-react-screen
description: Generates a React 19.3 + MUI 9 screen or page with Compiler 1.0 enabled, no manual memoization and focused behaviour tests. Use when adding a new UI screen.
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

- Invoke `reuse-shared-components` before designing the screen. Reuse public
  components from `shared-components` rather than recreating generic MUI UI.
- For a new screen or a substantial visual rewrite, use `frontend-design` to
  establish a product-specific direction. Use `ui-ux-pro-max` only when a
  major visual decision, a complex interaction or a targeted UX review benefits
  from its local search data; do not load either skill for non-visual work.
- Every application toolbar uses `MenuBar`, or a justified composition of
  `ThemeSelector` and `PreferencesPanel`/`PreferencesIcon`.
- An AI screen uses `AiChatPanel`, or the existing `AiPromptCard` plus
  `AiResponseBlock`; never duplicate prompt or response presentation.
- Over 300 lines: review cohesion and extract only at a real feature boundary.
- Use MUI 9 primitives and the project theme before creating one-off styling.
- **No** `useMemo`, `useCallback`, `React.memo`. The Compiler memoizes.
- Add a focused Vitest + React Testing Library test through `generate-react-test`.
- Imports follow ESLint order; no default React import (`import { useState } from 'react'`).

## Validation

- `validate-react19-idioms` passes.
- `enforce-documentation` passes.
- `pnpm run test` passes.
- `pnpm run lint` clean.

## Failure modes

- Required types not generated → invoke `generate-typescript-types` first.
