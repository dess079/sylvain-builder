# Architecture Decision Log

Auto-appended ADRs (one short entry per architectural decision).

Format:

```
## YYYY-MM-DD — <decision title>
- Context:
- Decision:
- Consequences:
- Owner agent / skill:
```

---

## 2026-05-05 — Initial scaffolding decisions

- Context: bootstrapping the orchestration kit.
- Decision: Spring boot 4.1.0, Spring AI 2.0.0, Java 25, React 19.2, Vite 6 locked in `compatibility-matrix.json`.
- Consequences: any drift requires updating the matrix and bumping all skills' validation rules.
- Owner: `architect`.

## 2026-05-05 — React Compiler + Vite 8 rollout for workspace UIs

- Context: five UI apps use Vite without React Compiler activation, while `shared-components` is a locally linked Rollup-built library consumed by several apps.
- Decision: upgrade all UI apps to `react`/`react-dom` 19.2.5, move Vite apps to `vite` 8.0.10 and `@vitejs/plugin-react` 6.0.1, enable React Compiler in app builds, and keep `shared-components` on Rollup while adding compiler support there instead of changing bundlers in the same wave.
- Consequences: reduces migration blast radius, preserves the current local library workflow, and reserves any library bundler migration for a separate follow-up after functional validation.
- Owner: `architect`.

## 2026-05-08 — Stack refresh against verified May 2026 latest

- Context: web verification (spring.io, github releases, react.dev, vite.dev, typescriptlang.org, nodejs.org) revealed drift between matrix and reality.
- Decision: bump locked versions to Spring AI 1.1.6, React 19.2.6, Vite 8.0.11, TypeScript 6.0, eslint-plugin-react-hooks 7.1.1; add Spring Framework 7.0.7, Spring Security 7.0.5, Hibernate 7.2.x as managed; keep Spring boot 4.0.7 (still latest stable).
- Consequences: ESLint moves to v10; Vite 8 drops Node 18; TypeScript 6 enforces stricter ESM.
- Owner: `architect`.

## 2026-05-08 — Web-references catalogue + suggest-latest-stack skill

- Context: user requirement that the AI codes against current best practices and proposes verified versions before each project.
- Decision: introduce always-on `web-references.instructions.md` (canonical official URLs) + new skill `suggest-latest-stack` (read-only, `context: fork`). Invoked by `architect` before scaffolding and by `/upgrade-deps`.
- Consequences: every dependency proposal is now grounded on a fetchable URL; LLM training-data drift is mitigated.
- Owner: `architect` + `suggest-latest-stack`.

## 2026-05-08 — Security baseline tightened (OWASP 2025 + LLM Top 10 2025)

- Context: user requirement that security coverage be maximised, including AI-specific risks.
- Decision: introduce `security.instructions.md` (always-on) covering OWASP Top 10 2025 and OWASP LLM Top 10 2025; add maven-enforcer + JaCoCo + CycloneDX SBOM to POM template; convert `pre-commit-security` hook from advisory to **blocking** (`exit 2` + `permissionDecision: deny`) when no recent scan exists.
- Consequences: commits without a scan within 30 min are blocked unless `BYPASS_SECURITY=1` is set.
- Owner: `security-guardian`.

## 2026-05-08 — modify-existing-app skill

- Context: kit was scaffolding-centric; user requires safe modification of already-scaffolded apps.
- Decision: add `modify-existing-app` skill with explicit pre-checks (CVE, drift, size/doc), a routing matrix to specialised skills, and a no-test-on-frontend invariant. `sylvain` and `architect` route to it.
- Consequences: lifecycle now covers both creation and evolution while preserving locked stack and quality bars.
- Owner: `architect` + `sylvain`.

## 2026-05-08 — Spring AI 2.0.0-M6 (milestone) adopté

