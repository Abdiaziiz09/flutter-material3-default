# CLAUDE.md

@AGENTS.md

The imported `AGENTS.md` is the complete, authoritative standard for this
repository. Everything in it applies to Claude Code and every other Claude
agent working here.

Quick reminders:

- **Samsung Icons Only (100% Mandatory)**: Every icon must be a **Samsung Icon (One UI Icon)** — never use `Icons.*`, `CupertinoIcons.*`, or any other icon set, and never guess or invent icons. Retrieve exact icons from `OneUIProject/oneui-icons`, `thatjoshguy67/oneui-icons`, `SamsungInternet/OneUI-Web`, or `one_uikit`. See `docs/ICONOGRAPHY.md`.
- **Invisible foundation**: Never expose the design system in the UI. No text,
  label or tooltip that mentions Material 3 tokens, AppMotion, TactileSurface,
  or the design system itself. The UI contains only the product's own content.
- **Design tokens**: use `Theme.of(context).colorScheme`, `textTheme`, `AppSpacing`, `AppRadii`, and `context.motion` (`AppMotion`).
- **Context-aware motion & interaction**: use `ContextualSwitcher`, `SmoothExpandable`, and `TactileSurface` only where motion adds clarity or tactile feedback, and always respect `MediaQuery.disableAnimationsOf(context)`.
- **Engagement foundations**: reduce friction, guide the default path, eliminate dead ends (`FeedbackStateView`), and preserve user progress (`docs/ENGAGEMENT_PRINCIPLES.md`).
- **Mandatory Responsive Navigation (`FloatingPillNavBar` + `TopHeaderNavBar`)**:
  Use `AdaptiveScaffold` for all top-level navigation. On mobile/narrow
  viewports (< 840 dp, `compact` & `medium`), it renders `FloatingPillNavBar`
  (floating, frosted-glass pill with `extendBody: true` and `Menu` overflow
  when > 4 items). On desktop/laptop web (≥ 840 dp, `expanded`+), it renders
  `TopHeaderNavBar` (a top header menu with **no** bottom bar, overflowing
  extra items into a header dropdown menu — never `NavigationRail` or
  `NavigationDrawer`).
- **Fully responsive** using `lib/core/responsive/`, `AdaptiveScaffold`, and `ListDetailLayout`.
- Meaningful names and `///` documentation on every public member.
- Finish with `dart format .`, `flutter analyze` and `flutter test`. If you
  cannot run them, say so explicitly instead of claiming success.
