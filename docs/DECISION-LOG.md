# Decision log

Append-only log of architectural / process decisions made on this orchestration kit itself
(separate from `.sylvain/architecture-decisions.md` which logs decisions about the apps it builds).

Format:

```
## YYYY-MM-DD — title
- Context:
- Decision:
- Consequences:
```

---

## 2026-05-05 — Initial creation

- Context: User requested an orchestrator + skills set to build full-stack apps with strict size, doc, security and idiom rules.
- Decision: 6 agents + 19 skills + 4 prompts + 5 instructions + 4 hooks. Strict separation: agents orchestrate, skills execute. No inline code examples. Templates live in `templates/`.
- Consequences: Every new capability must follow `docs/HOW-TO-EXTEND.md`. The compatibility matrix is the single version source of truth.

## 2026-05-05 — Stack lock

- Context: Multiple Spring Boot / Spring AI / Java / React versions exist in mid-2026.
- Decision: Lock to Spring boot 4.0.7, Spring AI 2.0.0-M6, Java 25 LTS, React 19.2.6, Vite 8, TS 6, Node 22 LTS.
- Consequences: Any drift requires a new ADR + matrix bump.

## 2026-05-05 — No frontend tests

- Context: Owner directive — backend coverage is mandatory; frontend tests are forbidden.
- Decision: `frontend.instructions.md` blocks creation of any test file. `audit-npm-dependencies` blocks installation of test frameworks. `validate-react19-idioms` raises a hard refusal.
- Consequences: Frontend regressions caught only at build/lint/manual QA. Acknowledged risk.
