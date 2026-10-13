# sylvain-builder

Portable orchestration kit for building **full-stack Spring Boot 4.1.1 + Spring AI 2.0.1 + Java 27 + React 19.3 + MUI 9.4** applications with Codex, OpenCode, Claude Code and GitHub Copilot.

> **Portable validation** — workspace hooks are optional accelerators, never the
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

1. **Agents and skills are adaptive guidance.** They provide relevant constraints and review perspectives; a capable agent may work directly when that is clearer than a handoff.
2. **No boilerplate templates.** The AI generates project-specific code and manifests from the version matrix and the applicable rules; skills state outcomes, invariants and validation.
3. **Cohesion over artificial line limits.** Files over 300 lines are reviewed, not mechanically fragmented.
4. **Useful documentation** on non-obvious public contracts.
5. **Tests for changed behaviour:** JUnit on the backend; Vitest + React Testing Library on the frontend.
6. **Security is blocking, not advisory.** `bash scripts/security-scan.sh` must pass for the exact diff before commit; CI repeats secrets, SAST, dependency and CodeQL gates.
7. **Only non-trivial, multi-step work carries a todo** in `.sylvain/todo.json`, so it can resume after interruption without adding state to simple tasks.
8. **Java 27 idioms 2026**: records for DTOs, virtual threads, pattern matching, constructor injection, no `@Autowired` on fields.
9. **React 19 idioms 2026**: Compiler-friendly (no manual `useMemo`/`useCallback`/`memo`), Actions, `use()`, `useOptimistic`, Rules of React.

## Layout

```
.github/
  agents/        — orchestrators (.agent.md)
  skills/        — executors (SKILL.md per skill)
  prompts/       — slash commands (.prompt.md)
  instructions/  — rules scoped by file type (.instructions.md)
  hooks/         — focused session/commit gates (.json)
  workflows/     — required CI security gates
.sylvain/        — runtime state (todo.json, ADRs, compatibility matrix)
docs/            — architecture, decision log, extension guide
.opencode/       — OpenCode primary and specialist agents
AGENTS.md        — shared project instructions (Codex + OpenCode)
CLAUDE.md        — Claude Code bridge to AGENTS.md
```

## Entry point

The `sylvain` agent is the entry point. It uses these specialists only when
their expertise or independent review improves the task:

- `architect` — design + scaffolding
- `backend-builder` — Spring Boot / Spring AI code
- `frontend-builder` — React 19 code
- `database` — PostgreSQL and Flyway migrations
- `prompt-caveman` — Spring AI prompt assets
- `cloudflare-tunnel` — explicitly requested public tunnel provisioning
- `security-guardian` — CVE + OWASP scans
- `quality-gate` — size/doc/idiom/build verification

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/PLAN.md](docs/PLAN.md), [docs/HOW-TO-EXTEND.md](docs/HOW-TO-EXTEND.md).

## Use it

| Runtime | Start |
| --- | --- |
| Codex | Run from the repository; it loads `AGENTS.md`. |
| OpenCode | Start in the repository; the default `.opencode` agent is `sylvain`. |
| Claude Code | Run `claude` from the repository; `CLAUDE.md` imports the shared rules. |
| GitHub Copilot | Open in VS Code and pick the **`sylvain`** custom agent. |

Then ask, for example: `/new-feature add a /users search endpoint`.

## Security gate

Run `bash scripts/security-scan.sh` after the final code change. It produces a
worktree-bound report under `.sylvain/reports/`; the commit hook accepts only a
fresh, passing report. The scanner fails closed when Gitleaks, Semgrep, Maven,
pnpm or Trivy are required but unavailable. CI pins its actions to immutable
commits, scopes write permissions to CodeQL and reviews dependency changes in PRs.

## Shared components

The canonical library is configured in `.sylvain/shared-components.json`.
Applications reuse its public `MenuBar`, `ThemeSelector`, `PreferencesPanel`,
`AiChatPanel`, `AiPromptCard` and `AiResponseBlock` surfaces. A generic UI
artifact that serves two applications is promoted to the library rather than
copied into each application.

## UI quality without a generic AI look

Two version-pinned, locally vendored skills are available on demand:
`frontend-design` makes a screen's visual direction specific to its product;
`ui-ux-pro-max` provides searchable local guidance for major UI decisions,
interaction design and visual QA. They are not loaded for backend or non-visual
tasks. Both are constrained by the MUI theme, accessibility and the
`shared-components` policy, so they improve design choices without creating a
second component system. Their source revisions and licences are recorded beside
each skill in `UPSTREAM.md`.
