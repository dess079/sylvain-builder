---
applyTo: "**/*.java"
description: Java 25 + Spring Boot 4.0.6 + Spring AI 2.0.0-M6 idioms (May 2026).
---

# Backend rules — Java 25 / Spring Boot 4.0.6 / Spring AI 2.0.0-M6

## Java 25 idioms (mandatory)

- DTOs and value objects → `record` (immutable, compact constructor for validation).
- Multi-shape contracts → `sealed interface` + permits clause.
- Branching on type → pattern matching (`switch` expression, no `instanceof` chains).
- Long-lived flat data → consider `record` + `with`-style copy methods.
- Concurrency: prefer **virtual threads** for blocking I/O. Avoid `synchronized` on long sections; prefer `ReentrantLock` or a structured concurrency scope.
- `var` only when the type is obvious from the right-hand side.
- Streams: prefer `gather` / `mapMulti` over `flatMap` when stateful.

## Spring Boot 4.0.6 conventions

- `spring.threads.virtual.enabled=true` is on by default for new modules.
- **Constructor injection only** — never `@Autowired` on a field, never field/setter injection.
- `@ConfigurationProperties` (record-based) for typed configuration. No raw `@Value` strings except in tests.
- Bean Validation (Jakarta) on every controller input.
- Errors: `ProblemDetail` (RFC 7807). No raw exceptions leaking.
- Persistence: Spring Data JPA repositories return `Optional`/`Page`. Native queries are last resort.
- API docs: `springdoc-openapi` annotations on every endpoint.

## Spring AI 2.0.0-M6

- Use `ChatClient` (fluent) — never raw `ChatModel` from a controller.
- Add `Advisors` for cross-cutting (memory, RAG, logging, guardrails).
- Structured output via record target classes — never parse JSON by hand.
- Tool / function calling: declare a typed interface; annotate with `@Tool`; let Spring AI bind it.
- **Chat memory**: always supply an explicit `conversationId` — `PromptChatMemoryAdvisor` is removed in 2.0.
- **Options**: use builder pattern only (no setters) — e.g. `OpenAiChatOptions.builder().temperature(0.7).build()`.
- Vector store: PgVector preferred when PostgreSQL is already present.
- Prompts come from `resources/prompts/*.st` — never inline in code.

## Tests

- JUnit 5 + AssertJ + Mockito.
- `@SpringBootTest` only when a full slice is needed; prefer `@WebMvcTest`, `@DataJpaTest`, `@JsonTest`.
- Integration: Testcontainers (Postgres, Ollama for Spring AI).
- Coverage target ≥ 80% on changed lines.
