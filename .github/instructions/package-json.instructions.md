---
applyTo: "**/package.json"
description: package.json rules — React 19.2, Vite 8, Node 22, pnpm mandatory.
---

# package.json rules

- `"engines"`: `{"node": ">=22.12"}` (Vite 8 requirement).
- React minimum versions: `react@19.2.1`, `react-dom@19.2.1` (Dec 2025 RSC CVE patches).
- All dependencies pinned **exactly** — no `^`, no `~`, no version ranges.
- `"type": "module"`.
- **pnpm only** — never `npm install` / `npm run` / `npx`. One-shot: `pnpm dlx <pkg>`.
- Keep `"packageManager": "pnpm@<version>"` and commit `pnpm-lock.yaml`.
- Required dev deps: `typescript@6.0.0`, `vite@8.0.11`, `@vitejs/plugin-react`, `eslint@10.0.0`, `eslint-plugin-react-hooks@7.1.1`, `@eslint/js`, `babel-plugin-react-compiler`.
- Required scripts: `dev`, `build`, `preview`, `lint`, `audit:strict` (= `pnpm audit --prod --audit-level high`).
- **No test frameworks.** No `vitest`, `jest`, `@testing-library/*`, `cypress`, `playwright`. The frontend has zero tests by policy.
- License field set; `private: true` unless publishing.
- Deviation requires an ADR entry.
