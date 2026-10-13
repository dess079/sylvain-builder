---
applyTo: "**/pom.xml"
description: Maven POM rules — Spring Boot 4.1.1 + Spring AI 2.0.1.
---

# pom.xml rules

- Parent: `spring-boot-starter-parent` **4.1.1** (or BOM import if multi-module).
- `<java.version>27</java.version>`.
- Spring AI BOM: `org.springframework.ai:spring-ai-bom:2.0.1` imported in `dependencyManagement`.
- All versions of internal/3rd-party deps are pinned (no `LATEST`, no `RELEASE`, no version ranges).
- Mandatory plugins:
  - `org.owasp:dependency-check-maven` — fails build on CVSS ≥ 7.
  - `com.github.spotbugs:spotbugs-maven-plugin` + FindSecBugs — bound to `verify` and fails on security findings.
  - `org.apache.maven.plugins:maven-enforcer-plugin` — bans duplicate deps and convergence issues.
  - `org.springframework.boot:spring-boot-maven-plugin` for builds.
- No SNAPSHOT in committed `pom.xml` unless module is internal.
- Test scope: JUnit 6, AssertJ, Mockito, Testcontainers, Spring Boot test, `spring-ai-test`.
- Deviation requires an ADR entry in `.sylvain/architecture-decisions.md`.
