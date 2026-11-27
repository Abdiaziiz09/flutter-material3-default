# Iconography — Samsung Icons (One UI) Standard

> **100 % MANDATORY RULE:** Every icon in any application built from this
> design system **must** be a **Samsung Icon (One UI Icon)**. Using icons from
> any other icon set (including Flutter's built-in `Icons.*` / Material Icons,
> `CupertinoIcons.*`, FontAwesome, Lucide, Feather, or improvised/guessed icons)
> is **strictly forbidden**.

---

## 1. Visual language

Samsung One UI icons share a distinct, cohesive visual grammar across every
surface (navigation bars, menus, bottom sheets, app bars, settings lists, and
in-app actions):

- **Softly rounded geometry**: Corners on boxes, shields, speech bubbles,
  calendars, clocks, locks, and cards are smoothly rounded rather than sharp.
- **Unselected / default state (outlined)**: Uniform medium stroke weight
  (~1.75–2 dp on a 24 × 24 dp grid) with `stroke-linecap="round"` and
  `stroke-linejoin="round"`.
- **Selected / active state (filled)**: Solid filled rounded silhouette for
  active navigation bar destinations and selected toggles, tinted with
  `Theme.of(context).colorScheme.primary` (or `onSecondaryContainer` inside
  selected pill indicators).
- **Theme-aware colouring**: Icons never hard-code colours; they inherit
  `IconTheme.of(context).color` or read from `Theme.of(context).colorScheme` /
  `context.statusColors`.

---

## 2. Verified sources for Samsung Icons

AI coding agents must **never** guess, approximate, or invent icons, and must
**never** fall back to `Icons.*`. Always retrieve the exact Samsung One UI
icon asset from one of these verified sources:

| Priority | Source | What it provides | Location |
| -------- | ------ | ---------------- | -------- |
| 1 | **OneUIProject / oneui-icons** | 880+ official Samsung One UI system icons (`ic_oui_*`) extracted from Samsung apps (Android Vector Drawable `.xml`) | `https://github.com/OneUIProject/oneui-icons` |
| 2 | **thatjoshguy67 / oneui-icons** | 973+ Samsung One UI icons in SVG/component form | `https://github.com/thatjoshguy67/oneui-icons` |
| 3 | **SamsungInternet / OneUI-Web** | Official Samsung One UI Web icon assets (`oui-css/icons`) | `https://github.com/SamsungInternet/OneUI-Web` |
| 4 | **one_uikit (pub.dev)** | Flutter UI kit containing categorised One UI SVG icon assets | `https://pub.dev/packages/one_uikit` |

### Search & fallback protocol

1. Search `OneUIProject/oneui-icons` (prefix `ic_oui_`) or
   `thatjoshguy67/oneui-icons` by semantic keyword (for example: `home`,
   `settings`, `search`, `time`, `lock`, `bookmark`, `video`, `group`,
   `bell`, `person`, `edit`, `share`, `delete`, `add`).
2. If not found there, check `SamsungInternet/OneUI-Web` (`oui-css/icons`) or
   `one_uikit`.
3. **If an icon does not exist in any verified Samsung One UI source:** stop
   and ask the user to provide or approve the exact Samsung SVG asset. **Never**
   substitute `Icons.*`, `CupertinoIcons.*`, or any non-Samsung icon.

---

## 3. How to integrate Samsung Icons in Flutter

### Option A — Custom TTF Icon Font (Recommended for zero-dependency / high performance)

1. Collect the required Samsung One UI `.svg` files (convert `.xml` vector
   drawables from `OneUIProject/oneui-icons` to `.svg` if needed).
2. Compile them into a `.ttf` icon font using `fantasticon` (or IcoMoon):

   ```bash
   npm i -g fantasticon
   fantasticon ./assets/icons/samsung_svg -o ./assets/fonts --name samsung_oneui_icons
   ```

3. Register the font in `pubspec.yaml`:

   ```yaml
   flutter:
     fonts:
       - family: SamsungOneUIIcons
         fonts:
           - asset: assets/fonts/samsung_oneui_icons.ttf
   ```

4. Expose every icon through a typed `AppIcons` class in
   `lib/core/theme/app_icons.dart`:

   ```dart
   import 'package:flutter/widgets.dart';

   /// Typed Samsung One UI icon constants backed by the bundled
   /// `SamsungOneUIIcons` font.
   abstract final class AppIcons {
     static const String _fontFamily = 'SamsungOneUIIcons';

     /// Outlined home icon for unselected navigation items.
     static const IconData home = IconData(0xe900, fontFamily: _fontFamily);

     /// Filled home icon for the active navigation destination.
     static const IconData homeFilled = IconData(0xe901, fontFamily: _fontFamily);
   }
   ```

### Option B — Direct SVG Assets

1. Place the verified Samsung One UI `.svg` files in `assets/icons/samsung/`
   (for example `assets/icons/samsung/ic_oui_home.svg`).
2. Register `assets/icons/samsung/` in `pubspec.yaml` under `flutter: assets:`.
3. Render them through a reusable `AppSvgIcon` wrapper in `lib/core/widgets/`
   that automatically applies `IconTheme.of(context).color` and `size` so
   icons adapt seamlessly to light and dark themes.

---

## 4. Accessibility & invisible foundation rules

- **Touch targets**: Every interactive icon button must have a minimum
  **48 × 48 dp** touch target (`IconButton`, `TactileSurface`, etc.).
- **Labels**: Every icon-only control must have a `tooltip` or
  `semanticLabel` describing the product action (never the icon set name).
- **Invisible foundation**: Never mention "Samsung Icons", "One UI", or the
  design system in any visible UI copy, label, badge, or tooltip.
