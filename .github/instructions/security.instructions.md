---
name: security
description: Mandatory security baseline — OWASP Top 10 2025 + OWASP LLM Top 10 2025 + Spring AI hardening. Always active.
applyTo: "**"
---

# Security baseline (May 2026)

A finding at HIGH or CRITICAL severity halts the workflow until patched.

## OWASP Top 10 (2025) — backend & frontend

1. **Broken Access Control** — every endpoint declares `@PreAuthorize` or equivalent. Default-deny in `SecurityFilterChain`.
2. **Cryptographic Failures** — TLS 1.3, no MD5/SHA-1, secrets only via env or vault, never in `application.yml`.
3. **Injection** — JPA criteria/JPQL with parameters; never string-concatenated SQL. Output encoding via React (auto) and `HtmlUtils` server-side.
4. **Insecure Design** — threat-model new features in the ADR.
5. **Security Misconfiguration** — actuator endpoints restricted; CSP, HSTS, X-Frame-Options, X-Content-Type-Options headers set.
6. **Vulnerable Components** — `audit-pom-dependencies` and `audit-npm-dependencies` skills run on every PR.
7. **Authentication Failures** — Spring Security 7 with PBKDF2/Argon2; lock-out and rate-limit (Bucket4j).
8. **Software & Data Integrity** — verify Maven Central + npm signatures; SLSA provenance encouraged.
9. **Logging & Monitoring** — Micrometer + structured logs; never log secrets, tokens, PII.
10. **SSRF** — outbound HTTP via allowlist; Spring AI tool calls validated against an allowlist.

## OWASP LLM Top 10 (2025) — Spring AI features

- **LLM01 Prompt Injection** — sanitize untrusted input before concatenation; use Spring AI `Advisor` chain; tool-call inputs validated server-side.
- **LLM02 Sensitive Information Disclosure** — never include secrets, PII, or full DB rows in prompts; redact via advisor.
- **LLM03 Supply Chain** — pin model versions; verify provider TLS; review tool dependencies.
- **LLM04 Data & Model Poisoning** — validate RAG sources; sign embeddings provenance.
- **LLM05 Improper Output Handling** — treat LLM output as untrusted; validate JSON via `BeanOutputConverter` schema; never `eval`.
- **LLM06 Excessive Agency** — tool functions must be idempotent or guarded; explicit allowlist; no shell, no arbitrary HTTP.
- **LLM07 System Prompt Leakage** — system prompts loaded from classpath, not user-overridable.
- **LLM08 Vector & Embedding Weaknesses** — PgVector queries scoped per tenant; access control on metadata filter.
- **LLM09 Misinformation** — display source citations from RAG; never claim authority on hallucinations.
- **LLM10 Unbounded Consumption** — per-user token quotas + rate limits on chat endpoints.

## Frontend specifics (React 19.2)

- Patched RSC: ≥ 19.0.6 / 19.1.7 / 19.2.6 (Dec 2025 RSC CVEs).
- CSP: `default-src 'self'; script-src 'self'; object-src 'none'; frame-ancestors 'none'`.
- No `dangerouslySetInnerHTML` without server-side sanitization (DOMPurify on backend if absolutely needed).
- Never store JWT in `localStorage` — use httpOnly secure cookie + CSRF token.

## Mandatory tooling

- `spotbugs-maven-plugin` with `find-sec-bugs`.
- `dependency-check-maven` (OWASP) — fail on CVSS ≥ 7.
- `gitleaks` pre-commit (secret scanning).
- `trivy fs` for image scanning (Docker stages).
- CycloneDX SBOM generated on every release.

## Forbidden patterns (auto-flagged)

- `Runtime.exec`, `ProcessBuilder` with user input
- `ObjectInputStream` on untrusted bytes
- `Cipher.getInstance("AES")` (defaults to ECB)
- `eval`, `new Function`, `dangerouslySetInnerHTML` in React
- Hardcoded API keys, JWTs, connection strings

If a generated diff contains any of the above, the `security-guardian` agent blocks the commit.
