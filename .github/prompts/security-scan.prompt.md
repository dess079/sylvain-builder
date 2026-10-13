---
description: Run a full security pass — deps + source scans on backend and frontend.
agent: security-guardian
---

# /security-scan

1. `run-security-gate`
2. `audit-pom-dependencies`
3. `audit-npm-dependencies`
4. `scan-source-vulnerabilities`

Aggregate the three reports into `.sylvain/reports/security-scan-<timestamp>.md` and return a one-paragraph executive summary plus a sorted list of HIGH+ findings.
