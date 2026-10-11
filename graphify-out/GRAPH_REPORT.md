# Graph Report - sylvain-builder  (2026-09-04)

## Corpus Check
- 64 files · ~16,790 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 390 nodes · 364 edges · 55 communities (48 shown, 7 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `b2ddc4ad`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- How to extend sylvain-builder
- devDependencies
- package.template.json
- Architecture Decision Log
- Global rules
- modify-existing-app
- suggest-latest-stack
- Frontend rules — React 19.2.6 / Compiler 1.0 / TS 6 / Vite 8
- Plan — sylvain-builder (May 2026)
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
- Shared orchestration rules (loaded by every agent)
- Backend rules — Java 25 / Spring boot 4.0.7 / Spring AI 2.0.0-M6
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

## God Nodes (most connected - your core abstractions)
1. `Architecture Decision Log` - 13 edges
2. `Global rules` - 10 edges
3. `modify-existing-app` - 10 edges
4. `suggest-latest-stack` - 9 edges
5. `How to extend sylvain-builder` - 9 edges
6. `Frontend rules — React 19.2.6 / Compiler 1.0 / TS 6 / Vite 8` - 8 edges
7. `Plan — sylvain-builder (May 2026)` - 8 edges
8. `scripts` - 6 edges
9. `backend-builder` - 6 edges
10. `prompt-caveman` - 6 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (55 total, 7 thin omitted)

### Community 0 - "How to extend sylvain-builder"
Cohesion: 0.07
Nodes (25): Architecture, Data flow, Hard rules (cross-cutting), Hook runtime compatibility, Pillars, 2026-05-05 — Initial creation, 2026-05-05 — No frontend tests, 2026-05-05 — Stack lock (+17 more)

### Community 1 - "devDependencies"
Cohesion: 0.11
Nodes (19): babel-plugin-react-compiler, eslint, @eslint/js, eslint-plugin-react-hooks, devDependencies, babel-plugin-react-compiler, eslint, @eslint/js (+11 more)

### Community 2 - "package.template.json"
Cohesion: 0.11
Nodes (18): react, react-dom, dependencies, react, react-dom, engines, node, name (+10 more)

### Community 3 - "Architecture Decision Log"
Cohesion: 0.14
Nodes (13): 2026-05-05 — Initial scaffolding decisions, 2026-05-05 — React Compiler + Vite 8 rollout for workspace UIs, 2026-05-08 — modify-existing-app skill, 2026-05-08 — Security baseline tightened (OWASP 2025 + LLM Top 10 2025), 2026-05-08 — Spring AI 2.0.0-M6 (milestone) adopté, 2026-05-08 — Stack refresh against verified May 2026 latest, 2026-05-08 — Web-references catalogue + suggest-latest-stack skill, 2026-09-04 — architect handoffs completed + database agent onboarded (+5 more)

### Community 4 - "Global rules"
Cohesion: 0.18
Nodes (10): Agent ↔ skill discipline, Code style — VERTICAL BREATHING ROOM, Documentation — MANDATORY, File size — HARD CAP, Git, Global rules, Language, Security (+2 more)

### Community 5 - "modify-existing-app"
Cohesion: 0.18
Nodes (10): Done criteria, Execution contract, Failure handling, Inputs, Invariants, modify-existing-app, Planning contract, Pre-checks (read-only) (+2 more)

### Community 6 - "suggest-latest-stack"
Cohesion: 0.20
Nodes (9): Companion skills, Inputs, Invariants, Output contract, Purpose, Sources to consult (in order), suggest-latest-stack, Validation steps (+1 more)

### Community 7 - "Frontend rules — React 19.2.6 / Compiler 1.0 / TS 6 / Vite 8"
Cohesion: 0.22
Nodes (8): Documentation, Folder layout — feature-based (mandatory), Frontend rules — React 19.2.6 / Compiler 1.0 / TS 6 / Vite 8, NO TESTS, Performance, React 19 idioms (mandatory), TypeScript, vite.config.ts contract

### Community 8 - "Plan — sylvain-builder (May 2026)"
Cohesion: 0.25
Nodes (8): 1. Best practices retained (web-scanned), 2. Non-negotiable principles, 3. Agents (6, pure orchestration), 4. Skills (19), 5. Prompts · Hooks · Instructions, 6. Typical flow, 7. Beyond the basics, Plan — sylvain-builder (May 2026)

### Community 9 - "backend-builder"
Cohesion: 0.29
Nodes (6): backend-builder, Exit criteria, Guidelines, Responsibilities, Skills you call (in typical order), You do NOT

### Community 10 - "security-guardian"
Cohesion: 0.29
Nodes (6): Blocking rules, Exit criteria, Responsibilities, security-guardian, Skills you call, You do NOT

### Community 11 - "Security baseline (May 2026)"
Cohesion: 0.29
Nodes (6): Forbidden patterns (auto-flagged), Frontend specifics (React 19.2), Mandatory tooling, OWASP LLM Top 10 (2025) — Spring AI features, OWASP Top 10 (2025) — backend & frontend, Security baseline (May 2026)

### Community 12 - "Web references — single source of truth"
Cohesion: 0.29
Nodes (6): Backend — Java 25 / Spring Boot 4 / Spring AI, Frontend — React 19.2 / Vite 8 / TypeScript 6, Rules for the AI, Security, VS Code Copilot customization, Web references — single source of truth

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
Cohesion: 0.29
Nodes (6): Blocking rules, Failure modes, Output, scan-source-vulnerabilities, What to look for, When to use

### Community 31 - "validate-java25-idioms"
Cohesion: 0.29
Nodes (6): Anti-patterns to flag, Blocking rules, Output, Spring AI specifics, validate-java25-idioms, When to use

### Community 32 - "validate-react19-idioms"
Cohesion: 0.29
Nodes (6): Anti-patterns to flag, Blocking rules, Output, Test-presence anti-pattern, validate-react19-idioms, When to use

### Community 33 - "validate-springai-prompt"
Cohesion: 0.29
Nodes (6): Blocking rules, Failure modes, Output, validate-springai-prompt, What me check, When to use

### Community 34 - "architect"
Cohesion: 0.33
Nodes (5): architect, Exit criteria, Responsibilities, Skills you call, You do NOT

### Community 35 - "cloudflare-tunnel"
Cohesion: 0.33
Nodes (5): cloudflare-tunnel, Exit criteria, Responsibilities, Skills you call, You do NOT

### Community 36 - "database"
Cohesion: 0.33
Nodes (5): Capabilities, database, Delegates to Agents, Exit criteria, Role

### Community 37 - "frontend-builder"
Cohesion: 0.33
Nodes (5): Exit criteria, frontend-builder, Responsibilities, Skills you call (in typical order), You do NOT (hard refusals)

### Community 38 - "prompt-caveman"
Cohesion: 0.33
Nodes (6): Me call skill, Me do NOT, Me job, Me rules (Spring AI 2.0.0), Me stop when, prompt-caveman

### Community 39 - "quality-gate"
Cohesion: 0.33
Nodes (6): Blocking rules, Exit criteria, quality-gate, Responsibilities, Skills you call, You do NOT

### Community 40 - "Shared orchestration rules (loaded by every agent)"
Cohesion: 0.33
Nodes (6): After every skill invocation, Closure, Delegation rules, Mandatory startup sequence, Shared orchestration rules (loaded by every agent), Your role as an agent

### Community 41 - "Backend rules — Java 25 / Spring boot 4.0.7 / Spring AI 2.0.0-M6"
Cohesion: 0.33
Nodes (5): Backend rules — Java 25 / Spring boot 4.0.7 / Spring AI 2.0.0-M6, Java 25 idioms (mandatory), Spring AI 2.0.0-M6, Spring boot 4.0.7 conventions, Tests

### Community 42 - "validate-kit.sh"
Cohesion: 0.73
Nodes (5): err(), note(), scan_versions(), validate-kit.sh script, wn()

### Community 44 - "sylvain.agent.md"
Cohesion: 0.40
Nodes (4): Refusals, Routing cheat sheet, sylvain — full-stack orchestrator, Your job

### Community 45 - "Copilot — sylvain-builder"
Cohesion: 0.40
Nodes (4): Copilot — sylvain-builder, Low-token mode, Quick refs, Work rules

## Knowledge Gaps
- **268 isolated node(s):** `name`, `private`, `version`, `type`, `packageManager` (+263 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Plan — sylvain-builder (May 2026)` connect `Plan — sylvain-builder (May 2026)` to `How to extend sylvain-builder`?**
  _High betweenness centrality (0.009) - this node is a cross-community bridge._
- **What connects `name`, `private`, `version` to the rest of the system?**
  _268 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `How to extend sylvain-builder` be split into smaller, more focused modules?**
  _Cohesion score 0.07126436781609195 - nodes in this community are weakly interconnected._
- **Should `devDependencies` be split into smaller, more focused modules?**
  _Cohesion score 0.10526315789473684 - nodes in this community are weakly interconnected._
- **Should `package.template.json` be split into smaller, more focused modules?**
  _Cohesion score 0.10526315789473684 - nodes in this community are weakly interconnected._
- **Should `Architecture Decision Log` be split into smaller, more focused modules?**
  _Cohesion score 0.14285714285714285 - nodes in this community are weakly interconnected._