---
description: Run a full security pass — deps + source scans on backend and frontend.
agent: security-guardian
---

# /security-scan

1. `audit-pom-dependencies`
2. `audit-npm-dependencies`
3. `scan-source-vulnerabilities`

Aggregate the three reports into `.sylvain/reports/security-scan-<timestamp>.md` and return a one-paragraph executive summary plus a sorted list of HIGH+ findings.
