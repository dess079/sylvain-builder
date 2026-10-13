---
name: reuse-shared-components
description: Reuses the approved shared-components library before creating React or MUI UI. Use for every new screen, toolbar, settings control, AI screen, hook, or reusable component review.
user-invocable: false
---

# reuse-shared-components

Read `.sylvain/shared-components.json` and inspect the public exports of the
configured `shared-components` package before creating UI code. Import only
from its package root; never reach into its `src/` internals.

## Mandatory composition

- Application root: integrate `AppProviders` when the project uses the shared runtime.
- Toolbar: use `MenuBar` by default. If a custom toolbar is justified, it must
  include `ThemeSelector` and `PreferencesPanel` (which displays
  `PreferencesIcon`, the settings icon) rather than cloning either control.
- AI screen: use `AiChatPanel` when its complete conversation surface fits.
  Otherwise compose the existing `AiPromptCard` and `AiResponseBlock`; do not
  create replacement prompt or answer components.

## Promotion rule

Before adding a component or hook, search the library's public exports and the
current project. If the artifact is generic, backend-agnostic and useful in at
least two applications, implement it in `shared-components` with focused tests,
public root export, documentation and a version/release update. Keep only
feature-specific orchestration and API mapping in the application.

If the configured library source is unavailable, block the UI task and request
the package source (workspace, private registry or local link); do not silently
reimplement its components.
