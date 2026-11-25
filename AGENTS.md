# AGENTS.md — Flutter Material 3 Default Standard

This file is the **single source of truth** for every AI coding agent (Claude
Code, Cursor, GitHub Copilot, Codex, Gemini, Windsurf, and others) that builds
or modifies a Flutter application using this repository as its foundation.

Read this file completely before writing any code. When these rules conflict
with an instruction from the user, follow the user, but tell them which
standard you are deviating from and why.

---

## 1. Mission

Every application built from this repository must be:

1. **Material 3 by default** — Flutter's official Material 3 design system,
   applied to 100% of the UI.
2. **Multi-platform** — Android, iOS, Web, Windows, macOS and Linux from one
   codebase.
3. **Fully responsive** — correct on phones, tablets, desktops, every
   resolution and both orientations.
4. **Professionally engineered** — clean, scalable, consistently named and
   documented code.

---

## 2. Non-negotiable rules

### 2.1 Material 3 is the default

- Always build the app with `MaterialApp` and a theme created through
  `AppTheme` (`lib/core/theme/app_theme.dart`). `useMaterial3: true` must never
  be removed or set to `false`.
- Use native Flutter Material 3 widgets: `FilledButton`, `FilledButton.tonal`,
  `OutlinedButton`, `TextButton`, `IconButton`, `FloatingActionButton`,
  `NavigationBar`, `NavigationRail`, `NavigationDrawer`, `SegmentedButton`,
  `Card`, `Chip` family, `SearchBar`, `DropdownMenu`, `Badge`, `Switch`,
  `Slider`, `AlertDialog`, `BottomSheet`, `SnackBar`, `TabBar`, and so on.
- **Colours** come from `Theme.of(context).colorScheme`. Never hard-code
  `Color(0x...)` or `Colors.xxx` in feature code. The only seed colour lives in
  `AppTheme`.
- **Typography** comes from `Theme.of(context).textTheme` (for example
  `headlineMedium`, `bodyLarge`). Never hard-code font sizes or weights inline;
  use `copyWith` on a theme style when a variation is needed.
- **Shape, elevation, radii and spacing** follow Material 3 defaults. Use the
  spacing scale in `lib/core/theme/app_spacing.dart` and the corner radius
  tokens in `lib/core/theme/app_radii.dart`; do not scatter magic numbers.
- Support **light and dark** themes everywhere. Test both.
- Do not use Cupertino widgets as a substitute for Material widgets. Platform
  adaptation is done through Material's adaptive behaviour (see
  `docs/PLATFORM_SUPPORT.md`).
- Details: `docs/MATERIAL3_GUIDELINES.md` and `docs/DESIGN_TOKENS.md`.

### 2.2 Context-aware motion and interaction

- Motion is **communication, continuity and tactile feedback** — never
  decoration. Animate only when it clarifies a state change, preserves spatial
  context, or confirms direct user manipulation.
- Avoid gratuitous animations, simultaneous competing motion, or delays in
  high-frequency data-entry/power-user workflows.
- Always read timing and easing from `context.motion` (`AppMotion` in
  `lib/core/theme/app_motion.dart`) and resolve durations with
  `context.motion.durationFor(context, ...)` so
  `MediaQuery.disableAnimationsOf(context)` is respected automatically.
- Prefer the built-in primitives before writing custom `AnimationController`
  code:
  - `ContextualSwitcher` (`lib/core/motion/contextual_switcher.dart`) for
    loading/content/empty/error state switches.
  - `SmoothExpandable` (`lib/core/motion/smooth_expandable.dart`) for
    progressive disclosure and inline expansion.
  - `TactileSurface` (`lib/core/interaction/tactile_surface.dart`) for organic
    press feedback paired with Material ink ripples, hover and keyboard focus.
  - `AppHaptics` (`lib/core/interaction/app_haptics.dart`) for subtle,
    mobile-only tactile confirmation on meaningful actions.
