# Design Tokens

Design tokens are the single source of truth for visual styling, spacing,
shape, responsiveness and motion. Never hard-code raw hex colours, font sizes,
corner radii, spacing numbers or animation durations in feature code.

## 1. Colour (`ColorScheme`)

Defined in `lib/core/theme/app_theme.dart` via `ColorScheme.fromSeed`. Read
roles from `Theme.of(context).colorScheme`:

- Primary actions: `primary` / `onPrimary`
- Secondary / tonal surfaces: `secondaryContainer` / `onSecondaryContainer`
- Accent / supporting highlights: `tertiaryContainer` / `onTertiaryContainer`
- Backgrounds & cards: `surface`, `surfaceContainer`, `surfaceContainerHigh`
- Text & icons on surfaces: `onSurface`, `onSurfaceVariant`
- Outlines & dividers: `outline`, `outlineVariant`
- Errors: `error` / `onError`, `errorContainer` / `onErrorContainer`

For **success**, **warning**, and **info** states (which Material 3's
`ColorScheme` does not include), use `context.statusColors` (`AppStatusColors`
in `lib/core/theme/app_status_colors.dart`), which provides contrast-paired
light and dark tokens (`success`, `onSuccess`, `successContainer`, etc.).

## 2. Typography (`TextTheme`)

Read styles from `Theme.of(context).textTheme` (`headlineMedium`, `titleLarge`,
`titleMedium`, `bodyLarge`, `bodyMedium`, `bodySmall`, `labelLarge`). Customise
with `.copyWith(color: ...)` only.

## 3. Spacing (`AppSpacing`)

Defined in `lib/core/theme/app_spacing.dart` on a 4 dp baseline grid:

| Token | Value | Typical Use |
| ----- | ----- | ----------- |
| `extraSmall` | `4 dp` | Tight gaps (title to subtitle) |
| `small` | `8 dp` | Related elements (chips, buttons) |
| `medium` | `16 dp` | Default card padding, component gaps |
| `large` | `24 dp` | Gaps between component groups |
| `extraLarge` | `32 dp` | Gaps between major page sections |
| `huge` | `48 dp` | Large illustrative icons, min touch target |

## 4. Shape & Corner Radii (`AppRadii`)

Defined in `lib/core/theme/app_radii.dart`:

| Token | Value | Typical Use |
| ----- | ----- | ----------- |
| `none` | `0 dp` | Full-bleed surfaces, dividers |
| `extraSmall` | `4 dp` | Badges, compact indicators |
| `small` | `8 dp` | Chips, compact buttons, dense list items |
| `medium` | `12 dp` | Default cards, input containers, `TactileSurface` |
| `large` | `16 dp` | Prominent cards, drawers, floating panels |
| `extraLarge` | `28 dp` | Dialogs, bottom sheets |
| `full` | `9999 dp` | Pills, circular controls |

## 5. Motion (`AppMotion`)

Defined in `lib/core/theme/app_motion.dart` and registered as a `ThemeExtension`
on `ThemeData`. Access via `context.motion`. See
[`MOTION_AND_INTERACTION.md`](MOTION_AND_INTERACTION.md) for timing, curves and
reduced-motion resolution.

## 6. Breakpoints (`WindowSizeClass`)

Defined in `lib/core/responsive/breakpoints.dart`:

- `compact`: `0 – 599 dp` (margin `16 dp`)
- `medium`: `600 – 839 dp` (margin `24 dp`)
- `expanded`: `840 – 1199 dp` (margin `24 dp`)
- `large`: `1200 – 1599 dp` (margin `32 dp`)
- `extraLarge`: `1600+ dp` (margin `32 dp`)
