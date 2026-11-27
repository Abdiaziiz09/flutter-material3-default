# GitHub Copilot instructions

This repository is the **Flutter Material 3 Default Standard**. The complete
rules are in [`AGENTS.md`](../AGENTS.md); read it before generating code. The
essentials:

- **Samsung Icons Only (100% Mandatory)**: Every icon must be a **Samsung Icon
  (One UI Icon)**. Never use `Icons.*` (Material Icons), `CupertinoIcons.*`, or
  any other icon set, and never guess or invent icons. Retrieve exact icons
  from `OneUIProject/oneui-icons`, `thatjoshguy67/oneui-icons`,
  `SamsungInternet/OneUI-Web`, or `one_uikit`. See `docs/ICONOGRAPHY.md`.
- **Invisible foundation**: Never surface the design system in the UI. No
  labels, badges or tooltips like "Built with Material 3 tokens", "Powered by
  AppMotion" or any reference to this design system. The UI shows only the
  product's own content.
- Use Flutter's official **Material 3** design system (`useMaterial3: true`)
  through `lib/core/theme/app_theme.dart` for the entire UI.
- Get colours from `Theme.of(context).colorScheme`, text styles from
  `Theme.of(context).textTheme`, spacing from `AppSpacing`, radii from
  `AppRadii`, and motion from `context.motion` (`AppMotion`). Do not hard-code
  colours, font sizes, durations or magic numbers.
- Apply **context-aware motion & interaction** (`ContextualSwitcher`,
  `SmoothExpandable`, `TactileSurface`) purposefully — never add gratuitous
  animations, and always respect `MediaQuery.disableAnimationsOf(context)`.
- Follow **engagement foundations** (`docs/ENGAGEMENT_PRINCIPLES.md`): keep core
  actions effortless, guide the default path, and eliminate dead ends.
- **Mandatory Floating Pill Bottom Navigation (`FloatingPillNavBar`)**: Always
  use `AdaptiveScaffold` / `FloatingPillNavBar` — a floating, frosted-glass,
  capsule-shaped bottom navigation bar with `extendBody: true` (content scrolls
  underneath) — on **every** screen size and platform (including Web and
  desktop; never use `NavigationRail` or `NavigationDrawer`). Order
  destinations by importance: keep ≤ 4 primary items on the pill and overflow
  secondary items into `Menu`.
- Every screen and widget must be **fully responsive** (320 px to 2560 px,
  portrait and landscape, up to 200% text scale). Use `WindowSizeClass`,
  `ResponsiveBuilder`, `AdaptiveScaffold`, `ListDetailLayout`,
  `AdaptiveContentContainer`, `ResponsiveSliverGrid` and `FeedbackStateView`.
- Support Android, iOS, Web, Windows, macOS and Linux. Do not import `dart:io`
  in shared UI code.
- Use the feature-first layout under `lib/features/<feature>/presentation/`.
- Use clear, purposeful names following Effective Dart, and `///` doc comments
  on every public member.
- Extract widget classes rather than methods returning `Widget`; prefer `const`.
- Add tests, and make sure `dart format .`, `flutter analyze` and
  `flutter test` succeed.
