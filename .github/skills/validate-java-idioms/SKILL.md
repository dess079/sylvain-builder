---
name: validate-java-idioms
description: Validates Java and Spring Boot idioms against the Java version locked in the compatibility matrix. Read-only; reports anti-patterns to fix.
---

# validate-java-idioms

Use after a backend change and before quality review. Read the Java and Spring
Boot versions from `.sylvain/compatibility-matrix.json`; do not encode them in
this skill's identifier or report filename.

## Flag

- Mutable DTOs instead of `record`, field/setter injection, raw types, legacy
  date/time APIs, `System.out`/`printStackTrace`, exception leakage from a
  controller and `Optional` outside a return type.
- I/O under `synchronized`, production `Thread.sleep`, or an `instanceof` chain
  where a pattern `switch` is clearer.
- Untyped `@Value` configuration where a record
  `@ConfigurationProperties` belongs.
- A controller using `ChatModel` directly, manually parsing model JSON or
  exposing an untyped/unvalidated AI tool.

## Output and result

Write `.sylvain/reports/java-idioms-<timestamp>.md` with file, line and a
suggested correction. Any finding blocks completion until the responsible
backend change is corrected.
