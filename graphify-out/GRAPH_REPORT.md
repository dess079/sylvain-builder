# Graph Report - sylvain-builder  (2026-10-13)

## Corpus Check
- 119 files · ~168,840 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 865 nodes · 1214 edges · 104 communities (84 shown, 20 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 30 edges (avg confidence: 0.87)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `73cd1936`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Decision log
- How to extend sylvain-builder
- sylvain-builder
- Architecture Decision Log
- global.instructions.md
- modify-existing-app
- suggest-latest-stack
- Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9
- Plan — sylvain-builder (October 2026)
- backend-builder
- security-guardian
- security.instructions.md
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
- DesignSystemGenerator
- validate-react19-idioms
- validate-springai-prompt
- architect
- cloudflare-tunnel
- database
- frontend-builder
- prompt-caveman
- quality-gate
- validate_data.py
- Backend rules — Java 27 / Spring Boot 4.1.1 / Spring AI 2.0.1
- validate-kit.sh
- BM25
- sylvain — full-stack orchestrator
- copilot-instructions.md
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
- load-active-todo-hook.sh
- Path
- core.py
- search
- search_stack
- design_system.py
- Pre-Delivery Checklist (canonical — the only one)
- Quick Reference
- _style_is_dark_primary
- TestNativeDesktopStackFreshness
- TestLightResultOutputCoherence
- TestMetricMath
- test_text_layout_resilience.py
- _normalize
- _contrast_ratio
- _palette_is_dark
- sylvain-builder
- _row_identities
- .generate
- test_design_system_mode.py
- _select_palette_for_mode
- test_skill_script_paths.py
- Architecture
- TestStackFlagWithDesignSystem
- Frontend design
- UI/UX Pro Max
- validate-java-idioms
- search.py
- frontend-design/UPSTREAM.md
- ui-ux-pro-max/UPSTREAM.md

## God Nodes (most connected - your core abstractions)
1. `search()` - 43 edges
2. `DesignSystemGenerator` - 38 edges
3. `search_stack()` - 35 edges
4. `Architecture Decision Log` - 22 edges
5. `BM25` - 18 edges
6. `detect_domain()` - 18 edges
7. `CatalogRefreshTest` - 15 edges
8. `read_rows()` - 15 edges
9. `TestReasoningContract` - 15 edges
10. `Decision log` - 14 edges

## Surprising Connections (you probably didn't know these)
- `TestLightResultOutputCoherence` --uses--> `DesignSystemGenerator`  [INFERRED]
  .github/skills/ui-ux-pro-max/scripts/tests/test_design_system_mode.py → .github/skills/ui-ux-pro-max/scripts/design_system.py
- `TestBm25CoreBehavior` --uses--> `BM25`  [INFERRED]
  .github/skills/ui-ux-pro-max/scripts/tests/test_core.py → .github/skills/ui-ux-pro-max/scripts/core.py
- `TestTokenizer` --uses--> `BM25`  [INFERRED]
  .github/skills/ui-ux-pro-max/scripts/tests/test_core.py → .github/skills/ui-ux-pro-max/scripts/core.py
- `_generate_intelligent_overrides()` --calls--> `search()`  [EXTRACTED]
  .github/skills/ui-ux-pro-max/scripts/design_system.py → .github/skills/ui-ux-pro-max/scripts/core.py
- `TestReasoningMatch` --uses--> `DesignSystemGenerator`  [INFERRED]
  .github/skills/ui-ux-pro-max/scripts/tests/test_core.py → .github/skills/ui-ux-pro-max/scripts/design_system.py

## Import Cycles
- None detected.

## Communities (104 total, 20 thin omitted)

### Community 0 - "Decision log"
Cohesion: 0.14
Nodes (14): 2026-05-05 — Initial creation, 2026-05-05 — No frontend tests, 2026-05-05 — Stack lock, 2026-09-04 — Kit hardening pass, 2026-10-11 — Portable runtime support and validation-first quality, 2026-10-13 — Audit contract remediation, 2026-10-13 — CI supply-chain hardening and orphan cleanup, 2026-10-13 — Context-budget audit (+6 more)

### Community 1 - "How to extend sylvain-builder"
Cohesion: 0.22
Nodes (9): Add a new agent, Add a new hook, Add a new instruction, Add a new prompt, Add a new skill, Anti-patterns to avoid, Current skills index, How to extend sylvain-builder (+1 more)

### Community 2 - "sylvain-builder"
Cohesion: 0.25
Nodes (7): Delivery rules, Runtime-specific integrations, Shared UI components, Stack baseline, Start here, sylvain-builder, UI design guidance

### Community 3 - "Architecture Decision Log"
Cohesion: 0.09
Nodes (22): 2026-05-05 — Initial scaffolding decisions, 2026-05-05 — React Compiler + Vite 8 rollout for workspace UIs, 2026-05-08 — modify-existing-app skill, 2026-05-08 — Security baseline tightened (OWASP 2025 + LLM Top 10 2025), 2026-05-08 — Spring AI 2.0.0-M6 (milestone) adopté, 2026-05-08 — Stack refresh against verified May 2026 latest, 2026-05-08 — Web-references catalogue + suggest-latest-stack skill, 2026-09-04 — architect handoffs completed + database agent onboarded (+14 more)

### Community 5 - "modify-existing-app"
Cohesion: 0.18
Nodes (10): Done criteria, Execution contract, Failure handling, Inputs, Invariants, modify-existing-app, Planning contract, Pre-checks (read-only) (+2 more)

### Community 6 - "suggest-latest-stack"
Cohesion: 0.20
Nodes (9): Companion skills, Inputs, Invariants, Output contract, Purpose, Sources to consult (in order), suggest-latest-stack, Validation steps (+1 more)

### Community 7 - "Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9"
Cohesion: 0.18
Nodes (10): Documentation, Folder layout — feature-based (mandatory), Frontend rules — React 19.3 / Compiler 1.0 / TS 7 / Vite 8 / MUI 9, Performance, React 19 idioms (mandatory), Shared UI library (mandatory), Tests, TypeScript (+2 more)

### Community 8 - "Plan — sylvain-builder (October 2026)"
Cohesion: 0.25
Nodes (8): 1. Best practices retained (web-scanned), 2. Non-negotiable principles, 3. Agents (9, adaptive collaboration), 4. Skills (30), 5. Prompts · Hooks · Instructions, 6. Typical flow, 7. Beyond the basics, Plan — sylvain-builder (October 2026)

### Community 9 - "backend-builder"
Cohesion: 0.29
Nodes (6): backend-builder, Exit criteria, Guidelines, Responsibilities, Skills you call (in typical order), You do NOT

### Community 10 - "security-guardian"
Cohesion: 0.29
Nodes (6): Blocking rules, Exit criteria, Remediation boundary, Responsibilities, security-guardian, Skills you call

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
Cohesion: 0.40
Nodes (4): Before action, Boundaries, Execution, provision-cloudflare-tunnel

### Community 29 - "scaffold-fullstack-app"
Cohesion: 0.29
Nodes (6): Failure modes, Output layout, Required steps, scaffold-fullstack-app, Validation, When to use

### Community 30 - "scan-source-vulnerabilities"
Cohesion: 0.25
Nodes (7): Blocking rules, Deterministic gate, Failure modes, Output, scan-source-vulnerabilities, What to look for, When to use

### Community 31 - "DesignSystemGenerator"
Cohesion: 0.06
Nodes (22): DesignSystemGenerator, Generates design system recommendations from aggregated searches., Load reasoning rules from CSV., Find matching reasoning rule for a category., Apply reasoning rules to search results., Select best matching result based on priority keywords., apply_decision_rules(), _object_without_duplicates() (+14 more)

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

### Community 40 - "validate_data.py"
Cohesion: 0.08
Nodes (46): read_rows(), TestAccessibilityGuidance, TestChartsTypographyAndIcons, TestCurrentReactGuidance, TestSemanticColors, _catalog_date(), _check_app_interface_contract(), _check_catalog_contract() (+38 more)

### Community 41 - "Backend rules — Java 27 / Spring Boot 4.1.1 / Spring AI 2.0.1"
Cohesion: 0.33
Nodes (5): Backend rules — Java 27 / Spring Boot 4.1.1 / Spring AI 2.0.1, Java 27 idioms (mandatory), Spring AI 2.0.1, Spring Boot 4.1.1 conventions, Tests

### Community 42 - "validate-kit.sh"
Cohesion: 0.70
Nodes (4): err(), note(), validate-kit.sh script, wn()

### Community 43 - "BM25"
Cohesion: 0.07
Nodes (14): BM25, detect_domain(), BM25 ranking algorithm for text search, Lowercase, normalize synonyms, split, remove punctuation, filter stopwords, Build BM25 index from documents, Score all documents against query, All indexed terms, for suggestion/typo-recovery purposes., Auto-detect the most relevant domain from query. Matches are weighted by… (+6 more)

### Community 44 - "sylvain — full-stack orchestrator"
Cohesion: 0.50
Nodes (3): Refusals, sylvain — full-stack orchestrator, Your job

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

### Community 73 - "Path"
Cohesion: 0.14
Nodes (6): CatalogRefreshTest, CatalogSummaryLineEndingsTest, _load_generator(), Simulate a Windows checkout: the recorded hashes must still validate., TestThresholdGate, Path

### Community 74 - "core.py"
Cohesion: 0.11
Nodes (27): _contains_phrase(), _domain_keywords(), _file_signature(), _get_bm25(), _load_csv(), _load_csv_snapshot(), _load_product_keywords(), _load_rows_or_empty() (+19 more)

### Community 75 - "search"
Cohesion: 0.13
Nodes (5): Main search function with auto-domain detection, search(), TestSearchDomains, read_rows(), TestStyleTaxonomy

### Community 76 - "search_stack"
Cohesion: 0.13
Nodes (7): _exact_stack_identifier(), Resolve a standalone API identifier even when its BM25 IDF is low., Search stack-specific guidelines, search_stack(), TestDiagnosticsContracts, _rows(), TestWebStackFreshness

### Community 77 - "design_system.py"
Cohesion: 0.13
Nodes (20): ansi_ljust(), _detect_page_type(), format_ascii_box(), format_page_override_md(), _generate_intelligent_overrides(), hex_to_ansi(), persist_design_system(), Persist design system to design-system/<project>/ folder using Master +… (+12 more)

### Community 78 - "Pre-Delivery Checklist (canonical — the only one)"
Cohesion: 0.15
Nodes (12): Accessibility, Common Rules for Professional UI + Pre-Delivery Checklist, Icons & Visual Elements, Interaction, Interaction (App), Layout, Layout & Spacing, Light/Dark Mode (+4 more)

### Community 79 - "Quick Reference"
Cohesion: 0.15
Nodes (12): 10. Charts & Data (LOW), 1. Accessibility (CRITICAL), 2. Touch & Interaction (CRITICAL), 3. Performance (HIGH), 4. Style Selection (HIGH), 5. Layout & Responsive (HIGH), 6. Typography & Color (MEDIUM), 7. Animation (MEDIUM) (+4 more)

### Community 80 - "_style_is_dark_primary"
Cohesion: 0.21
Nodes (7): _query_wants_dark(), True when a styles.csv row describes itself as dark-first., True when the query explicitly asks for a dark theme., Resolve the mode the rest of the output has to agree with., _resolve_color_mode(), _style_is_dark_primary(), TestModeResolution

### Community 82 - "TestLightResultOutputCoherence"
Cohesion: 0.24
Nodes (6): format_markdown(), _mode_support_labels(), Light/dark support labels that agree with the product's anti-patterns. A light…, Format design system as markdown., A light result that avoids dark mode must not also call dark "supported"., TestLightResultOutputCoherence

### Community 84 - "test_text_layout_resilience.py"
Cohesion: 0.22
Nodes (3): read_rows(), TestTextLayoutDataContracts, TestTextLayoutRetrieval

### Community 85 - "_normalize"
Cohesion: 0.25
Nodes (9): _exact_match_diagnostic(), _legacy_successor_guidance(), _normalize(), Apply longest-first synonym substitution at token boundaries., Whether a stack query explicitly targets an older framework generation., Choose one coherent applicability generation for stack retrieval., Prefer the explicit successor row for a brand-new app on legacy-only stacks., _stack_query_requests_legacy() (+1 more)

### Community 86 - "_contrast_ratio"
Cohesion: 0.25
Nodes (8): _button_outline_text_color(), _contrast_ratio(), _derive_dark_palette(), format_master_md(), Format design system as MASTER.md with hierarchical override logic., WCAG contrast ratio for two hex colors, or None if either is invalid., Keep product brand tokens while deriving accessible dark surfaces., Primary for outline-button text when it is readable, else the foreground.

### Community 87 - "_palette_is_dark"
Cohesion: 0.31
Nodes (5): _palette_is_dark(), WCAG relative luminance of a #RRGGBB string, or None if unparseable., True when a colors.csv row's Background is a dark surface., _relative_luminance(), TestLuminance

### Community 88 - "sylvain-builder"
Cohesion: 0.22
Nodes (9): Core principles, Entry point, Layout, Security gate, Shared components, Stack (locked — October 2026), sylvain-builder, UI quality without a generic AI look (+1 more)

### Community 89 - "_row_identities"
Cohesion: 0.25
Nodes (8): _exact_row_identity(), Suggest complete public identities so a retry can bypass score thresholds., Return non-empty public identities from ordinary and alias fields., Resolve an explicit style identity without opening generic variant ranking., Return one row whose stable public identity exactly matches the query., _row_identities(), _style_identity(), _suggest_identities()

### Community 90 - ".generate"
Cohesion: 0.25
Nodes (5): Execute searches across multiple domains., Extract results list from search result dict., Generate complete design system recommendation. variance/motion/density are…, Bucket a 1-10 dial value into its tier config. Returns None if value is None., _resolve_dial()

### Community 91 - "test_design_system_mode.py"
Cohesion: 0.39
Nodes (3): _filter_anti_patterns_for_mode(), Drop "avoid dark mode" advice once dark mode is the resolved answer., TestAntiPatternGating

### Community 92 - "_select_palette_for_mode"
Cohesion: 0.39
Nodes (3): Pick the highest-ranked palette matching the resolved mode. Only the dark case…, _select_palette_for_mode(), TestPaletteSelection

### Community 93 - "test_skill_script_paths.py"
Cohesion: 0.38
Nodes (5): Every script invocation in the shipped skill markdown resolves from the skill…, Return (target, None) for a skill-relative path, or (None, reason)., resolve(), shipped_invocations(), SkillScriptPathsTest

### Community 94 - "Architecture"
Cohesion: 0.33
Nodes (6): Architecture, Data flow, Hard rules (cross-cutting), Hook runtime compatibility, Pillars, Portable runtime model

### Community 97 - "Frontend design"
Cohesion: 0.40
Nodes (4): Contraintes sylvain-builder, Frontend design, Méthode, Quand l'utiliser

### Community 98 - "UI/UX Pro Max"
Cohesion: 0.40
Nodes (4): Contraintes sylvain-builder, Quand l'utiliser, Recherche minimale, UI/UX Pro Max

### Community 99 - "validate-java-idioms"
Cohesion: 0.50
Nodes (3): Flag, Output and result, validate-java-idioms

## Knowledge Gaps
- **296 isolated node(s):** `guard-git-commit-hook.sh script`, `load-active-todo-hook.sh script`, `validate-hook-contracts.sh script`, `Responsibilities`, `Skills you call` (+291 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **20 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `search()` connect `search` to `search.py`, `validate_data.py`, `core.py`, `BM25`, `search_stack`, `design_system.py`, `test_text_layout_resilience.py`, `_normalize`, `_row_identities`, `.generate`?**
  _High betweenness centrality (0.039) - this node is a cross-community bridge._
- **Why does `DesignSystemGenerator` connect `DesignSystemGenerator` to `BM25`, `design_system.py`, `TestLightResultOutputCoherence`, `.generate`, `test_design_system_mode.py`?**
  _High betweenness centrality (0.034) - this node is a cross-community bridge._
- **Why does `search_stack()` connect `search_stack` to `search.py`, `core.py`, `search`, `BM25`, `TestNativeDesktopStackFreshness`, `test_text_layout_resilience.py`, `_normalize`?**
  _High betweenness centrality (0.021) - this node is a cross-community bridge._
- **Are the 4 inferred relationships involving `DesignSystemGenerator` (e.g. with `TestReasoningMatch` and `TestReasoningContract`) actually correct?**
  _`DesignSystemGenerator` has 4 INFERRED edges - model-reasoned connections that need verification._
- **Are the 20 inferred relationships involving `Path` (e.g. with `.test_catalog_cross_check_uses_explicit_schema_without_font_file_urls()` and `.test_catalog_rejects_bool_rank_duplicate_axis_and_unreviewed_addition()`) actually correct?**
  _`Path` has 20 INFERRED edges - model-reasoned connections that need verification._
- **What connects `guard-git-commit-hook.sh script`, `load-active-todo-hook.sh script`, `validate-hook-contracts.sh script` to the rest of the system?**
  _296 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Decision log` be split into smaller, more focused modules?**
  _Cohesion score 0.14285714285714285 - nodes in this community are weakly interconnected._