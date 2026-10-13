---
name: generate-junit-test
description: Generates JUnit 6 + AssertJ + Mockito unit tests for newly generated backend code. Invoked automatically by backend-builder after every feature.
---

# generate-junit-test
Me caveman. Me generate-junit-test skill. Me do one thing and keep contract short.

## When to use

Right after any backend file is generated or modified. **Mandatory** — never skipped.

## Required coverage

- One test class per production class.
- Public methods covered: happy path, edge case, failure path (exception or `Optional.empty`).
- For services: mock collaborators with Mockito. Verify behaviour with AssertJ.
- For controllers: `@WebMvcTest`, MockMvc, validate status, payload, problem details.
- For mappers: parameterised tests with `@ParameterizedTest`.
- For records with compact-constructor validation: assert that invalid inputs throw.

## Required rules

- Coverage on changed lines ≥ 80%. Below that → mark todo `blocked`.
- Tests are **fast** (< 200 ms each) — no real Spring context unless the slice annotation requires it.
- AssertJ chained assertions; no JUnit `assertEquals` chains.
- Test method names follow `should_<expected>_when_<condition>`.
- Keep the test focused; review files over 300 lines for a real behaviour-group split.

## Validation

- `mvn -q test` green.

## Failure modes

- Production class is untestable (static state, hidden dependencies) → block, route back to `backend-builder` for refactor.