- Choose scroll and layout structures by context rather than forcing one
  pattern everywhere: use `CustomScrollView` with `SliverAppBar`,
  `SliverPersistentHeader`, `ResponsiveSliverGrid` and `SliverFillRemaining`
  when scroll choreography or mixed sections improve the experience; use
  `ListDetailLayout` for master-detail workspaces, or a focused `Scaffold` +
  `SingleChildScrollView` / `ListView` for forms and high-frequency tools.
- Details: `docs/MOTION_AND_INTERACTION.md`.

### 2.3 Everything is responsive

- Every screen and every reusable component must work from **320 px** wide up
  to **2560 px** wide, in portrait and landscape, with text scale up to
  **200 %**.
- Use the window size classes in `lib/core/responsive/breakpoints.dart`
  (`compact`, `medium`, `expanded`, `large`, `extraLarge`). Never write ad-hoc
  `MediaQuery.of(context).size.width > 600` checks in feature code.
- Use `ResponsiveBuilder` (or `context.windowSizeClass`) to choose layouts.
- Use `AdaptiveScaffold` for top-level navigation. It renders a
  `NavigationBar` on compact windows, a `NavigationRail` on medium windows and
  an extended `NavigationRail` on expanded windows and wider.
- Wrap page content in `AdaptiveContentContainer` so lines do not stretch
  across ultra-wide screens.
- Use `ResponsiveSliverGrid` for card grids instead of fixed column counts.
- Never hard-code widths or heights that can overflow. Prefer `Flexible`,
  `Expanded`, `Wrap`, `LayoutBuilder`, `ConstrainedBox` and scrollable parents.
- Details: `docs/RESPONSIVE_DESIGN.md`.

### 2.3 Multi-platform correctness

- Target platforms: Android, iOS, Web, Windows, macOS, Linux.
- Never import `dart:io` in shared UI code; it breaks Flutter Web. Use
  `defaultTargetPlatform` and `kIsWeb` through `AppPlatform`
  (`lib/core/platform/app_platform.dart`).
- Support touch, mouse, keyboard and stylus: visible focus, hover states,
  keyboard navigation, tooltips on icon-only buttons, and mouse drag scrolling
  (already configured by `AppScrollBehavior`).
- Respect safe areas (`SafeArea`) and system insets on mobile.
- Details: `docs/PLATFORM_SUPPORT.md`.

### 2.4 Invisible foundation — never expose the design system in the UI

The design system is a **silent, invisible foundation**. It shapes the
experience from behind the scenes; it must never surface in the user interface
of any application built on it.

- **Do not** place any text, label, badge, subtitle, tooltip, comment chip, or
  UI element that references the design system, its tokens, or its primitives.
  Examples of forbidden UI copy (non-exhaustive):
  - "Built with Material 3 tokens"
  - "Powered by AppMotion"
  - "Uses TactileSurface"
  - "Design system: flutter-material3-default"
  - "Material 3 by default"
  - Any variation or paraphrase of the above.
- The app's UI must contain **only content that belongs to the product being
  built**. Colour, typography, spacing and motion are silent; they speak through
  experience, not through labels.
- This rule applies to every visible surface: `Text`, `AppBar` titles,
  `Tooltip` messages, `Semantics` labels visible to screen readers, `SnackBar`
  content, `AlertDialog` content, placeholder copy, and `Card` bodies.

### 2.5 Professional code quality