- Context: l'utilisateur veut coder avec les dernières APIs Spring AI, vérifiées sur github.com/spring-projects/spring-ai/releases (tag v2.0.0-M6, latest pre-release, publié il y a 1 h).
- Decision: verrouiller `spring-ai-bom` à `2.0.0-M6`. Ajouter le repo milestones Maven si absent.
- Consequences: **Breaking changes à respecter** — (1) `PromptChatMemoryAdvisor` supprimé → utiliser l'advisor alternatif avec `conversationId` explicite; (2) toutes les classes `*Options` sont builder-only (plus de setters); (3) Jackson 3 (`tools.jackson`) remplace Jackson 2 (géré par Spring Boot 4); (4) `OpenAiConnectionProperties` renommé `OpenAiCommonProperties`; (5) `*Properties` ne s'étend plus de `AbstractOpenAiOptions`. APIs encore susceptibles de changer avant la GA.
- Owner: `architect` + `backend-builder`.

## 2026-09-04 — Hook runtime compatibility documented (Claude Code spec)

- Context: audit revealed hooks use the Claude Code hook spec (`PreToolUse`/`PostToolUse`/`hookSpecificOutput.permissionDecision`) while the primary target editor is VS Code Copilot, which does not execute them — mechanical gates would silently never fire.
- Decision: keep the Claude Code hook spec as-is, document the runtime split in `README.md` and `docs/ARCHITECTURE.md` ("Hook runtime compatibility"): mechanical on Claude-Code-compatible runtimes, procedural (via mandatory quality/security skills) on Copilot. Kit integrity is now machine-checked by `scripts/validate-kit.sh`.
- Consequences: quality/security skills are mandatory on every runtime, not optional; hooks become a bonus gate, never the only gate.
- Owner: `sylvain`.

## 2026-09-04 — Version drift sweep (matrix as authority)

- Context: audit found Spring Boot 4.0.6 vs 4.0.7 across README/matrix/ARCHITECTURE/DECISION-LOG, and stale Spring AI 1.1.5 / TS 5.7 references in `no-code-examples.md` (loaded by every agent) and `pom.instructions.md`.
- Decision: align all files on the locked stack: Spring Boot 4.0.7, Spring AI 2.0.0-M6, TypeScript 6.0, Vite 8.0.11. `scripts/validate-kit.sh` now fails on any stale version reference.
- Consequences: agents no longer load contradictory API knowledge; matrix is the single authority.
- Owner: `sylvain`.

## 2026-09-04 — pnpm as exclusive JS package manager

- Context: kit templates and skills generated npm-based frontends while the owner's global policy mandates pnpm.
- Decision: `package.template.json` gains `packageManager: "pnpm@11.22.0"` + `pnpm audit` script; all skills/agents switch to `pnpm install`/`pnpm run`/`pnpm audit`; `package-json.instructions.md` documents pnpm-only + committed lockfile.
- Consequences: scaffolded apps conform to house policy from day one.
- Owner: `sylvain`.

## 2026-09-04 — architect handoffs completed + database agent onboarded

- Context: `architect` could only hand off to `backend-builder`, forcing hub round-trips through `sylvain` for frontend work; `database.agent.md` violated the agent frontmatter contract (no `name`, no shared rules loaded).
- Decision: add `frontend-builder` and `security-guardian` handoffs to `architect`; fix `database` agent (name, handoffs, shared/orchestration.md + no-code-examples.md loaded, correct delegate names).
- Consequences: scaffold → backend → frontend chain is direct; agent graph integrity is checked by `scripts/validate-kit.sh` (sections 1, 2, 4).
- Owner: `sylvain`.

## 2026-09-04 — Spring AI M6 → GA migration plan (planned)

- Context: the stack is locked on Spring AI 2.0.0-M6 (milestone, pre-release; APIs may change before GA — see matrix notes).
- Decision: plan the migration now: on GA release, run `suggest-latest-stack`, then bump `spring-ai-bom` in `templates/pom.template.xml` + `compatibility-matrix.json` + `pom.instructions.md` in one ADR-tracked commit; re-verify `generate-spring-ai-feature` and `prompt-caveman` rules against the GA changelog (builder-only options, conversationId, Jackson 3).
- Consequences: migration is pre-cadré; no scramble on GA day.
- Owner: `architect` + `backend-builder`.
