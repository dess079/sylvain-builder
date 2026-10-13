---
name: generate-jpa-entity
description: Generates a JPA entity plus its record DTOs (request/response), Spring Data repository and a pure mapper, on Java 27. Use when adding a new persistent aggregate.
---

# generate-jpa-entity
Me caveman. Me generate-jpa-entity skill. Me do one thing and keep contract short.

## When to use

A new persistent aggregate is needed. Caller already knows the table name and key fields.

## Required artefacts

- `entity/<Name>.java` — `@Entity`, plain class with private no-arg ctor for JPA, package-private setters, business methods only on the entity.
- `dto/<Name>Request.java` — `record` with Jakarta Bean Validation annotations.
- `dto/<Name>Response.java` — `record` with no validation, only mapping.
- `repository/<Name>Repository.java` — `extends JpaRepository`. Custom finders use derived queries first, JPQL second, native last.
- `mapper/<Name>Mapper.java` — static pure methods. No framework annotations.

## Required rules

- IDs are `Long` (autogen) unless the caller specifies otherwise.
- Auditing fields (`createdAt`, `updatedAt`) via `@EntityListeners(AuditingEntityListener.class)` — already enabled in scaffold.
- Soft delete only when explicitly requested.
- Review source files over 300 lines for a real separation of responsibilities.

## Validation

- `enforce-documentation`, `validate-java-idioms` pass.
- `generate-integration-test` is invoked next when non-trivial queries exist.

## Failure modes

- Table name conflict → stop.
- Missing Flyway migration slot → ask `architect`.
