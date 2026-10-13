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
| Agents | Personas + tool restrictions + handoffs. **Pure orchestration.** | `.github/agents/*.agent.md` |
| Skills | Portable executors. One responsibility each. **No code examples.** | `.github/skills/*/SKILL.md` |
| Prompts | Reusable slash commands. | `.github/prompts/*.prompt.md` |
| Instructions | Always-on rules with `applyTo` patterns. | `.github/instructions/*.instructions.md` |
| Hooks | Automated quality gates (size, doc, security). **Claude Code hook spec** — see note below. | `.github/hooks/*.json` |
| State | Persistent runtime info — todos, ADRs, version lock. | `.sylvain/` |
| Templates | Literal resource files (not code examples). | `templates/` |

## Data flow

1. User picks the **`sylvain`** agent (or types a `/...` prompt).
2. `sylvain` reads `.sylvain/todo.json`, plans via `manage-task-todo`.
3. `sylvain` hands off to a specialist, which calls one or more skills.
4. Each skill reports back; the agent updates the todo state.
5. `quality-gate` and `security-guardian` validate before closure.
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

The hooks use the **Claude Code hook spec** (`PreToolUse`/`PostToolUse`/`SessionStart`
events, `hookSpecificOutput.permissionDecision: "deny"` blocking). Consequences:

- On a Claude-Code-compatible runtime → hooks can act as mechanical gates.
- On Codex, OpenCode and GitHub Copilot, do not assume those hook events run. The same
  rules are enforced procedurally through the shared instructions, skills and validation
  commands. Quality and security checks are mandatory on every runtime.
- Kit integrity is checked by `scripts/validate-kit.sh` (skills exist, handoffs resolve,
  templates exist, no version drift) — run it after any structural change.
