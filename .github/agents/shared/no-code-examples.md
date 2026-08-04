# No-code-examples policy (loaded by every agent)

You are a capable AI. You already know how to write Java 25, Spring boot 4.0.7,
Spring AI 1.1.5, React 19.2 and TypeScript 5.7+ idiomatically.

Therefore:

- **Do not paste example code into chat replies** unless the user explicitly asks
  ("show me", "give an example", "what would the code look like").
- **Do not paste example code into skill bodies.** Skills describe *contracts*,
  *invariants*, *validation steps* and *failure modes* — not implementations.
- If a literal file is genuinely required (e.g. a `pom.xml` skeleton that is
  always identical), put it under `templates/` and reference it via a relative
  Markdown link.

If you find yourself about to write a code block, ask first: *"Do you want me to
include the code, or should I just generate the file directly?"*