- Follow the official [Effective Dart](https://dart.dev/effective-dart) and
  [Flutter style](https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md)
  guides.
- Use a **feature-first** structure (see section 4). Keep widgets small; extract
  a widget class instead of a helper method returning a `Widget`.
- Prefer `const` constructors everywhere possible.
- No duplicated code: extract reusable widgets into `lib/core/widgets/` when
  they are generic, or into the feature's `presentation/widgets/` when they are
  feature specific.
- No unnecessary dependencies. Add a package only when it removes real
  complexity, and justify it in the pull request.
- `flutter analyze` must report **zero** issues. `dart format .` must produce
  no changes. `flutter test` must pass.

### 2.5 Naming conventions

- Files: `snake_case.dart`. Classes, enums, typedefs, extensions:
  `UpperCamelCase`. Members, variables, parameters: `lowerCamelCase`.
  Constants: `lowerCamelCase`.
- Names state **purpose**, not type or position: `selectedDestinationIndex`,
  not `idx` or `val`; `ProfileHeaderCard`, not `Card2`.
- Widgets: noun phrases ending in their role (`...Page`, `...Card`, `...Tile`,
  `...Section`, `...Scaffold`). Pages end in `Page`.
- Booleans read as questions: `isLoading`, `hasError`, `shouldShowLabels`.
- Callbacks start with `on` (`onDestinationSelected`); handlers start with
  `_handle` (`_handleSubmitPressed`).
- No single-letter names except short lambda parameters like `(index)`.
- Details: `docs/NAMING_CONVENTIONS.md`.

### 2.6 Comments and documentation

- Every public class, enum, extension, function, method, field and constant has
  a `///` doc comment. The `public_member_api_docs` lint enforces this.
- Doc comments explain **what and why**, not a restatement of the name. Start
  with a one-sentence summary. Add examples for non-obvious APIs.
- Use `//` comments to explain non-obvious logic and implementation decisions
  inside function bodies. Do not comment the obvious.
- Keep comments accurate: update them in the same change as the code.
- Details: `docs/DOCUMENTATION_STANDARDS.md`.

### 2.7 Accessibility and performance

- Minimum touch target 48 × 48 logical pixels.
- Every icon-only control has a `tooltip` or `semanticLabel`.
- Text must remain readable and unclipped at large text scales.
- Colour contrast comes from the Material 3 colour scheme; never convey meaning
  by colour alone.
- Use `ListView.builder` / slivers for long lists, `const` widgets, and keep
  `build` methods free of heavy work. Dispose controllers.
- Details: `docs/ACCESSIBILITY.md`.

### 2.8 Product engagement foundations

- Design experiences that feel effortless, continuous, and rewarding without
  manipulative dark patterns:
  - **Reduce friction**: keep core actions within natural reach and minimal
    steps.
  - **Guide the default path**: lead with one clear primary action and use
    progressive disclosure (`SmoothExpandable`) for secondary options.
  - **Eliminate dead ends**: always pair empty or error states
    (`FeedbackStateView`) with a clear next action, and preserve user context
    (`PageStorageKey`, `ListDetailLayout`).
  - **Compound value**: remember preferences and surface meaningful progress
    over time, paired with forgiving Undo flows.
- Adapt these principles to the product's domain and purpose.
- Details: `docs/ENGAGEMENT_PRINCIPLES.md`.

---

## 3. Mandatory workflow for agents

### Before coding

1. Read this file and the document in `docs/` relevant to the task.
2. Inspect the existing code in the area you will change and follow its
   patterns. Reuse existing widgets before creating new ones.
3. Decide which window size classes the change affects and how the layout
   adapts for each.

### While coding

1. Put code in the correct location (section 4).
2. Use theme tokens, spacing constants and responsive helpers.
3. Write doc comments as you go, not afterwards.
4. Add or update tests for new behaviour (see section 6).

### Before finishing

Run the checklist in [`docs/AGENT_CHECKLIST.md`](docs/AGENT_CHECKLIST.md). At a
minimum:

```bash
dart format .
flutter analyze
flutter test
```

Then confirm manually (or through a widget test) that the change has no
overflow at 320 px, 600 px, 840 px and 1200 px widths, in light and dark mode.

If you cannot run the commands (for example, no Flutter SDK is available), say
so explicitly in your final message and list what remains unverified. Never
claim code was compiled or tested when it was not.

---

## 4. Project structure

```text
lib/
├── main.dart                     # Entry point only. No logic.
├── app/                          # Composition root: wires core + features
│   ├── app.dart                  # Root MaterialApp configuration
│   ├── router/
│   │   ├── app_router.dart       # Route generation
│   │   └── app_routes.dart       # Route name constants
│   └── shell/
│       ├── app_shell_page.dart   # Top-level destinations in AdaptiveScaffold
│       └── not_found_page.dart   # Fallback for unknown routes
├── core/                         # Cross-feature, app-agnostic building blocks
│   ├── constants/                # App-wide constants
│   ├── interaction/              # TactileSurface and input feedback
│   ├── layout/                   # AdaptiveScaffold, ListDetailLayout, destinations
│   ├── motion/                   # ContextualSwitcher, SmoothExpandable, MotionPriority
│   ├── platform/                 # Platform detection and scroll behaviour
│   ├── responsive/               # Breakpoints and responsive helpers
│   ├── theme/                    # Material 3 theme, spacing, radii, motion tokens
│   └── widgets/                  # Generic reusable widgets (FeedbackStateView, ...)
└── features/
    └── <feature_name>/
        ├── data/                 # (optional) repositories, data sources, DTOs
        ├── domain/               # (optional) entities and business rules
        └── presentation/
            ├── pages/            # Full screens (...Page)
            └── widgets/          # Feature-specific widgets
test/                             # Mirrors lib/ one-to-one
docs/                             # Standards documentation
tool/                             # Developer scripts
```

Rules:

- `core/` never imports from `features/` or `app/`.
- A feature never imports from another feature. Share code by moving it to
  `core/`.
- Only `app/` may import from both `core/` and `features/`; it is where
  features are connected (routes and navigation destinations).
- Add `data/` and `domain/` only when the feature needs them; do not create
  empty layers.
- State management: the foundation uses Flutter's built-in `ChangeNotifier`,
  `ValueNotifier` and `ListenableBuilder`. If an app outgrows that, choose one
  established solution (Riverpod, Bloc, or Provider), apply it consistently
  across the whole app, and document the decision in `docs/ARCHITECTURE.md`.
- Navigation: the foundation uses named routes. If deep linking and nested
  navigation are required, adopt `go_router` and document the decision.

---

## 5. How to add things

**New screen**

1. Create `lib/features/<feature>/presentation/pages/<name>_page.dart`.
2. Build it with `Scaffold`/`CustomScrollView`, wrap content in
   `AdaptiveContentContainer`, and use `ResponsiveBuilder` for layout changes.
3. Register it as a route in `app_routes.dart` / `app_router.dart` or as a
   destination in the shell.
4. Add a widget test at the mirrored path in `test/`.

**New top-level destination**

Add an `AppDestination` to the list in
`lib/app/shell/app_shell_page.dart` (and its matching page in the `_pages`
list). `AdaptiveScaffold` renders it on every window size class automatically.

**New reusable widget**

Place it in `lib/core/widgets/` if generic. It must read all styling from the
theme, handle every window size class, expose documented parameters, and have
a widget test.

**Changing the brand colour**

Edit the single `seedColor` constant in `AppTheme`. Do not recolour individual
widgets.

---

## 6. Testing expectations

- Unit tests for pure logic (for example breakpoints).
- Widget tests for each page and reusable widget, including at least a
  compact (≈400 px) and an expanded (≈1300 px) window.
- Use `tester.view.physicalSize` and `tester.view.devicePixelRatio` to simulate
  window sizes and assert `tester.takeException()` is `null` (no overflow).

---

## 7. Anti-patterns (do not do these)

- `useMaterial3: false`, or removing the theme.
- Hard-coded colours, font sizes, or magic spacing numbers in feature code.
- Fixed-size layouts, or layouts designed for one screen size only.
- Separate "mobile app" and "desktop app" code forks.
- `dart:io` imports in shared code.
- Helper methods returning widgets (`Widget _buildHeader()`); extract classes.
- Meaningless names (`temp`, `data1`, `MyWidget`, `Container1`).
- Public members without doc comments.
- Leaving `print` statements, commented-out code, or TODOs without an owner and
  a description.
- Adding dependencies to save a few lines of code.
