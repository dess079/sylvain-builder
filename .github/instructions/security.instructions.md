---
name: security
description: Security rules for application source, configuration and Spring AI assets.
applyTo: "**/*.{java,ts,tsx,js,jsx,xml,yml,yaml,properties,st}"
---

# Security baseline

A HIGH or CRITICAL finding stops the task. Use the executable security gate for
evidence; these rules prevent unsafe code before that review.

- Authenticate and authorize every data-changing or sensitive endpoint. Use
  default-deny security configuration and enforce tenant/object ownership.
- Validate input at the boundary. Parameterize JPA/SQL queries; never concatenate
  untrusted SQL, shell arguments, URLs, paths or expressions.
- Treat output as untrusted. Do not use `dangerouslySetInnerHTML`, `eval`, raw
  deserialization or browser token storage without a reviewed design.
- Keep secrets, tokens, connection strings and PII out of source and logs; use
  managed configuration. Restrict actuator and security headers in deployment.
- Allowlist outbound destinations and validate redirects to prevent SSRF.
- For AI features: keep system instructions separate from user input, treat model
  output and tool arguments as untrusted, authorize each tool server-side, scope
  retrieval by tenant, redact sensitive data, rate-limit and bound token use.
- Never introduce unsafe primitives (`Runtime.exec` with user input,
  `ObjectInputStream` on untrusted bytes, insecure crypto defaults) without a
  reviewed, documented boundary.
