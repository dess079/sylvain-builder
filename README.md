# sylvain-builder

Portable orchestration kit for building **full-stack Spring Boot 4.1.1 + Spring AI 2.0.1 + Java 27 + React 19.3 + MUI 9.4** applications with Codex, OpenCode, Claude Code and GitHub Copilot.

> **Portable validation** — Claude-compatible hooks are optional accelerators, never the
> only gate. Every runtime follows `AGENTS.md` and validates with project commands plus
> `scripts/validate-kit.sh` for this kit.
> Kit integrity is verified by `scripts/validate-kit.sh`.

## Stack (locked — October 2026)

| Layer    | Version                                          |
| -------- | ------------------------------------------------ |
| Java     | 27                                               |
| Spring Boot | 4.1.1                                         |
| Spring AI | 2.0.1 (GA)                                      |
| React    | 19.3.0 (Compiler 1.0)                            |
| MUI      | 9.4.0                                            |
| Vite     | 8.3.4                                            |
| TypeScript | 7.0.2                                           |
| Node / pnpm | 26 LTS / 12.11.2                              |

## Core principles

1. **Agents orchestrate, skills execute.** Agents contain zero domain logic — they route tasks to skills.
2. **No code examples in skills.** Skills describe *what* and *why*; the AI already knows *how*. Templates live in `templates/` if a literal file is required.
3. **Cohesion over artificial line limits.** Files over 300 lines are reviewed, not mechanically fragmented.
4. **Useful documentation** on non-obvious public contracts.
5. **Tests for changed behaviour:** JUnit on the backend; Vitest + React Testing Library on the frontend.
6. **Security is blocking, not advisory.** `pre-commit-security` hook fails the commit on HIGH+ CVE.
7. **Every task carries a todo list** persisted in `.sylvain/todo.json` so work can resume after interruption.
8. **Java 27 idioms 2026**: records for DTOs, virtual threads, pattern matching, constructor injection, no `@Autowired` on fields.
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
.opencode/       — OpenCode primary and specialist agents
AGENTS.md        — shared project instructions (Codex + OpenCode)
CLAUDE.md        — Claude Code bridge to AGENTS.md
```

## Entry point

The `sylvain` agent is the entry point. It dispatches to:

- `architect` — design + scaffolding
- `backend-builder` — Spring Boot / Spring AI code
- `frontend-builder` — React 19 code
- `database` — PostgreSQL and Flyway migrations
- `prompt-caveman` — Spring AI prompt assets
- `security-guardian` — CVE + OWASP scans (read-only)
- `quality-gate` — size/doc/idiom/build verification (read-only)

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/PLAN.md](docs/PLAN.md), [docs/HOW-TO-EXTEND.md](docs/HOW-TO-EXTEND.md).

## Use it

| Runtime | Start |
| --- | --- |
| Codex | Run from the repository; it loads `AGENTS.md`. |
| OpenCode | Start in the repository; the default `.opencode` agent is `sylvain`. |
| Claude Code | Run `claude` from the repository; `CLAUDE.md` imports the shared rules. |
| GitHub Copilot | Open in VS Code and pick the **`sylvain`** custom agent. |

Then ask, for example: `/new-feature add a /users search endpoint`.
