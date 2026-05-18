---
name: scan-source-vulnerabilities
description: Scans backend and frontend source code against the OWASP Top 10 and selected CWEs. Read-only. Special focus on prompt-injection vectors for Spring AI tool calls.
context: fork
---

# scan-source-vulnerabilities

## When to use

- After any source file change in backend or frontend.
- On the `pre-commit-security` hook.

## What to look for

**Backend (Java)**

- SQL Injection — string concatenation in JPQL / native queries.
- Insecure deserialisation — Java serialization of untrusted input.
- SSRF — outbound HTTP calls with user-controlled URLs.
- Path traversal — `Paths.get(userInput)` without normalisation.
- Hardcoded secrets — API keys, JWT keys, DB passwords in source.
- Spring AI specifics:
  - Tool functions accepting unvalidated `String` arguments → prompt-injection vector.
  - User content placed inside system prompts without delimiter / sanitisation.
  - RAG retrieval not filtering by tenant / user scope.
- Missing authorisation on a controller method (`@PreAuthorize` absent on a non-public route).

**Frontend (TS/React)**

- `dangerouslySetInnerHTML` with non-trusted source.
- `href` / `src` built from user input without scheme validation.
- localStorage / sessionStorage holding tokens (prefer in-memory or httpOnly cookies).
- `eval`, `new Function`, dynamic `import()` from user input.
- Missing CSP-friendly inline-style avoidance.

## Output

`.sylvain/reports/source-scan-<timestamp>.md`, file + line + CWE + remediation.

## Blocking rules

- Any HIGH severity finding.
- Any hardcoded secret.

## Failure modes

- AST parser fails on a file → flag as `blocked`, surface for `quality-gate`.
