---
name: generate-spring-boot-module
description: Generates a self-contained Spring Boot feature module (controller + service + repository + DTO records + tests) on Java 27 / Spring Boot 4.1.1. Use when adding a non-AI backend feature.
---

# generate-spring-boot-module
Me caveman. Me generate-spring-boot-module skill. Me do one thing and keep contract short.

## When to use

A new backend feature that fits in a single bounded context (e.g. `users`, `orders`, `invoices`). Not for AI features (use `generate-spring-ai-feature`).

## Required artefacts

- `entity/<Name>.java` — JPA entity, plain `@Entity` (not a record — JPA needs a no-arg ctor).
- `repository/<Name>Repository.java` — Spring Data interface.
- `dto/<Name>Request.java` and `dto/<Name>Response.java` — `record` types with Bean Validation.
- `service/<Name>Service.java` — constructor injection, virtual-thread-friendly, no `synchronized`.
- `web/<Name>Controller.java` — REST + OpenAPI annotations, `ProblemDetail` for errors.
- `mapper/<Name>Mapper.java` — pure functions, no framework dep.

## Required rules

- Constructor injection only.
- Each public symbol has Javadoc.
- Immediately invoke `generate-junit-test` for the new service and controller, and `generate-integration-test` for repository if a non-trivial query is added.
- Review source files over 300 lines for real responsibility boundaries; split a fat controller into resource sub-controllers when needed.

## Validation

- `mvn -q test` green.
- `validate-java25-idioms` passes.
- `enforce-documentation` passes.

## Failure modes

- Missing module package → ask `architect` first.
- Entity name conflicts with existing one → stop, surface the conflict.
