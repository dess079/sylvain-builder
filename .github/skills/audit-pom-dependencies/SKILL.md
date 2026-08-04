---
name: audit-pom-dependencies
description: Audits Maven dependencies (every pom.xml) for known CVEs and policy violations. Read-only. Blocks workflow on HIGH or CRITICAL findings.
context: fork
---

# audit-pom-dependencies
Me caveman. Me audit-pom-dependencies skill. Me do one thing and keep contract short.

## When to use

- After any `pom.xml` change.
- On the `pre-commit-security` hook.
- On demand via `/security-scan`.

## Required scans

1. **OWASP Dependency-Check** (`mvn -q org.owasp:dependency-check-maven:check`).
2. **Trivy** (`trivy fs --scanners vuln pom.xml`) for cross-validation.
3. **License check** — flag GPL/AGPL where the project policy forbids them.
4. **Convergence check** — `mvn -q dependency:tree -Dverbose` must show zero conflicts.
5. **Version policy** — every version pinned (no `LATEST`, `RELEASE`, range). Cross-check against `.sylvain/compatibility-matrix.json`.

## Output

A single Markdown report at `.sylvain/reports/pom-audit-<timestamp>.md` with:

- Severity (CRITICAL / HIGH / MEDIUM / LOW).
- CVE ID, affected GAV, fixed version range.
- File + line.
- Recommended action (bump, exclude, or accept with ADR).

## Blocking rules

- Any CVSS ≥ 7.0 → block.
- Banned license → block.
- Unpinned version → block.

## Failure modes

- Tooling missing → install via Maven plugin or Homebrew (Trivy), document in report.
