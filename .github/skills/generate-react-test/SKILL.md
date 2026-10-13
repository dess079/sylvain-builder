---
name: generate-react-test
description: Adds focused Vitest and React Testing Library coverage for changed React 19.3 behaviour. Use after changing a screen, component or custom hook.
---

# generate-react-test

## When to use

After a frontend behaviour changes: user interaction, validation, loading, error, accessibility or optimistic update.

## Required rules

- Use Vitest, React Testing Library and `user-event`; test through accessible roles, labels and visible outcomes.
- Put the test beside the unit under test using `*.test.ts` or `*.test.tsx`.
- Mock network and browser boundaries only. Do not mock React, MUI primitives, or the component being exercised.
- Cover the changed success path and relevant loading, error or validation path.
- Keep fixtures local, deterministic and small. Do not snapshot the full DOM.
- Use the application providers and i18n helper when the unit depends on them.

## Validation

- `pnpm run test` passes.
- `validate-react19-idioms` finds no implementation-detail assertions.
- The test fails when the changed behaviour is intentionally removed.

## Failure modes

- If no observable behaviour changed, record why a test is not needed in the task notes.
- If the unit requires an end-to-end browser journey, route that one scenario to the project E2E strategy instead of forcing it into a unit test.
