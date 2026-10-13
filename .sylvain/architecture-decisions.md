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

## 2026-10-11 — Stable October 2026 baseline and portable runtimes

- Context: the kit still mixed Spring AI M6 with 2.0.1 references, used older Java/React tooling, prohibited frontend tests, and relied on VS Code/Claude-only configuration.
- Decision: lock the scaffold baseline to Java 27, Spring Boot 4.1.1, Spring AI 2.0.1, React 19.3, MUI 9.4, Vite 8.3, TypeScript 7 and Node 26. Add `AGENTS.md`, a Claude bridge and OpenCode agents; retain GitHub Copilot customizations. Replace the arbitrary 100-line rule with a cohesion review and require focused frontend tests.
- Consequences: all supported runtimes follow the same baseline and executable validation path; Claude hooks remain optional, and existing projects need an intentional migration rather than a silent bump.
- Owner: `sylvain`.

## 2026-10-13 — Deterministic security gate and shared-components-first UI

- Context: an audit found that the old security hook read an unavailable environment variable, scans were prose-only, OpenCode did not discover the shared skills, broad hooks injected append-only todo history, and UI reuse from `shared-components` was not mandatory.
- Decision: add `scripts/security-scan.sh`, a stdin-aware commit guard tied to the exact Git worktree, Gitleaks/Semgrep/Trivy/CodeQL CI, a Maven `verify` binding for Dependency-Check and SpotBugs/FindSecBugs, and hook-contract validation. Configure OpenCode to discover `.github/skills`. Scope global/reference/security instructions and inject only active todo summaries. Add `reuse-shared-components` and record the public `MenuBar`, theme, preferences, AI prompt and AI response components in `.sylvain/shared-components.json`.
- Consequences: no local bypass exists for the commit security gate; a scanner missing from a required scan fails closed. CI is the authority across runtimes. Applications must reuse public shared UI controls and promote backend-agnostic UI used by two apps to the shared library.
- Owner: `sylvain`, `security-guardian`, `frontend-builder`.

## 2026-10-13 — Adaptive agents, no boilerplate templates

- Context: capable current models can generate project-specific manifests and implementation without copying stale templates. The kit also forced every task through a fixed agent/skill graph, injected shared context into every agent, and used tool allowlists that did not form a real safety boundary because `terminal` remained available.
- Decision: remove the code and manifest templates. Make the compatibility matrix plus scoped POM/package/frontend instructions the durable contract. Agents and skills become on-demand guidance: direct scoped work is allowed, handoffs are used for independent expertise or review, and only relevant context is loaded. Remove artificial agent tool allowlists; enforce safety through repository scope, deterministic gates and CI instead.
- Consequences: generated projects retain exact baseline, test and security requirements without a copied skeleton. The kit is smaller, less stale and less context-heavy; validation now checks the version contract and absence of boilerplate templates.
- Owner: `sylvain`.

## 2026-10-13 — CI supply-chain hardening and lean agent context

- Context: CI action tags can move, write permissions were broader than the jobs that needed them, dependency additions lacked a dedicated PR gate, Trivy ignored non-container infrastructure, and two old shared-agent documents were no longer loaded.
- Decision: pin every GitHub Action to its reviewed commit SHA, grant `security-events: write` only to CodeQL, add a high-severity dependency-review workflow, include Terraform/Compose/Helm signals in Trivy activation, and make the kit validator reject action tags. Remove the two unreferenced shared documents.
- Consequences: CI is more reproducible and has a smaller credential blast radius; supply-chain and IaC checks happen earlier. Action updates remain manageable through Dependabot. Agent context has no dead shared files.
- Owner: `security-guardian`, `sylvain`.

## 2026-10-13 — On-demand, shared-components-first UI design intelligence

- Context: generic AI-generated web interfaces risked a repetitive visual style,
  while the kit must retain MUI and a reusable public `shared-components`
  library rather than growing competing local UI systems.
- Decision: vendor Anthropic's `frontend-design` skill (Apache-2.0) and Next
  Level Builder's `ui-ux-pro-max` skill (MIT) at immutable Git revisions. Add a
  small local overlay that takes precedence: load them only for visual work,
  keep the product brief in control, reuse shared UI, implement through MUI,
  and preserve accessibility. Adapt UI UX Pro Max's commands to repository
  paths and record licence/provenance next to each skill.
- Consequences: agents gain a distinct visual-design process and local
  searchable UX evidence without adding runtime UI dependencies or injecting a
  multi-megabyte dataset into every task. Upstream refreshes are explicit,
  reviewable updates.
- Owner: `frontend-builder`, `sylvain`.

## 2026-10-13 — Explicit context budget

- Context: the kit still loaded duplicate Copilot guidance, broad security
  prose, two large UI manuals and post-tool hooks that re-scanned the worktree
  after every command. This added tokens and noisy output without stronger
  enforcement.
- Decision: retain only concise automatic source rules, scope frontend rules to
  JSX/TSX, and reduce UI skills to an on-demand protocol that opens data and
  references only when queried. Remove the post-tool size/documentation hooks;
  keep the commit security gate and an empty-when-idle todo hook. Add machine
  checks for hook scope and context-size ceilings.
- Consequences: security, testing, validation and shared-components contracts
  remain enforced, while idle sessions and unrelated tasks receive no todo
  history, heavyweight UI guidance or repetitive hook output.
- Owner: `sylvain`.

## 2026-10-13 — Audit remediation: executable contracts over stale labels

- Context: a review found a Java-25 skill identity on the Java-27 path, a
  fail-open Semgrep source discovery, a JUnit-5 label against a JUnit-6 lock,
  unpinned local scanner behaviour and small portability/documentation residue.
- Decision: rename the Java validator and report path to Java 27, align test
  guidance to JUnit 6 and Flyway, make source discovery and Semgrep version
  enforcement fail closed from the matrix, pin CI pnpm from that matrix, and
  require frozen lockfiles in scaffolds. Remove Finder metadata, empty skills
  and external-repository assumptions from Cloudflare guidance.
- Consequences: generated apps inherit reproducible tool versions and a real
  local SAST failure mode. Validation rejects the old fail-open scan pattern,
  Finder metadata and empty skill directories.
- Owner: `security-guardian`, `sylvain`.

## 2026-10-13 — Version-neutral Java validation identity

- Context: correcting a stale `java25` validator by renaming it `java27` would
  create the same maintenance task at the next Java baseline upgrade.
- Decision: name the skill and its report `validate-java-idioms` and
  `java-idioms-*`; read the concrete Java version solely from the compatibility
  matrix. Validation rejects a versioned Java-validator directory.
- Consequences: Java 28+ upgrades change the matrix and applicable idiom rules,
  not the workflow identity or every cross-reference.
- Owner: `backend-builder`.

## 2026-10-13 — macOS-only session hook runtime

- Context: the kit's session hook invokes Bash and the repository is maintained
  on macOS. The JSON carried unsupported platform override keys and an unused
  PowerShell helper, giving the appearance of tested Windows support.
- Decision: keep the single Bash session-hook command, remove the unsupported
  overrides and delete the orphan PowerShell script.
- Consequences: the configured runtime is explicit and smaller. A future native
  Windows integration must add a tested hook adapter rather than relying on a
  dormant script.
- Owner: `sylvain`.
