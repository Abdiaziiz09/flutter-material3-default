# Architecture

This document describes how the codebase is organised and the rules that keep
it scalable. Every application built from this foundation follows it.

## Principles

- **Feature-first.** Code is grouped by what it does for the user, not by
  technical type. Each feature is self-contained.
- **Core is generic.** `lib/core/` holds building blocks that are independent of
  any feature and could be reused in another app.
- **Dependencies point inward.** `features/` may import `core/`; `core/` never
  imports `features/` or `app/`. Features never import each other. Only `app/`
  imports from both, because it connects features (routes and navigation).
- **Simple until proven otherwise.** Add a layer or a package only when the app
  needs it.

## Directory layout

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   └── shell/
│       ├── app_shell_page.dart
│       └── not_found_page.dart
├── core/
│   ├── constants/app_constants.dart
│   ├── interaction/
│   │   ├── app_haptics.dart
│   │   ├── keyboard_shortcuts.dart
│   │   └── tactile_surface.dart
│   ├── layout/
│   │   ├── adaptive_scaffold.dart
│   │   ├── app_destination.dart
│   │   └── list_detail_layout.dart
│   ├── motion/
│   │   ├── contextual_switcher.dart
│   │   ├── motion_priority.dart
│   │   └── smooth_expandable.dart
│   ├── platform/
│   │   ├── app_platform.dart
│   │   └── app_scroll_behavior.dart
│   ├── responsive/
│   │   ├── breakpoints.dart
│   │   ├── responsive_builder.dart
│   │   └── responsive_context_extension.dart
│   ├── storage/
│   │   └── key_value_store.dart
│   ├── theme/
│   │   ├── app_motion.dart
│   │   ├── app_radii.dart
│   │   ├── app_spacing.dart
│   │   ├── app_status_colors.dart
│   │   ├── app_theme.dart
│   │   └── theme_controller.dart
│   └── widgets/
│       ├── adaptive_content_container.dart
│       ├── app_feedback.dart
│       ├── feedback_state_view.dart
│       ├── paginated_sliver_list.dart
│       ├── responsive_sliver_grid.dart
│       ├── section_header.dart
│       └── skeleton_box.dart
└── features/
    └── <feature>/
        ├── data/            (optional)
        ├── domain/          (optional)
        └── presentation/
            ├── pages/
            └── widgets/
```

## Layers inside a feature

| Layer | Contains | Depends on |
| ----- | -------- | ---------- |
| `presentation` | Pages, widgets, view state | `domain`, `core` |
| `domain` | Entities, repository interfaces, use cases | nothing Flutter-specific |
| `data` | Repository implementations, API clients, DTOs | `domain` |

A purely visual feature (like the samples in this repository) only needs
`presentation`.

## Application flow

1. `main.dart` calls `runApp` with `MaterialDefaultApp`.
2. `MaterialDefaultApp` owns the `ThemeController`, exposes it through
   `ThemeScope`, and builds `MaterialApp` with the light and dark Material 3
   themes from `AppTheme`.
3. `AppRouter` maps route names to pages.
4. `AppShellPage` hosts the top-level destinations inside `AdaptiveScaffold`,
   which picks the navigation pattern from the current window size class.

## State management

The foundation intentionally uses only Flutter's built-in primitives:

- `ChangeNotifier` / `ValueNotifier` for observable state.
- `ListenableBuilder` / `InheritedNotifier` to rebuild and to share state down
  the tree (see `ThemeScope`).

When an application outgrows this, choose **one** established solution
(Riverpod, Bloc or Provider), apply it consistently, and record the decision in
the "Decisions" section below.

## Navigation

Named routes with `onGenerateRoute`. Adopt `go_router` when you need deep
linking, URL-driven state or nested navigation on web and desktop, and record
the decision below.

## Decisions

Record significant architectural decisions here, newest first, using the format
`YYYY-MM-DD — Decision — Reason`.

- 2026-11-18 — Zero third-party runtime dependencies — Keeps the foundation
  easy to audit, always compatible with new Flutter releases and quick to build
  on every platform.
