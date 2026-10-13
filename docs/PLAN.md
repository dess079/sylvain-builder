# Plan — sylvain-builder (October 2026)

> Captured plan that produced this project. Living documentation.
> Stack: Spring Boot 4.1.1 · Spring AI 2.0.1 · Java 27 · React 19.3 · MUI 9.4 · Vite 8 · TS 7 · Node 26 LTS.

## 1. Best practices retained (web-scanned)

- **Java 27** — `record` for DTOs, sealed types, pattern matching and virtual threads.
- **Spring Boot 4.1.1** — constructor injection, record `@ConfigurationProperties`, `ProblemDetail`, Bean Validation and virtual threads.
- **Spring AI 2.0.1** — `ChatClient`, advisors, structured output to records, typed tools, PgVector and prompt assets in `*.st` files.
- **React 19.3 + Compiler 1.0 + MUI 9.4** — no manual `useMemo`/`useCallback`/`memo`; actions, `useOptimistic`, `useTransition`, Suspense and accessible components.
- **Vite 8.3 + TS 7 + eslint-plugin-react-hooks 7.1.1 + Node 26**.
- **VS Code customization** — 4 pillars: agents (orchestrate), skills (execute), prompts (slash), instructions (always-on). Hooks for automated gates. `context: fork` for heavy skills.

## 2. Non-negotiable principles

| Principle | Application |
|---|---|
| Agent = conductor | No business logic in `.agent.md`. Routes only. |
| Skill = expert executor | All "how-to" lives here. One responsibility each. |
| No code examples | None in skills. `templates/` for literal files. |
| Cohesion review | Review source files above 300 lines; split only on a real boundary. |
| Useful docs | Document non-obvious public contracts. |
| Behaviour tests | JUnit backend; Vitest + RTL frontend. |
| Security blocking | HIGH+ CVE stops the workflow. |
| Persistent todos | `.sylvain/todo.json` so work resumes after interruption. |

## 3. Agents (9, pure orchestration)

| Agent | Role | Handoffs |
|---|---|---|
| **sylvain** ★ | Entry point. Reads todos, routes. | architect, backend-builder, frontend-builder |
| **architect** | Structure, modules, contracts, ADRs. | backend-builder |
| **backend-builder** | Spring Boot + Spring AI. Forces JUnit. | quality-gate, security-guardian |
| **frontend-builder** | React 19.3 + MUI 9 and focused UI tests. | quality-gate, security-guardian |
| **database** | PostgreSQL schema and Flyway migration workflow. | backend-builder, security-guardian |
| **prompt-caveman** | Spring AI prompt-template review. | sylvain |
| **cloudflare-tunnel** | Optional public tunnel provisioning. | sylvain |
| **security-guardian** | CVE + OWASP scans. Read-only. Blocks on HIGH+. | sylvain |
| **quality-gate** | Size, docs, idioms, build. Read-only. | sylvain |

All agents load `agents/shared/orchestration.md` + `agents/shared/no-code-examples.md`.

## 4. Skills (26)

- **Scaffolding** (1): `scaffold-fullstack-app`.
- **Backend gen** (4): `generate-spring-boot-module`, `generate-spring-ai-feature`, `generate-jpa-entity`, `generate-rest-endpoint`.
- **Frontend gen** (3): `generate-react-screen`, `generate-react-hook`, `generate-typescript-types`.
- **Tests** (3): `generate-junit-test`, `generate-integration-test`, `generate-react-test`.
- **Security** (3): `audit-pom-dependencies`, `audit-npm-dependencies`, `scan-source-vulnerabilities`.
- **Quality / 2026 idioms** (4): `validate-java25-idioms`, `validate-react19-idioms`, `enforce-file-size-limit`, `enforce-documentation`.
- **Workflow / state** (2): `progressive-build-verify`, `manage-task-todo`.

## 5. Prompts · Hooks · Instructions

- **Prompts**: `/new-feature`, `/upgrade-deps`, `/security-scan`, `/resume-task`.
- **Hooks**: `session-start-load-todo`, `post-tool-use-size-check`, `post-tool-use-doc-check`, `pre-commit-security`.
- **Instructions** (always-on): `global` (`**`), `backend` (`**/*.java`), `frontend` (`**/*.{ts,tsx}`), `pom` (`**/pom.xml`), `package-json` (`**/package.json`).

## 6. Typical flow

```
/new-feature add a /users search endpoint
  → sylvain ─ manage-task-todo
  → architect ─ generate-typescript-types
  → backend-builder ─ generate-jpa-entity → generate-rest-endpoint → generate-junit-test → validate-java25-idioms
  → frontend-builder ─ generate-react-hook → generate-react-screen → generate-react-test → validate-react19-idioms
  → security-guardian ─ scan-source-vulnerabilities + audits if deps changed
  → quality-gate ─ enforce-file-size-limit + enforce-documentation + progressive-build-verify
  → sylvain ─ summary + final todo update
```

## 7. Beyond the basics

- `.sylvain/compatibility-matrix.json` version lock.
- `.sylvain/architecture-decisions.md` auto-appended ADRs.
- PreCommit security hook blocks (not just warns).
- Persistent on-disk todos survive restarts.
- `context: fork` on heavy skills.
- Strict agent/skill split — no technical "how-to" in `.agent.md`.
- Templates in `templates/`.
- See [ARCHITECTURE.md](ARCHITECTURE.md), [HOW-TO-EXTEND.md](HOW-TO-EXTEND.md), [DECISION-LOG.md](DECISION-LOG.md).
