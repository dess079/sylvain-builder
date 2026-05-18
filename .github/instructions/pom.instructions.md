---
applyTo: "**/pom.xml"
description: Maven POM rules — Spring Boot 4.0.6 + Spring AI 2.0.0-M6.
---

# pom.xml rules

- Parent: `spring-boot-starter-parent` **4.0.6** (or BOM import if multi-module).
- `<java.version>25</java.version>`.
- Spring AI BOM: `org.springframework.ai:spring-ai-bom:1.1.5` imported in `dependencyManagement`.
- All versions of internal/3rd-party deps are pinned (no `LATEST`, no `RELEASE`, no version ranges).
- Mandatory plugins:
  - `org.owasp:dependency-check-maven` — fails build on CVSS ≥ 7.
  - `org.apache.maven.plugins:maven-enforcer-plugin` — bans duplicate deps and convergence issues.
  - `org.springframework.boot:spring-boot-maven-plugin` for builds.
- No SNAPSHOT in committed `pom.xml` unless module is internal.
- Test scope: JUnit 5, AssertJ, Mockito, Testcontainers, Spring Boot test, `spring-ai-test`.
- Deviation requires an ADR entry in `.sylvain/architecture-decisions.md`.
