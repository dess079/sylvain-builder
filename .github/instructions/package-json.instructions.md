---
applyTo: "**/package.json"
description: package.json rules — React 19.3, Vite 8, TypeScript 7, Node 26 and pnpm mandatory.
---

# package.json rules

- `"engines"`: `{"node": ">=26"}`.
- React and React DOM: `19.3.0`; MUI: `9.4.0` with its required Emotion peers.
- All dependencies pinned **exactly** — no `^`, no `~`, no version ranges.
- `"type": "module"`.
- **pnpm only** — never `npm install` / `npm run` / `npx`. One-shot: `pnpm dlx <pkg>`.
- Keep `"packageManager": "pnpm@<version>"` and commit `pnpm-lock.yaml`.
- Required dev deps: `typescript@7.0.2`, `vite@8.3.4`, `@vitejs/plugin-react@6.1.2`, `@rolldown/plugin-babel`, `@babel/core`, `eslint@10.12.0`, `eslint-plugin-react-hooks@7.1.1`, `@eslint/js`, `babel-plugin-react-compiler`, `vitest`, `jsdom` and React Testing Library.
- Required scripts: `dev`, `build`, `preview`, `lint`, `test`, `audit:strict` (= `pnpm audit --prod --audit-level high`).
- License field set; `private: true` unless publishing.
- Deviation requires an ADR entry.
