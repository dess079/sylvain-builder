---
name: generate-integration-test
description: Generates Testcontainers-based integration tests (Postgres, optional Ollama for Spring AI). Use when persistence or external systems are touched.
---

# generate-integration-test
Me caveman. Me generate-integration-test skill. Me do one thing and keep contract short.

## When to use

- A repository with a non-trivial query (JPQL, native, custom).
- A Spring AI feature touching a real model or vector store.
- Any flow that crosses a process boundary (HTTP, queue, DB, vector store).

## Required behaviour

- `@SpringBootTest` (or the right slice) + Testcontainers JUnit Jupiter extension.
- Containers reused across the suite via `@Container` static fields and `@DynamicPropertySource`.
- Postgres container version matches production. PgVector if RAG is in scope.
- Ollama container with a small open model for AI tests, or wiremocked OpenAI if the project uses commercial models.
- Real HTTP via `TestRestTemplate` or `WebTestClient`. Real persistence — no mocked repository.

## Required rules

- One integration test class per feature, ≤ 100 lines.
- Tests are **isolated**: no test depends on another's order.
- A clean DB state per test method (`@Sql` or transactional rollback).

## Validation

- `mvn -q -DskipITs=false verify` green.
- Total IT runtime watched; if > 60 s for a single class, split.

## Failure modes

- Required Docker not available in CI runner → mark `blocked`, surface to the user.
