# Plan — sylvain-builder (October 2026)

> Captured plan that produced this project. Living documentation.
> Stack: Spring Boot 4.1.1 · Spring AI 2.0.1 · Java 27 · React 19.3 · MUI 9.4 · Vite 8 · TS 7 · Node 26 LTS.

## 1. Best practices retained (web-scanned)

- **Java 27** — `record` for DTOs, sealed types, pattern matching and virtual threads.
- **Spring Boot 4.1.1** — constructor injection, record `@ConfigurationProperties`, `ProblemDetail`, Bean Validation and virtual threads.
- **Spring AI 2.0.1** — `ChatClient`, advisors, structured output to records, typed tools, PgVector and prompt assets in `*.st` files.
- **React 19.3 + Compiler 1.0 + MUI 9.4** — no manual `useMemo`/`useCallback`/`memo`; actions, `useOptimistic`, `useTransition`, Suspense and accessible components.
- **Vite 8.3 + TS 7 + eslint-plugin-react-hooks 7.1.1 + Node 26**.
- **VS Code customization** — agents and skills are on demand; instructions are file-scoped; only an active todo summary may enter a session. Forked context is reserved for isolated audits.

## 2. Non-negotiable principles

| Principle | Application |
|---|---|
| Agent = focused perspective | Direct work or delegation is chosen by task complexity and review value. |
| Skill = reusable guidance | Constraints and validation live here; the model chooses the implementation. |
| No boilerplate templates | The version matrix and scoped instructions generate project-specific manifests. |
| Cohesion review | Review source files above 300 lines; split only on a real boundary. |
| Useful docs | Document non-obvious public contracts. |
| Behaviour tests | JUnit backend; Vitest + RTL frontend. |
| Security blocking | Worktree-bound Gitleaks, Semgrep, dependency, Trivy and CodeQL gates stop the workflow. |
| Shared UI first | Reuse public `shared-components`; promote generic cross-app UI into the library. |
| Persistent todos | `.sylvain/todo.json` so work resumes after interruption. |

## 3. Agents (9, adaptive collaboration)

| Agent | Role | Handoffs |
|---|---|---|
| **sylvain** ★ | Entry point. Reads todos, routes. | architect, backend-builder, frontend-builder |
| **architect** | Structure, modules, contracts, ADRs. | backend-builder |
| **backend-builder** | Spring Boot + Spring AI. Forces JUnit. | quality-gate, security-guardian |
| **frontend-builder** | React 19.3 + MUI 9 and focused UI tests. | quality-gate, security-guardian |
| **database** | PostgreSQL schema and Flyway migration workflow. | backend-builder, security-guardian |
| **prompt-caveman** | Spring AI prompt-template review. | sylvain |
| **cloudflare-tunnel** | Optional public tunnel provisioning. | sylvain |
| **security-guardian** | CVE + OWASP scans. Blocks on HIGH+. | sylvain |
| **quality-gate** | Size, docs, idioms, build. | sylvain |

Agents load specialist material only when it improves the current task; historic
todos and unrelated rules stay out of context.

## 4. Skills (30)

The `.github/skills/` directory is the complete index. Its skills are selected
by trigger, not read as a bundle: scaffold/evolution; backend and database;
frontend, shared UI and visual design; tests; security; quality; workflow; and
the two explicit operations (Cloudflare tunnel and stopping a process by port).

## 5. Prompts · Hooks · Instructions

- **Prompts**: `/new-feature`, `/upgrade-deps`, `/security-scan`, `/resume-task`.
- **Hooks**: `session-start-load-todo` (only when work is active) and `pre-commit-security`.
- **Instructions** (scoped): `global` (application source), `backend` (`**/*.java`), `frontend` (`**/*.{tsx,jsx}`), `security` (source/config/prompts), `pom` (`**/pom.xml`) and `package-json` (`**/package.json`).

## 6. Typical flow

```
/new-feature add a /users search endpoint
  → sylvain ─ manage-task-todo
  → architect ─ generate-typescript-types
  → backend-builder ─ generate-jpa-entity → generate-rest-endpoint → generate-junit-test → validate-java25-idioms
  → frontend-builder ─ reuse-shared-components → generate-react-hook → generate-react-screen → generate-react-test → validate-react19-idioms
  → security-guardian ─ run-security-gate + scan-source-vulnerabilities + audits
  → quality-gate ─ enforce-file-size-limit + enforce-documentation + progressive-build-verify
  → sylvain ─ summary + final todo update
```

## 7. Beyond the basics

- `.sylvain/compatibility-matrix.json` version lock.
- `.sylvain/architecture-decisions.md` auto-appended ADRs.
- PreCommit security hook blocks (not just warns).
- Persistent on-disk todos survive restarts.
- Forked context only for independent security/version/prompt audits; it is not a default.
- Adaptive agent/skill use — no mandatory call graph or artificial tool limits.
- No code or manifest templates; the compatibility matrix is the durable baseline.
- See [ARCHITECTURE.md](ARCHITECTURE.md), [HOW-TO-EXTEND.md](HOW-TO-EXTEND.md), [DECISION-LOG.md](DECISION-LOG.md).
