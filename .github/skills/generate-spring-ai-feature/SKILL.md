---
name: generate-spring-ai-feature
description: Generates a Spring AI 2.0.1 feature on Spring Boot 4.1.1 — ChatClient calls, Advisors, RAG with PgVector, structured output and typed tool calling. Use when the user asks for an AI capability.
---

# generate-spring-ai-feature
Me caveman. Me generate-spring-ai-feature skill. Me do one thing and keep contract short.

## When to use

Any backend feature that calls a chat model, embeds documents, runs RAG, or exposes tools to a model.

## Required design choices

- **API surface**: a typed `interface` describing inputs/outputs as records. Never expose raw `String`.
- **ChatClient**: built once via `ChatClient.Builder`, configured with default Advisors.
- **Advisors**: at least logging + safety. Add `MessageChatMemoryAdvisor` if the feature is conversational. Add a RAG advisor if grounding is required.
- **Structured output**: target a `record`. Use Spring AI's structured output converters — never parse JSON by hand.
- **Tool/function calling**: declare a typed callback interface, annotate with `@Tool` from Spring AI 2.0. Always supply explicit `conversationId` to chat memory advisors.
- **Vector store**: PgVector if PostgreSQL is present, else the project's default. Configure dimension to match the chosen embedding model.
- **Prompts**: live in `src/main/resources/prompts/<feature>.st`, never inline.

## Required rules

- No secrets in code. API keys via env vars + `@ConfigurationProperties` record.
- Every model input crossing a tool boundary is **validated and sanitised** to prevent prompt injection.
- Streaming endpoints use `Flux<String>` (server-sent events) or `Flow` if Kotlin.
- Invoke `generate-junit-test` and `generate-integration-test` (with Testcontainers Ollama or wiremock) after generation.

## Validation

- `validate-java-idioms`, `enforce-documentation`, JUnit suite green.
- `scan-source-vulnerabilities` finds no prompt-injection vector.

## Failure modes

- No vector store configured but RAG requested → ask `architect`.
- Chosen embedding dimension differs from existing index → stop.
