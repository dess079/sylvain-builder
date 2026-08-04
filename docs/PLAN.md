# Plan — sylvain-builder (May 2026)

> Captured plan that produced this project. Living documentation.
> Stack: Spring boot 4.0.7 · Spring AI 2.0.0-M6 · Java 25 · React 19.2.6 · Vite 8 · TS 6 · Node 22 LTS.

## 1. Best practices retained (web-scanned)

- **Java 25** — `record` for DTOs, sealed types, pattern matching, virtual threads default-on, `Stream.gather`.
- **Spring boot 4.0.7** — constructor injection only, `@ConfigurationProperties` records, `ProblemDetail` (RFC 7807), Bean Validation, virtual threads enabled.
- **Spring AI 2.0.0-M6** — `ChatClient` (fluent), Advisors, structured output to records, `@Tool` for function calling, PgVector for RAG, prompts in `*.st` files. Options builder-only; explicit `conversationId` required.
- **React 19.2 + Compiler 1.0** — no manual `useMemo`/`useCallback`/`memo`, Actions + `useActionState` + `useOptimistic` + `useTransition`, `use(promise)`, `<Suspense>`. Min versions: `19.0.1 / 19.1.2 / 19.2.1` (Dec 2025 RSC CVEs).
- **Vite 8 + TS 6 + eslint-plugin-react-hooks 7.1.1**. CRA dead since Feb 2025.
- **VS Code customization** — 4 pillars: agents (orchestrate), skills (execute), prompts (slash), instructions (always-on). Hooks for automated gates. `context: fork` for heavy skills.

## 2. Non-negotiable principles

| Principle | Application |
|---|---|
| Agent = conductor | No business logic in `.agent.md`. Routes only. |
| Skill = expert executor | All "how-to" lives here. One responsibility each. |
| No code examples | None in skills. `templates/` for literal files. |
| 100-line cap | Hook + `enforce-file-size-limit`. Split or refuse. |
| Mandatory docs | Javadoc / TSDoc on every public symbol. |
| Backend = JUnit required, Frontend = NO tests | Enforced via instructions and idiom skills. |
| Security blocking | HIGH+ CVE stops the workflow. |
| Persistent todos | `.sylvain/todo.json` so work resumes after interruption. |

## 3. Agents (6, pure orchestration)

| Agent | Role | Handoffs |
|---|---|---|
| **sylvain** ★ | Entry point. Reads todos, routes. | architect, backend-builder, frontend-builder |
| **architect** | Structure, modules, contracts, ADRs. | backend-builder |
| **backend-builder** | Spring Boot + Spring AI. Forces JUnit. | quality-gate, security-guardian |
| **frontend-builder** | React 19. Refuses tests. | quality-gate, security-guardian |
| **security-guardian** | CVE + OWASP scans. Read-only. Blocks on HIGH+. | sylvain |
| **quality-gate** | Size, docs, idioms, build. Read-only. | sylvain |

All agents load `agents/shared/orchestration.md` + `agents/shared/no-code-examples.md`.

## 4. Skills (19)

- **Scaffolding** (1): `scaffold-fullstack-app`.
- **Backend gen** (4): `generate-spring-boot-module`, `generate-spring-ai-feature`, `generate-jpa-entity`, `generate-rest-endpoint`.
- **Frontend gen** (3): `generate-react-screen`, `generate-react-hook`, `generate-typescript-types`.
- **Tests** (2): `generate-junit-test`, `generate-integration-test`.
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
  → frontend-builder ─ generate-react-hook → generate-react-screen → validate-react19-idioms
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
