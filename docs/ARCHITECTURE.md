# Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                            User                                   │
│                              │                                    │
│                              ▼                                    │
│                       ┌──────────────┐                            │
│                       │   sylvain    │  (orchestrator)            │
│                       └──────┬───────┘                            │
│           ┌──────────────────┼───────────────────┐               │
│           ▼                  ▼                   ▼               │
│     ┌──────────┐       ┌─────────────┐    ┌──────────────┐      │
│     │architect │       │backend-     │    │frontend-     │      │
│     │          │──────▶│builder      │    │builder       │      │
│     └──────────┘       └─────┬───────┘    └──────┬───────┘      │
│                              │                   │              │
│                              ▼                   ▼              │
│                       ┌──────────────┐    ┌──────────────┐      │
│                       │security-     │    │quality-      │      │
│                       │guardian      │    │gate          │      │
│                       └──────────────┘    └──────────────┘      │
│                              │                   │              │
│                              └─────────┬─────────┘              │
│                                        ▼                         │
│                                    sylvain (summary)            │
└──────────────────────────────────────────────────────────────────┘
```

## Pillars

| Pillar | What | Where |
|---|---|---|
| Agents | Personas + tool restrictions + handoffs. **Pure orchestration.** | `.github/agents/*.agent.md` |
| Skills | Portable executors. One responsibility each. **No code examples.** | `.github/skills/*/SKILL.md` |
| Prompts | Reusable slash commands. | `.github/prompts/*.prompt.md` |
| Instructions | Always-on rules with `applyTo` patterns. | `.github/instructions/*.instructions.md` |
| Hooks | Automated quality gates (size, doc, security). | `.github/hooks/*.json` |
| State | Persistent runtime info — todos, ADRs, version lock. | `.sylvain/` |
| Templates | Literal resource files (not code examples). | `templates/` |

## Data flow

1. User picks the **`sylvain`** agent (or types a `/...` prompt).
2. `sylvain` reads `.sylvain/todo.json`, plans via `manage-task-todo`.
3. `sylvain` hands off to a specialist, which calls one or more skills.
4. Each skill reports back; the agent updates the todo state.
5. `quality-gate` and `security-guardian` validate before closure.
6. `sylvain` produces a final summary and a list of touched files.

## Hard rules (cross-cutting)

- 100-line file cap (hook + `enforce-file-size-limit`).
- Mandatory docs (`enforce-documentation`).
- Backend tests mandatory; **frontend tests forbidden**.
- HIGH+ CVE blocks the workflow.
- Java 25 + Spring boot 4.0.7 + Spring AI 2.0.0-M6 + React 19.2.6 versions locked in `compatibility-matrix.json`.
