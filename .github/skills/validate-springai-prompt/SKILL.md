---
name: validate-springai-prompt
description: Caveman check that a prompt file fits Spring AI 2.0.1 template rules (StringTemplate {var}, brace vs JSON conflict, ghost vars, role split, structured output). Read-only — give report, fix only when asked.
context: fork
---

# validate-springai-prompt

Me caveman. Me check prompt fit Spring AI 2.0.1. Me talk short.

## When to use

- New or changed prompt file under `src/main/resources/prompts`.
- Before wire a prompt to `PromptTemplate` / `ChatClient`.

## What me check

**Template var**

- Var must be `{var}` (StringTemplate default). Flag `${var}`, `{{var}}`, `%s`.
- Var name = letters/digits/underscore. No space, no dot inside brace.

**Brace vs JSON fight**

- If file hold literal JSON `{ ... }` AND template var, the `{` confuse engine.
- Fix path: use custom delimiter (`<var>` via `StTemplateRenderer`) OR mark prompt for `NoOpTemplateRenderer` (no var render).
- Flag every raw `{` that is not a real var.

**Ghost var**

- List all `{var}` in file. Each one need a value from code `variables(...)`.
- Flag var with no known feeder. Flag code var with no slot in file.

**Role split**

- System rule text → own file, load by `@Value("classpath:/prompts/..")` into `SystemPromptTemplate`.
- User ask → user role. No secret, no PII inside system prompt (LLM07).
- Untrusted input must sit in user role, with clear delimiter (LLM01 prompt-injection).

**Structured output**

- Typed answer wanted? Prefer `BeanOutputConverter` + `{format}` slot over hand-made JSON canvas.
- If hand-made JSON canvas stay, parser key must be exact and stable.

**Honesty / safety**

- No fake promise. Lotto-type prompt must keep real odds note.
- `confidenceScore` (or like) must stay calibrated, not gonfle.

## Output

Report at `.sylvain/reports/prompt-check-<timestamp>.md`:

- One row per file: var list, conflicts, role issues, verdict (OK / WARN / BLOCK).
- For each issue: file + line + rule + short fix.

## Blocking rules

- Wrong var syntax that break render → BLOCK.
- Raw JSON brace clash with template var, no delimiter fix → BLOCK.
- Secret or untrusted input in system prompt → BLOCK.

## Failure modes

- File not UTF-8 or unreadable → mark `blocked`, surface for `quality-gate`.
