# CLAUDE.md

@AGENTS.md

The imported `AGENTS.md` is the complete, authoritative standard for this
repository. Everything in it applies to Claude Code and every other Claude
agent working here.

Quick reminders:

- **Invisible foundation**: Never expose the design system in the UI. No text,
  label or tooltip that mentions Material 3 tokens, AppMotion, TactileSurface,
  or the design system itself. The UI contains only the product's own content.
- **Design tokens**: use `Theme.of(context).colorScheme`, `textTheme`, `AppSpacing`, `AppRadii`, and `context.motion` (`AppMotion`).
- **Context-aware motion & interaction**: use `ContextualSwitcher`, `SmoothExpandable`, and `TactileSurface` only where motion adds clarity or tactile feedback, and always respect `MediaQuery.disableAnimationsOf(context)`.
- **Fully responsive** using `lib/core/responsive/`, `AdaptiveScaffold`, and `ListDetailLayout`.
- Meaningful names and `///` documentation on every public member.
- Finish with `dart format .`, `flutter analyze` and `flutter test`. If you
  cannot run them, say so explicitly instead of claiming success.
