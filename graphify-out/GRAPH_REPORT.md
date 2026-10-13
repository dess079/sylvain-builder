# Graph Report - sylvain-builder  (2026-10-13)

## Corpus Check
- 84 files · ~21,882 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 416 nodes · 354 edges · 74 communities (62 shown, 12 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `90bb15a8`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Decision log
- How to extend sylvain-builder
- sylvain-builder
- Architecture Decision Log
- Global rules
- modify-existing-app
- suggest-latest-stack
- Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9
- Plan — sylvain-builder (October 2026)
- backend-builder
- security-guardian
- Security baseline (May 2026)
- Web references — single source of truth
- audit-npm-dependencies
- audit-pom-dependencies
- enforce-documentation
- enforce-file-size-limit
- generate-integration-test
- generate-jpa-entity
- generate-junit-test
- generate-react-hook
- generate-react-screen
- generate-rest-endpoint
- generate-spring-ai-feature
- generate-spring-boot-module
- generate-typescript-types
- manage-task-todo
- progressive-build-verify
- provision-cloudflare-tunnel
- scaffold-fullstack-app
- scan-source-vulnerabilities
- validate-java25-idioms
- validate-react19-idioms
- validate-springai-prompt
- architect
- cloudflare-tunnel
- database
- frontend-builder
- prompt-caveman
- quality-gate
- Optional orchestration guidance
- Backend rules — Java 27 / Spring Boot 4.1.1 / Spring AI 2.0.1
- validate-kit.sh
- no-code-examples.md
- sylvain.agent.md
- Copilot — sylvain-builder
- package-json.instructions.md
- pom.instructions.md
- new-feature.prompt.md
- resume-task.prompt.md
- security-scan.prompt.md
- upgrade-deps.prompt.md
- generate-flyway-migration
- generate-react-test
- security-scan.sh
- reuse-shared-components
- stop-process-by-port
- guard-git-commit-hook.sh
- validate-hook-contracts.sh
- CLAUDE.md
- run-security-gate/SKILL.md
- load-active-todo-hook.sh script

## God Nodes (most connected - your core abstractions)
1. `Architecture Decision Log` - 16 edges
2. `Global rules` - 10 edges
3. `modify-existing-app` - 10 edges
4. `Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9` - 9 edges
5. `suggest-latest-stack` - 9 edges
6. `How to extend sylvain-builder` - 9 edges
7. `sylvain-builder` - 8 edges
8. `Decision log` - 8 edges
9. `Plan — sylvain-builder (October 2026)` - 8 edges
10. `scan-source-vulnerabilities` - 7 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (74 total, 12 thin omitted)

### Community 0 - "Decision log"
Cohesion: 0.08
Nodes (22): Architecture, Data flow, Hard rules (cross-cutting), Hook runtime compatibility, Pillars, Portable runtime model, 2026-05-05 — Initial creation, 2026-05-05 — No frontend tests (+14 more)

### Community 1 - "How to extend sylvain-builder"
Cohesion: 0.22
Nodes (9): Add a new agent, Add a new hook, Add a new instruction, Add a new prompt, Add a new skill, Anti-patterns to avoid, Current skills index, How to extend sylvain-builder (+1 more)

### Community 2 - "sylvain-builder"
Cohesion: 0.29
Nodes (6): Delivery rules, Runtime-specific integrations, Shared UI components, Stack baseline, Start here, sylvain-builder

### Community 3 - "Architecture Decision Log"
Cohesion: 0.12
Nodes (16): 2026-05-05 — Initial scaffolding decisions, 2026-05-05 — React Compiler + Vite 8 rollout for workspace UIs, 2026-05-08 — modify-existing-app skill, 2026-05-08 — Security baseline tightened (OWASP 2025 + LLM Top 10 2025), 2026-05-08 — Spring AI 2.0.0-M6 (milestone) adopté, 2026-05-08 — Stack refresh against verified May 2026 latest, 2026-05-08 — Web-references catalogue + suggest-latest-stack skill, 2026-09-04 — architect handoffs completed + database agent onboarded (+8 more)

### Community 4 - "Global rules"
Cohesion: 0.18
Nodes (10): Agent and skill guidance, Code style — VERTICAL BREATHING ROOM, Documentation — MANDATORY, File size — review threshold, Git, Global rules, Language, Security (+2 more)

### Community 5 - "modify-existing-app"
Cohesion: 0.18
Nodes (10): Done criteria, Execution contract, Failure handling, Inputs, Invariants, modify-existing-app, Planning contract, Pre-checks (read-only) (+2 more)

### Community 6 - "suggest-latest-stack"
Cohesion: 0.20
Nodes (9): Companion skills, Inputs, Invariants, Output contract, Purpose, Sources to consult (in order), suggest-latest-stack, Validation steps (+1 more)

### Community 7 - "Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9"
Cohesion: 0.20
Nodes (9): Documentation, Folder layout — feature-based (mandatory), Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9, Performance, React 19 idioms (mandatory), Shared UI library (mandatory), Tests, TypeScript (+1 more)

### Community 8 - "Plan — sylvain-builder (October 2026)"
Cohesion: 0.25
Nodes (8): 1. Best practices retained (web-scanned), 2. Non-negotiable principles, 3. Agents (9, adaptive collaboration), 4. Skills (28), 5. Prompts · Hooks · Instructions, 6. Typical flow, 7. Beyond the basics, Plan — sylvain-builder (October 2026)

### Community 9 - "backend-builder"
Cohesion: 0.29
Nodes (6): backend-builder, Exit criteria, Guidelines, Responsibilities, Skills you call (in typical order), You do NOT

### Community 10 - "security-guardian"
Cohesion: 0.29
Nodes (6): Blocking rules, Exit criteria, Remediation boundary, Responsibilities, security-guardian, Skills you call

### Community 11 - "Security baseline (May 2026)"
Cohesion: 0.29
Nodes (6): Forbidden patterns (auto-flagged), Frontend specifics (React 19.3), Mandatory tooling, OWASP LLM Top 10 (2025) — Spring AI features, OWASP Top 10 (2025) — backend & frontend, Security baseline (May 2026)

### Community 12 - "Web references — single source of truth"
Cohesion: 0.29
Nodes (6): Backend — Java 27 / Spring Boot 4 / Spring AI, Frontend — React 19.3 / Vite 8 / TypeScript 7 / MUI 9, Rules for the AI, Security, VS Code Copilot customization, Web references — single source of truth

### Community 13 - "audit-npm-dependencies"
Cohesion: 0.29
Nodes (6): audit-npm-dependencies, Blocking rules, Failure modes, Output, Required scans, When to use

### Community 14 - "audit-pom-dependencies"
Cohesion: 0.29
Nodes (6): audit-pom-dependencies, Blocking rules, Failure modes, Output, Required scans, When to use

### Community 15 - "enforce-documentation"
Cohesion: 0.29
Nodes (6): Blocking rules, enforce-documentation, Non-goals, Output, What it checks, When to use

### Community 16 - "enforce-file-size-limit"
Cohesion: 0.29
Nodes (6): Blocking rules, enforce-file-size-limit, Failure modes, Output, What it does, When to use

### Community 17 - "generate-integration-test"
Cohesion: 0.29
Nodes (6): Failure modes, generate-integration-test, Required behaviour, Required rules, Validation, When to use

### Community 18 - "generate-jpa-entity"
Cohesion: 0.29
Nodes (6): Failure modes, generate-jpa-entity, Required artefacts, Required rules, Validation, When to use

### Community 19 - "generate-junit-test"
Cohesion: 0.29
Nodes (6): Failure modes, generate-junit-test, Required coverage, Required rules, Validation, When to use

### Community 20 - "generate-react-hook"
Cohesion: 0.29
Nodes (6): Failure modes, generate-react-hook, Required behaviour, Required rules, Validation, When to use

### Community 21 - "generate-react-screen"
Cohesion: 0.29
Nodes (6): Failure modes, generate-react-screen, Required design, Required rules, Validation, When to use

### Community 22 - "generate-rest-endpoint"
Cohesion: 0.29
Nodes (6): Failure modes, generate-rest-endpoint, Required behaviour, Required rules, Validation, When to use

### Community 23 - "generate-spring-ai-feature"
Cohesion: 0.29
Nodes (6): Failure modes, generate-spring-ai-feature, Required design choices, Required rules, Validation, When to use

### Community 24 - "generate-spring-boot-module"
Cohesion: 0.29
Nodes (6): Failure modes, generate-spring-boot-module, Required artefacts, Required rules, Validation, When to use

### Community 25 - "generate-typescript-types"
Cohesion: 0.29
Nodes (6): Failure modes, generate-typescript-types, Required behaviour, Required rules, Validation, When to use

### Community 26 - "manage-task-todo"
Cohesion: 0.29
Nodes (6): Failure modes, File contract, manage-task-todo, Required rules, Validation, When to use

### Community 27 - "progressive-build-verify"
Cohesion: 0.29
Nodes (6): Blocking rules, Failure modes, Output, progressive-build-verify, Steps, When to use

### Community 28 - "provision-cloudflare-tunnel"
Cohesion: 0.29
Nodes (6): Execution contract, Failure handling, Invariants, Mandatory clarifying questions (ask before any action), provision-cloudflare-tunnel, Purpose

### Community 29 - "scaffold-fullstack-app"
Cohesion: 0.29
Nodes (6): Failure modes, Output layout, Required steps, scaffold-fullstack-app, Validation, When to use

### Community 30 - "scan-source-vulnerabilities"
Cohesion: 0.25
Nodes (7): Blocking rules, Deterministic gate, Failure modes, Output, scan-source-vulnerabilities, What to look for, When to use

### Community 31 - "validate-java25-idioms"
Cohesion: 0.29
Nodes (6): Anti-patterns to flag, Blocking rules, Output, Spring AI specifics, validate-java25-idioms, When to use

### Community 32 - "validate-react19-idioms"
Cohesion: 0.29
Nodes (6): Anti-patterns to flag, Blocking rules, Output, Test-quality anti-patterns, validate-react19-idioms, When to use

### Community 33 - "validate-springai-prompt"
Cohesion: 0.29
Nodes (6): Blocking rules, Failure modes, Output, validate-springai-prompt, What me check, When to use

### Community 34 - "architect"
Cohesion: 0.33
Nodes (5): architect, Collaboration, Exit criteria, Responsibilities, Skills you call

### Community 35 - "cloudflare-tunnel"
Cohesion: 0.33
Nodes (5): cloudflare-tunnel, Exit criteria, Responsibilities, Skills you call, You do NOT

### Community 36 - "database"
Cohesion: 0.33
Nodes (5): database, Delegates to Agents, Exit criteria, Role, Skills you call

### Community 37 - "frontend-builder"
Cohesion: 0.33
Nodes (5): Exit criteria, frontend-builder, Responsibilities, Skills you call (in typical order), You do NOT

### Community 38 - "prompt-caveman"
Cohesion: 0.29
Nodes (6): Me call skill, Me do NOT, Me job, Me rules (Spring AI 2.0.1), Me stop when, prompt-caveman

### Community 39 - "quality-gate"
Cohesion: 0.29
Nodes (6): Blocking rules, Exit criteria, quality-gate, Remediation boundary, Responsibilities, Skills you call

### Community 40 - "Optional orchestration guidance"
Cohesion: 0.29
Nodes (6): After every skill invocation, Closure, Delegation rules, Mandatory startup sequence, Optional orchestration guidance, Your role as an agent

### Community 41 - "Backend rules — Java 27 / Spring Boot 4.1.1 / Spring AI 2.0.1"
Cohesion: 0.33
Nodes (5): Backend rules — Java 27 / Spring Boot 4.1.1 / Spring AI 2.0.1, Java 27 idioms (mandatory), Spring AI 2.0.1, Spring Boot 4.1.1 conventions, Tests

### Community 42 - "validate-kit.sh"
Cohesion: 0.70
Nodes (4): err(), note(), validate-kit.sh script, wn()

### Community 44 - "sylvain.agent.md"
Cohesion: 0.40
Nodes (4): Refusals, Routing cheat sheet, sylvain — full-stack orchestrator, Your job

### Community 45 - "Copilot — sylvain-builder"
Cohesion: 0.40
Nodes (4): Copilot — sylvain-builder, Low-token mode, Quick refs, Work rules

### Community 54 - "generate-flyway-migration"
Cohesion: 0.33
Nodes (5): Failure modes, generate-flyway-migration, Required rules, Validation, When to use

### Community 55 - "generate-react-test"
Cohesion: 0.33
Nodes (5): Failure modes, generate-react-test, Required rules, Validation, When to use

### Community 56 - "security-scan.sh"
Cohesion: 0.67
Nodes (4): record(), require_tool(), run_check(), security-scan.sh script

### Community 57 - "reuse-shared-components"
Cohesion: 0.50
Nodes (3): Mandatory composition, Promotion rule, reuse-shared-components

### Community 58 - "stop-process-by-port"
Cohesion: 0.50
Nodes (3): Safety rules, stop-process-by-port, Workflow

## Knowledge Gaps
- **279 isolated node(s):** `guard-git-commit-hook.sh script`, `load-active-todo-hook.sh script`, `validate-hook-contracts.sh script`, `Responsibilities`, `Skills you call` (+274 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **12 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `How to extend sylvain-builder` connect `How to extend sylvain-builder` to `Decision log`?**
  _High betweenness centrality (0.004) - this node is a cross-community bridge._
- **What connects `guard-git-commit-hook.sh script`, `load-active-todo-hook.sh script`, `validate-hook-contracts.sh script` to the rest of the system?**
  _279 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Decision log` be split into smaller, more focused modules?**
  _Cohesion score 0.07977207977207977 - nodes in this community are weakly interconnected._
- **Should `Architecture Decision Log` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._