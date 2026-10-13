# How to extend sylvain-builder

Adding a new capability without breaking the agent / skill split.

## Add a new skill

1. Create `.github/skills/<skill-name>/SKILL.md` (kebab-case, ≤ 64 chars, must match dir name).
2. Frontmatter:
   ```
   ---
   name: <skill-name>
   description: <when to use it, ≤ 1024 chars>
   ---
   ```
   Optional: `context: fork` for heavy/read-only skills.
3. Body sections (mandatory in this project):
   - **When to use** — concrete trigger.
   - **What it does** — contract, inputs, outputs.
   - **Required rules** — invariants the AI must respect.
   - **Validation** — how success is measured.
   - **Failure modes** — when to stop.
4. **NO code examples** in the body. If a literal file is needed, add it under `templates/` and link it via Markdown.
5. Reference the new skill from at least one agent's body and update its `Skills you call` list.

## Add a new agent

1. Create `.github/agents/<agent-name>.agent.md`.
2. Frontmatter must include: `name`, `description`, `tools`, `agents`, `handoffs`.
3. Body must reference `shared/orchestration.md` and `shared/no-code-examples.md`.
4. Body must contain a `Skills you call` section. **No technical "how-to" content** — the agent is an orchestrator.
5. Update `docs/ARCHITECTURE.md` if the routing diagram changes.
6. Append an ADR entry to `.sylvain/architecture-decisions.md`.

## Add a new prompt

1. Create `.github/prompts/<name>.prompt.md`.
2. Frontmatter: `description`, `agent` (the agent that should run it), optional `argument-hint`, `tools`.
3. Body: numbered steps describing the workflow. No code examples.

## Add a new instruction

1. Create `.github/instructions/<name>.instructions.md`.
2. Frontmatter: `applyTo` glob, `description`.
3. Body: short rules — one line each whenever possible.
4. Avoid duplication with existing instruction files.

## Add a new hook

1. Create `.github/hooks/<name>.json`.
2. Choose the right event (SessionStart / PreToolUse / PostToolUse / PreCompact / Stop).
3. Keep the command idempotent and fast (timeout in ms or s).
4. **Always exit 0 on warnings**; exit **2** when the action must be hard-blocked (e.g. missing security scan). Pass `hookSpecificOutput.permissionDecision: "deny"` for `PreToolUse` blocking hooks.

## Update the compatibility matrix

Edit `.sylvain/compatibility-matrix.json` AND append an ADR entry. Without the ADR the change is invalid.

Before proposing a bump, run `/suggest-stack` to get verified latest versions from the official sources listed in `instructions/web-references.instructions.md`.

## Current skills index

| Skill | Description |
|---|---|
| `scaffold-fullstack-app` | Brand-new monorepo from scratch |
| `modify-existing-app` | Add/change/remove a feature in an existing app |
| `suggest-latest-stack` | Cross-check matrix vs latest versions before each project |
| `generate-spring-boot-module` | Self-contained backend module |
| `generate-jpa-entity` | Persistent aggregate + DTOs + mapper |
| `generate-rest-endpoint` | Spring Boot 4 REST controller |
| `generate-spring-ai-feature` | Spring AI chat / RAG / tool-call |
| `generate-react-screen` | React 19.3 + MUI 9 screen component |
| `generate-react-hook` | Custom React 19 hook |
| `generate-react-test` | Focused Vitest + React Testing Library coverage |
| `generate-typescript-types` | TS types from backend OpenAPI |
| `generate-junit-test` | JUnit 5 unit tests |
| `generate-integration-test` | Testcontainers integration tests |
| `audit-pom-dependencies` | Maven CVE audit (blocking) |
| `audit-npm-dependencies` | npm CVE audit (blocking) |
| `scan-source-vulnerabilities` | OWASP source-code scan |
| `generate-flyway-migration` | PostgreSQL Flyway migration |
| `validate-java25-idioms` | Java 27 / SB 4 idiom check (legacy identifier) |
| `validate-react19-idioms` | React 19.3 / Compiler idiom check |
| `enforce-file-size-limit` | Cohesion review above 300 lines |
| `enforce-documentation` | Javadoc / TSDoc coverage check |
| `progressive-build-verify` | Compile + lint + test after each increment |
| `manage-task-todo` | Persist and resume todo list |

## Anti-patterns to avoid

- Skill that "knows everything" — split it.
- Agent containing technical instructions — move them into a skill.
- Code example in a SKILL.md — replace by a `templates/` link or remove.
- Skipping the todo update step — the workflow becomes non-resumable.
