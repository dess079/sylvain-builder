---
name: generate-rest-endpoint
description: Generates a Spring Boot 4.1.1 REST controller with OpenAPI annotations, Bean Validation, RFC 7807 ProblemDetail error handling and pagination. Use when adding a new HTTP endpoint to an existing feature.
---

# generate-rest-endpoint
Me caveman. Me generate-rest-endpoint skill. Me do one thing and keep contract short.

## When to use

A new HTTP endpoint on an existing service / module. The DTOs already exist.

## Required behaviour

- HTTP method maps to intent: GET (read, idempotent), POST (create), PUT (full replace), PATCH (partial), DELETE.
- All inputs validated via `@Valid` or `@Validated`.
- All outputs use response DTO records, never the entity.
- Pagination via `Pageable` and `PagedModel` (or `Page<T>` mapped to a `PageResponse` record).
- Errors → `ProblemDetail` (RFC 7807). No raw `ResponseStatusException` in business code.
- OpenAPI annotations: `@Operation`, `@ApiResponses`, `@Parameter` on every public element.
- Idempotency-Key header support for non-idempotent endpoints when caller asks.

## Required rules

- Review controller classes over 300 lines and split per resource when responsibilities diverge.
- Every public method has Javadoc with `@param` and `@return`.
- Constructor injection only.
- Authorisation handled via `@PreAuthorize` on the controller method, never inside the service.

## Validation

- `validate-java25-idioms`, `enforce-documentation` pass.
- `generate-junit-test` invoked for the controller (use `@WebMvcTest`).
- OpenAPI YAML rebuilds cleanly.

## Failure modes

- Endpoint path collides with an existing route → stop and surface conflict.
