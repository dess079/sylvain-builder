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
   Optional: `context: fork` only for an independent audit whose result should
   not pollute the caller's reasoning.
3. Body sections (mandatory in this project):
   - **When to use** — concrete trigger.
   - **What it does** — contract, inputs, outputs.
   - **Required rules** — invariants the AI must respect.
   - **Validation** — how success is measured.
   - **Failure modes** — when to stop.
4. Describe the desired outcome, invariants, validation and failure modes. Do not add a boilerplate implementation template; use a short snippet only when it clarifies a non-obvious local contract.
5. Reference the skill from an agent only if it is a recurring, useful workflow; skills do not need to be forced into every task.

## Add a new agent

1. Create `.github/agents/<agent-name>.agent.md`.
2. Frontmatter must include `name` and `description`; add handoffs only where an independent specialist is genuinely useful. Do not constrain `tools` merely as a proxy for safety.
3. Keep the body task-focused. Load shared or specialist context on demand, not at every startup; remove a rule rather than duplicating it in an agent.
4. State the agent's perspective, evidence expected and remediation boundary. A direct, scoped change is allowed when it is clearer than a handoff.
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
5. Choose the narrowest `applyTo` glob that covers the rule; do not use an
   instruction file as a general knowledge dump.

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
| `reuse-shared-components` | Public shared UI reuse and promotion review |
| `frontend-design` | Product-specific visual direction for a new/refactored UI |
| `ui-ux-pro-max` | Local UX research for a major visual decision or review |
| `generate-junit-test` | JUnit 6 unit tests |
| `generate-integration-test` | Testcontainers integration tests |
| `audit-pom-dependencies` | Maven CVE audit (blocking) |
| `audit-npm-dependencies` | npm CVE audit (blocking) |
| `scan-source-vulnerabilities` | OWASP source-code scan |
| `run-security-gate` | Worktree-bound deterministic security gate |
| `generate-flyway-migration` | PostgreSQL Flyway migration |
| `validate-java-idioms` | Java idiom check; version comes from the matrix |
| `validate-springai-prompt` | Spring AI prompt-template contract review |
| `validate-react19-idioms` | React 19.3 / Compiler idiom check |
| `enforce-file-size-limit` | Cohesion review above 300 lines |
| `enforce-documentation` | Javadoc / TSDoc coverage check |
| `progressive-build-verify` | Compile + lint + test after each increment |
| `manage-task-todo` | Persist and resume todo list |
| `provision-cloudflare-tunnel` | Explicit Cloudflare tunnel provisioning |
| `stop-process-by-port` | Confirmed local process stop by port |

## Anti-patterns to avoid

- Skill that "knows everything" — split it.
- Agent containing technical instructions — move them into a skill.
- Boilerplate template in a SKILL.md — replace it with outcome, invariant and validation guidance.
- Skipping the todo update step — the workflow becomes non-resumable.
