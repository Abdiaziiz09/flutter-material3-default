# Responsive Design

Every screen and component must adapt to any screen size, resolution and
orientation. This guide defines the breakpoints and the patterns to use.

## Window size classes

The foundation follows the Material 3 adaptive breakpoints, implemented by
`WindowSizeClass` in `lib/core/responsive/breakpoints.dart`.

| Class | Width (dp) | Typical devices | Navigation | Page margin | Grid columns hint |
| ----- | ---------- | --------------- | ---------- | ----------- | ----------------- |
| `compact` | 0 – 599 | Phones in portrait | `NavigationBar` | 16 | 1 – 2 |
| `medium` | 600 – 839 | Tablets, foldables, phones in landscape | `NavigationRail` | 24 | 2 – 3 |
| `expanded` | 840 – 1199 | Large tablets, small windows | Extended `NavigationRail` | 24 | 3 – 4 |
| `large` | 1200 – 1599 | Desktop windows | Extended `NavigationRail` | 32 | 4+ |
| `extraLarge` | 1600+ | Wide monitors | Extended `NavigationRail` | 32 | 4+ with a content max width |

Design for the **smallest** class first, then enhance for larger ones.

## Tools provided

| Tool | Use it for |
| ---- | ---------- |
| `WindowSizeClass.fromWidth(width)` | Classifying a width (pure, testable). |
| `context.windowSizeClass` | The class for the whole window (uses `MediaQuery.sizeOf`). |
| `ResponsiveBuilder` | Choosing a layout from the width of its **own** constraints (use inside panes and cards). |
| `AdaptiveScaffold` | Top-level navigation that switches bar / rail / extended rail. |
| `AdaptiveContentContainer` | Centring content with a maximum width and responsive page margins. |
| `ResponsiveSliverGrid` | Card grids whose column count follows the available width. |
| `AppSpacing` | The spacing scale. |

## Rules

1. **No fixed layouts.** Never size a screen with literal pixel widths. Use
   flexible widgets and constraints.
2. **Prefer constraints over device checks.** `LayoutBuilder` /
   `ResponsiveBuilder` respond to the space actually available, which also
   handles split-screen, resizable desktop windows and foldables.
3. **Avoid overflow.** Make content scrollable; use `Wrap`, `Flexible`,
   `Expanded`, `Text` with `overflow` and `maxLines` where truncation is
   acceptable.
4. **Limit line length.** Body text should stay at roughly 45–90 characters per
   line. Use `AdaptiveContentContainer` for this.
5. **Adapt, do not just scale.** On larger windows, use extra space for
   additional panes (list and detail side by side), not for bigger buttons.
6. **Handle orientation.** Landscape phones fall in `medium` width; make sure
   vertical space is still enough (scrollable bodies, no fixed-height stacks).
7. **Respect text scale.** Layouts must hold at 200 % text scale.
8. **Respect insets.** Use `SafeArea` and avoid placing controls under system
   bars, notches or the on-screen keyboard.

## Pattern: choose a layout by window size class

```dart
ResponsiveBuilder(
  builder: (context, windowSizeClass) {
    return switch (windowSizeClass) {
      WindowSizeClass.compact => const _SingleColumnLayout(),
      WindowSizeClass.medium => const _TwoColumnLayout(),
      _ => const _ListDetailLayout(),
    };
  },
);
```

## Pattern: page with responsive content

```dart
CustomScrollView(
  slivers: [
    AdaptiveContentContainer.sliver(
      child: const SectionHeader(title: 'Overview'),
    ),
    ResponsiveSliverGrid(
      itemCount: items.length,
      itemBuilder: (context, index) => ItemCard(item: items[index]),
    ),
  ],
);
```

## Verification checklist

Check each screen at widths 320, 400, 600, 840, 1200 and 1600, in portrait and
landscape, in light and dark mode, at text scale 1.0 and 2.0. In widget tests,
simulate sizes with `tester.view.physicalSize` and assert that
`tester.takeException()` is `null`.
