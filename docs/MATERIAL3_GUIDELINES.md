# Material 3 Guidelines

Flutter's official Material 3 design system is the default for every screen on
every platform. This guide explains how to apply it correctly.

## Enabling Material 3

`AppTheme` builds both themes with `useMaterial3: true` and a
`ColorScheme.fromSeed`. Never disable Material 3 and never build a `ThemeData`
outside `AppTheme`.

```dart
MaterialApp(
  theme: AppTheme.light(),
  darkTheme: AppTheme.dark(),
  themeMode: themeController.themeMode,
);
```

## Colour

- Read colours from `Theme.of(context).colorScheme`.
- Pick roles by meaning, not by look:

  | Need | Role |
  | ---- | ---- |
  | Primary actions, key components | `primary` / `onPrimary` |
  | Less prominent actions, tonal surfaces | `secondaryContainer` / `onSecondaryContainer` |
  | Accents and supporting content | `tertiaryContainer` / `onTertiaryContainer` |
  | Page background | `surface` |
  | Cards and raised sections | `surfaceContainer`, `surfaceContainerHigh` |
  | Errors | `error` / `errorContainer` |
  | Dividers and outlines | `outline` / `outlineVariant` |

- Always pair a container colour with its matching `on...` colour for content.
- To change the brand colour, edit the seed in `AppTheme`. Do not recolour
  widgets individually.

## Typography

Use the Material 3 type scale through `Theme.of(context).textTheme`:

| Use | Style |
| --- | ----- |
| Screen title | `headlineMedium` / `headlineSmall` |
| Section title | `titleLarge` / `titleMedium` |
| Body text | `bodyLarge` / `bodyMedium` |
| Captions and metadata | `bodySmall` / `labelMedium` |
| Buttons and chips | `labelLarge` (applied by the widgets) |

Customise with `copyWith(color: ...)` using colour scheme roles. Never hard-code
`fontSize`.

## Components

Prefer the native Material 3 widget for each job:

| Job | Widget |
| --- | ------ |
| Main action in a group | `FilledButton` |
| Secondary action | `FilledButton.tonal` or `OutlinedButton` |
| Low emphasis action | `TextButton` |
| Floating primary action | `FloatingActionButton` / `.extended` |
| Top-level navigation | `NavigationBar`, `NavigationRail`, `NavigationDrawer` |
| Choose one of few options | `SegmentedButton` |
| Filters and tags | `FilterChip`, `ChoiceChip`, `InputChip` |
| Grouped content | `Card` (`Card.filled`, `Card.outlined`) |
| Search | `SearchBar` / `SearchAnchor` |
| Choose from a list | `DropdownMenu` |
| Transient feedback | `SnackBar` |
| Blocking decision | `AlertDialog` |

## Shape, elevation and motion

- Keep Material 3 default shapes and elevations; they are tuned per component.
- Surface tint and tonal elevation come from the colour scheme; do not add
  manual shadows to imitate elevation.
- Use the default page transitions and component animations. If you add custom
  animations, use `Curves.easeInOutCubicEmphasized` and durations between
  200 ms and 500 ms.

## Layout

- Use the spacing scale in `AppSpacing`. It follows a 4 dp grid.
- Page margins and gutters adapt by window size class (see
  [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md)).
- Use canonical adaptive layouts: `ListDetailLayout`, supporting pane, and
  context-appropriate scroll views (`CustomScrollView` with `SliverAppBar` /
  `SliverPersistentHeader` when scroll choreography adds clarity, or standard
  `ListView` / `SingleChildScrollView` for focused tasks).

## Dark mode

Every screen must be reviewed in light and dark. Because all colours come from
the colour scheme, this works automatically as long as no colour is hard-coded.
