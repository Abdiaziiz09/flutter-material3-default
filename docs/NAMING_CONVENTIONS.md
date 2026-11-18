# Naming Conventions

Names are the first documentation a reader sees. Every identifier must clearly
communicate its purpose and responsibility. Follow
[Effective Dart](https://dart.dev/effective-dart/style) plus the rules below.

## Casing

| Element | Style | Example |
| ------- | ----- | ------- |
| Files and folders | `snake_case` | `adaptive_scaffold.dart` |
| Classes, enums, extensions, typedefs | `UpperCamelCase` | `AdaptiveScaffold` |
| Variables, parameters, fields, methods | `lowerCamelCase` | `selectedDestinationIndex` |
| Constants | `lowerCamelCase` | `maxContentWidth` |
| Private members | leading underscore | `_handleDestinationSelected` |
| Packages | `snake_case` | `flutter_material3_default` |

## Purpose over type

| Avoid | Prefer |
| ----- | ------ |
| `idx`, `i2`, `n` | `selectedDestinationIndex` |
| `data`, `info`, `temp` | `userProfile`, `weatherForecast` |
| `MyWidget`, `Screen1` | `OrderSummaryPage` |
| `list` | `recentOrders` |
| `flag` | `isExpanded` |

## Widgets

- Name widgets by role with a suffix: `Page`, `Card`, `Tile`, `Section`,
  `Header`, `Scaffold`, `Button`, `Dialog`, `Sheet`.
- A full screen ends with `Page` and lives in `presentation/pages/`.
- A private widget used by one file starts with an underscore:
  `_FeatureHighlightCard`.
- Do not name widgets after their implementation (`ColumnWithPadding`).
  Name them after what they show (`ProfileSummary`).

## Members

- **Booleans** read as yes/no questions: `isLoading`, `hasUnreadMessages`,
  `shouldShowLabels`, `canSubmit`.
- **Methods** start with a verb: `loadProfile`, `showDeleteDialog`,
  `calculateTotal`.
- **Callbacks** passed to widgets start with `on` and use the past or
  present participle of the event: `onPressed`, `onDestinationSelected`,
  `onThemeModeChanged`.
- **Handlers** inside a `State` start with `_handle`:
  `_handleDestinationSelected`.
- **Builders** passed to widgets end with `Builder`: `itemBuilder`.
- **Streams and futures** describe the data, not the mechanism:
  `profileUpdates`, not `profileStream`.

## Types

- Enums are singular: `WindowSizeClass`, `ThemeMode`.
- Enum values describe the case: `compact`, `medium`, `expanded`.
- Extensions end with `Extension`: `ResponsiveContextExtension`.
- Avoid abbreviations except universally understood ones (`id`, `url`, `ui`).
  Abbreviations of two or more letters follow normal casing: `HttpClient`,
  `userId`.

## Files

- One public top-level class per file, with the file named after the class.
- Tests mirror the source path and end with `_test.dart`.
