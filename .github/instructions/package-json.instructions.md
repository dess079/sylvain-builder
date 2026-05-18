---
applyTo: "**/package.json"
description: package.json rules — React 19.2, Vite 6, Node 22.
---

# package.json rules

- `"engines"`: `{"node": ">=22"}`.
- React minimum versions: `react@19.2.1`, `react-dom@19.2.1` (Dec 2025 RSC CVE patches).
- All dependencies pinned **exactly** — no `^`, no `~`, no version ranges.
- `"type": "module"`.
- Required dev deps: `typescript@~5.7`, `vite@~6`, `@vitejs/plugin-react`, `eslint@9+`, `eslint-plugin-react-hooks@5+`, `@eslint/js`, `babel-plugin-react-compiler`.
- Required scripts: `dev`, `build`, `preview`, `lint`, `audit:strict` (= `npm audit --omit=dev --audit-level=high`).
- **No test frameworks.** No `vitest`, `jest`, `@testing-library/*`, `cypress`, `playwright`. The frontend has zero tests by policy.
- License field set; `private: true` unless publishing.
- Deviation requires an ADR entry.
