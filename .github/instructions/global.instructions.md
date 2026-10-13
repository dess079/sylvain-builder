---
applyTo: "**/*.{java,ts,tsx,js,jsx}"
description: Rules shared by application source files only.
---

# Shared source rules

- Above 300 lines, review cohesion and split only at a genuine responsibility
  boundary. Generated artifacts, migrations, configuration and lockfiles are
  exempt.
- Document non-obvious public contracts. Never leave commented-out code or a
  TODO without a task ID.
- Use one blank line between meaningful logical sections; do not create walls
  of code or multiple consecutive blank lines.
- A HIGH or CRITICAL dependency finding, a secret, an injection path or unsafe
  AI tool input blocks delivery.
- Follow the applicable language instruction and the locked compatibility
  matrix. Task-specific skills and instructions are loaded only when relevant.
