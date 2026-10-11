# sylvain-builder

Orchestration kit for building **full-stack Spring Boot 4.0.7 + Spring AI 2.0.0-M6 + Java 25 + React 19.2.6** applications using VS Code custom agents, skills, prompts, instructions and hooks.

> **Hook runtime note** — hooks follow the Claude Code hook spec. On GitHub Copilot chat
> they are not executed; the same rules then stay enforced procedurally through the
> mandatory quality/security skills. See `docs/ARCHITECTURE.md` → "Hook runtime compatibility".
> Kit integrity is verified by `scripts/validate-kit.sh`.

## Stack (locked — May 2026)

| Layer    | Version                                          |
| -------- | ------------------------------------------------ |
| Java     | 25 LTS (records, virtual threads, sealed types)  |
| Spring Boot | 4.0.7                                         |
| Spring AI | 2.0.0-M6 (milestone)                            |
| React    | 19.2.6 (Compiler 1.0 stable)                     |
| Vite     | 8.x                                              |
| TypeScript | 6.0                                            |
| Node     | 22 LTS                                           |

## Core principles

1. **Agents orchestrate, skills execute.** Agents contain zero domain logic — they route tasks to skills.
2. **No code examples in skills.** Skills describe *what* and *why*; the AI already knows *how*. Templates live in `templates/` if a literal file is required.
3. **100-line hard cap** on every generated file. Enforced via hook + skill `enforce-file-size-limit`.
4. **Documentation mandatory** on every class/method/component/function (Javadoc/JSDoc).
5. **Backend has JUnit tests. Frontend has none.** Enforced via instruction files.
6. **Security is blocking, not advisory.** `pre-commit-security` hook fails the commit on HIGH+ CVE.
7. **Every task carries a todo list** persisted in `.sylvain/todo.json` so work can resume after interruption.
8. **Java 25 idioms 2026**: records for DTOs, virtual threads, pattern matching, constructor injection, no `@Autowired` on fields.
9. **React 19 idioms 2026**: Compiler-friendly (no manual `useMemo`/`useCallback`/`memo`), Actions, `use()`, `useOptimistic`, Rules of React.

## Layout

```
.github/
  agents/        — orchestrators (.agent.md)
  skills/        — executors (SKILL.md per skill)
  prompts/       — slash commands (.prompt.md)
  instructions/  — always-on rules (.instructions.md)
  hooks/         — automated quality gates (.json)
.sylvain/        — runtime state (todo.json, ADRs, compatibility matrix)
docs/            — architecture, decision log, extension guide
templates/       — version/plugin manifests (pom, package.json)
```

## Entry point

The `sylvain` agent is the only orchestrator users interact with. It dispatches to:

- `architect` — design + scaffolding
- `backend-builder` — Spring Boot / Spring AI code
- `frontend-builder` — React 19 code
- `security-guardian` — CVE + OWASP scans (read-only)
- `quality-gate` — size/doc/idiom/build verification (read-only)

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/PLAN.md](docs/PLAN.md), [docs/HOW-TO-EXTEND.md](docs/HOW-TO-EXTEND.md).

## Use it

Open this folder in VS Code (or add it to a multi-root workspace) and pick the **`sylvain`** agent in the chat dropdown. Then ask, e.g. `/new-feature add a /users search endpoint`.
