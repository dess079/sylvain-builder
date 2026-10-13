# Decision log

Append-only log of architectural / process decisions made on this orchestration kit itself
(separate from `.sylvain/architecture-decisions.md` which logs decisions about the apps it builds).

Format:

```
## YYYY-MM-DD — title
- Context:
- Decision:
- Consequences:
```

---

## 2026-05-05 — Initial creation

- Context: User requested an orchestrator + skills set to build full-stack apps with strict size, doc, security and idiom rules.
- Decision: 6 agents + 19 skills + 4 prompts + 5 instructions + 4 hooks. Strict separation: agents orchestrate, skills execute. No inline code examples. Templates live in `templates/`.
- Consequences: Every new capability must follow `docs/HOW-TO-EXTEND.md`. The compatibility matrix is the single version source of truth.

## 2026-05-05 — Stack lock

- Context: Multiple Spring Boot / Spring AI / Java / React versions exist in mid-2026.
- Decision: Lock to Spring boot 4.0.7, Spring AI 2.0.0-M6, Java 25 LTS, React 19.2.6, Vite 8, TS 6, Node 22 LTS.
- Consequences: Any drift requires a new ADR + matrix bump.

## 2026-05-05 — No frontend tests

- Context: Owner directive — backend coverage is mandatory; frontend tests are forbidden.
- Decision: `frontend.instructions.md` blocks creation of any test file. `audit-npm-dependencies` blocks installation of test frameworks. `validate-react19-idioms` raises a hard refusal.
- Consequences: Frontend regressions caught only at build/lint/manual QA. Acknowledged risk.

## 2026-09-04 — Kit hardening pass

- Context: external audit found (1) hook format not executed on Copilot, (2) version drift across docs vs matrix, (3) npm-based templates vs house pnpm policy, (4) incomplete `architect` handoffs, (5) no self-validation of the kit, (6) hooks blind to untracked files.
- Decision: document hook runtime compatibility (Claude Code spec, procedural fallback); align all versions on the matrix (Spring Boot 4.0.7 / Spring AI 2.0.0-M6 / TS 6.0); migrate templates and skills to pnpm; add `frontend-builder` + `security-guardian` handoffs to `architect`; add `scripts/validate-kit.sh` integrity check; rewrite size/doc hooks to include untracked files and handle spaces.
- Consequences: mechanical gates documented as runtime-dependent; procedural enforcement (skills) is now the guaranteed path; kit drift is machine-detectable.

## 2026-10-11 — Portable runtime support and validation-first quality

- Context: the kit needed to work consistently in Codex, OpenCode, Claude Code and GitHub Copilot, while active guidance still contained an unreleased Spring AI baseline and a frontend-test ban.
- Decision: add `AGENTS.md` as the shared instruction surface, `CLAUDE.md` as a Claude Code import bridge, and OpenCode agent profiles. Keep `.github/` as the Copilot integration. Refresh the stable stack and require focused frontend tests; use a 300-line cohesion review instead of an arbitrary split rule.
- Consequences: runtime-specific hooks are no longer a correctness dependency, and all runtimes follow the same portable validation workflow.

## 2026-10-13 — Deterministic gates and shared UI reuse

- Context: the security policy was strong but non-deterministic: the commit hook did not consume runtime hook input, tools were not actually executed by CI, and frontend reuse of `shared-components` was only implicit.
- Decision: add a worktree-bound security report and commit guard, CI secret/SAST/dependency/CodeQL gates, Maven SpotBugs/FindSecBugs execution, OpenCode skill discovery, narrow startup context, and a mandatory shared-components skill/policy.
- Consequences: a missing scanner or stale report blocks the commit; all generated toolbars use the existing theme and preferences controls, and AI screens use the existing prompt and response components.

## 2026-10-13 — Model-first implementation and adaptive collaboration

- Context: copied code templates, mandatory agent handoffs and nominal tool allowlists were adding stale context and ceremony without providing a reliable security boundary.
- Decision: remove boilerplate templates, make the compatibility matrix and scoped instructions authoritative, permit direct scoped work, and load specialist context only on demand. Tools are chosen by the agent for the task; deterministic security gates and CI remain the real controls.
- Consequences: the kit retains explicit version, testing, shared-component and security invariants while reducing prompt payload and unnecessary orchestration.

## 2026-10-13 — CI supply-chain hardening and orphan cleanup

- Context: mutable action tags, broad workflow permissions, missing dependency review and Dockerfile-only Trivy activation left avoidable gaps; two shared agent documents were no longer consumed.
- Decision: pin actions by SHA, scope CodeQL write permission, add dependency review, activate Trivy for Terraform/Compose/Helm and validate immutable action pins. Remove orphaned shared guidance files.
- Consequences: CI is more reproducible, least-privilege and useful for infrastructure changes without adding agent context.

## 2026-10-13 — On-demand UI design skills

- Context: the kit needed stronger visual direction without duplicating MUI or the public `shared-components` library.
- Decision: vendor `frontend-design` (Apache-2.0) and `ui-ux-pro-max` (MIT) at immutable revisions. Add local constraints for MUI, reusable components, accessibility and narrow context loading; make the latter's search commands portable from the repository root.
- Consequences: new and reworked interfaces can use deliberate visual direction and local UX research, while ordinary work does not carry the skills' context or a second component system.

## 2026-10-13 — Context-budget audit

- Context: some automatic guidance and post-tool hooks duplicated repository rules or produced worktree-wide checks after unrelated commands.
- Decision: compact automatic instructions and the two UI skills, narrow frontend file matching, remove redundant post-tool hooks, and leave the session todo hook empty unless a task is active. Validate explicit context-size and hook-scope limits.
- Consequences: only task-relevant skills, matching instructions and active todo state enter an agent's context; deterministic security and final quality gates remain.

## 2026-10-13 — Audit contract remediation

- Context: review found stale Java/JUnit labels, permissive Semgrep discovery and local-machine residue.
- Decision: align identifiers and docs to Java 27/JUnit 6/Flyway, fail closed on source discovery and scanner version drift, derive CI pnpm/Semgrep versions from the matrix, and remove portable-kit residue.
- Consequences: scanner and dependency installation behaviour now match their stated contracts and validation prevents the identified residue from returning.

## 2026-10-13 — Version-neutral Java validator

- Context: a Java-version suffix in a reusable skill would create needless
  rename churn at every baseline upgrade.
- Decision: use `validate-java-idioms`; the matrix supplies the Java version.
- Consequences: a Java upgrade changes the contract, not all skill references.
