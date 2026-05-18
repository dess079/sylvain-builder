---
name: validate-java25-idioms
description: Validates that generated Java code uses Java 25 / Spring Boot 4.0.6 idioms (May 2026). Read-only. Reports anti-patterns to fix.
---

# validate-java25-idioms

## When to use

After any backend file is generated or modified, before handing off to `quality-gate`.

## Anti-patterns to flag

- DTO declared as `class` instead of `record`.
- `@Autowired` on a field or setter.
- `@Inject` constructor without `@Autowired` is fine; field/setter injection is not.
- `synchronized` block over an I/O call (defeats virtual threads).
- `Thread.sleep` in production code.
- `instanceof` chain that should be a `switch` pattern.
- Mutable DTO with public setters.
- `Optional` in field or method parameter (allowed only as return type).
- `@Value("...")` for typed config — should be `@ConfigurationProperties` record.
- Exception leaks: controller method declares `throws Exception`.
- Raw types or `List<?>` used as input parameters.
- `new Date()`, `Calendar`, `SimpleDateFormat` — use `java.time`.
- `System.out` / `printStackTrace` in production code.

## Spring AI specifics

- Direct `ChatModel` use in a controller (should go through `ChatClient`).
- Manual JSON parsing of an AI response (should use structured output converters).
- Tool method without `@Tool` annotation but described in prompt as a tool.

## Output

`.sylvain/reports/java25-idioms-<timestamp>.md` — one section per anti-pattern, with file + line + suggested fix.

## Blocking rules

Any anti-pattern in the list → `blocked`, route back to `backend-builder`.
