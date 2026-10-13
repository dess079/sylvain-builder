# Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                            User                                   │
│                              │                                    │
│                              ▼                                    │
│                       ┌──────────────┐                            │
│                       │   sylvain    │  (orchestrator)            │
│                       └──────┬───────┘                            │
│                              │                                    │
│     direct specialists: database · prompt-caveman · cloudflare-   │
│     tunnel · security-guardian · quality-gate                     │
│                              │                                    │
│                              ▼                                    │
│                       ┌──────────────┐                            │
│                       │  architect   │                            │
│                       └──┬───────┬───┘                            │
│            ┌─────────────┘       └─────────────┐                  │
│            ▼                                   ▼                  │
│     ┌──────────────┐                 ┌──────────────┐            │
│     │backend-      │                 │frontend-     │            │
│     │builder       │                 │builder       │            │
│     └──┬───────────┘                 └──┬───────────┘            │
│        │                                │                        │
│        └───────────┬────────────────────┘                        │
│                    ▼                                              │
│     ┌──────────────┐         ┌──────────────┐                    │
│     │security-     │         │quality-      │                    │
│     │guardian      │         │gate          │                    │
│     └──────┬───────┘         └──────┬───────┘                    │
│            │                        │                            │
│            └───────────┬────────────┘                            │
│                        ▼                                         │
│                   sylvain (summary)                              │
└──────────────────────────────────────────────────────────────────┘
```

## Pillars

| Pillar | What | Where |
|---|---|---|
| Agents | Focused perspectives, optional handoffs and task-specific guidance. | `.github/agents/*.agent.md` |
| Skills | Reusable constraints and validation procedures, loaded only when relevant. | `.github/skills/*/SKILL.md` |
| Prompts | Reusable slash commands. | `.github/prompts/*.prompt.md` |
| Instructions | Rules scoped by `applyTo`; only the matching file context is loaded. | `.github/instructions/*.instructions.md` |
| Hooks | Focused session/commit gates; CI remains the required security authority. | `.github/hooks/*.json` |
| State | Persistent runtime info — todos, ADRs, version lock. | `.sylvain/` |
| Version contract | Exact supported baseline and security-tool versions. | `.sylvain/compatibility-matrix.json` |

## Data flow

1. User picks the **`sylvain`** agent (or types a `/...` prompt).
2. `sylvain` reads only an active/blocked todo summary when one exists; it uses `manage-task-todo` for non-trivial work.
3. `sylvain` either completes a scoped change directly or asks a specialist for independent expertise.
4. Relevant skills provide constraints and validation without prescribing the implementation.
5. `quality-gate` and `security-guardian` validate risk-bearing changes before closure.
6. `sylvain` produces a final summary and a list of touched files.

## Portable runtime model

`AGENTS.md` is the repository-wide source for Codex and OpenCode. `CLAUDE.md`
imports it for Claude Code. GitHub Copilot uses the custom agents, skills and
instructions in `.github/`; OpenCode exposes equivalent entry points under
`.opencode/agents/`. The detailed workflow remains shared in `.github/skills/`.

## Hard rules (cross-cutting)

- Cohesion review above 300 source lines (`enforce-file-size-limit`).
- Useful public-contract docs (`enforce-documentation`).
- Backend and frontend behaviour tests mandatory.
- HIGH+ CVE blocks the workflow.
- Java 27 + Spring Boot 4.1.1 + Spring AI 2.0.1 + React 19.3 versions locked in `compatibility-matrix.json`.

## Hook runtime compatibility

The JSON files use the VS Code-compatible PascalCase events. The commit guard
reads the hook event from stdin and denies a commit unless the deterministic
security report matches the exact worktree. Hooks are optional accelerators:
their event schemas and discovery vary by harness, and they must be tested in
each supported runtime. `scripts/security-scan.sh` and the GitHub Actions
workflow are the portable authorities; Codex, OpenCode and Claude must run the
script explicitly when their hook runtime is unavailable.

Kit integrity is checked by `scripts/validate-kit.sh` (skills exist, handoffs
resolve, no boilerplate templates remain, hooks and policy files parse, context
budgets hold, version contract is complete) — run
it after any structural change.
