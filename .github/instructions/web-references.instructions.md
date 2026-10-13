---
name: web-references
description: Canonical official links for version research when the lock matrix changes.
applyTo: ".sylvain/compatibility-matrix.json"
---

# Web references — single source of truth

Always prefer these over training data when unsure. Citing them in commits or ADRs is encouraged.

## Backend — Java 27 / Spring Boot 4 / Spring AI

- Spring Boot reference: https://docs.spring.io/spring-boot/reference/
- Spring Boot releases: https://github.com/spring-projects/spring-boot/releases
- Spring Framework reference: https://docs.spring.io/spring-framework/reference/
- Spring Security reference: https://docs.spring.io/spring-security/reference/
- Spring AI reference: https://docs.spring.io/spring-ai/reference/
- Spring AI releases: https://github.com/spring-projects/spring-ai/releases
- Hibernate ORM: https://hibernate.org/orm/documentation/
- Testcontainers: https://java.testcontainers.org/
- JUnit: https://docs.junit.org/current/user-guide/
- AssertJ: https://assertj.github.io/doc/
- Mockito: https://site.mockito.org/
- springdoc-openapi: https://springdoc.org/

## Frontend — React 19.3 / Vite 8 / TypeScript 7 / MUI 9

- React reference: https://react.dev/reference/react
- React Compiler: https://react.dev/learn/react-compiler
- Rules of React: https://react.dev/reference/rules
- React releases: https://github.com/facebook/react/releases
- Vite guide: https://vite.dev/guide/
- Vite config: https://vite.dev/config/
- TypeScript handbook: https://www.typescriptlang.org/docs/handbook/
- Node.js releases: https://nodejs.org/en/about/previous-releases
- ESLint: https://eslint.org/docs/latest/
- eslint-plugin-react-hooks: https://www.npmjs.com/package/eslint-plugin-react-hooks
- Material UI: https://mui.com/material-ui/getting-started/
- Vitest: https://vitest.dev/

## Security

- OWASP Top 10 (2025): https://owasp.org/Top10/
- OWASP LLM Top 10 (2025): https://genai.owasp.org/llm-top-10/
- OWASP Cheat Sheets: https://cheatsheetseries.owasp.org/
- OWASP Dependency-Check: https://owasp.org/www-project-dependency-check/
- CycloneDX SBOM: https://cyclonedx.org/
- SLSA supply-chain: https://slsa.dev/
- Sigstore: https://www.sigstore.dev/

## VS Code Copilot customization

- Custom agents: https://code.visualstudio.com/docs/copilot/customization/custom-agents
- Agent skills: https://code.visualstudio.com/docs/copilot/customization/agent-skills
- Custom instructions: https://code.visualstudio.com/docs/copilot/customization/custom-instructions
- Prompt files: https://code.visualstudio.com/docs/copilot/customization/prompt-files
- Hooks: https://code.visualstudio.com/docs/copilot/customization/hooks

## Rules for the AI

1. Before scaffolding a new project, invoke the `suggest-latest-stack` skill — it cross-checks the matrix against these references.
2. When introducing a new dependency, cite the official doc URL above in the commit body.
3. Never invent version numbers. If unknown, fetch the GitHub releases page or the official site listed here.
4. For Spring AI, always read the current reference — APIs changed significantly from 1.x to 2.0; do not rely on pre-2.0 examples.
5. For React, never write manual `useMemo`/`useCallback`/`React.memo` — Compiler 1.0 GA handles them. See the React Compiler doc.
