# Agent Completion Checklist

Run through this list before declaring any task finished. If a box cannot be
checked, say so explicitly in your final message and explain why.

## Material 3

- [ ] Uses `MaterialApp` with `AppTheme` and `useMaterial3: true`.
- [ ] Uses native Material 3 widgets; no Cupertino substitutes.
- [ ] **100 % Samsung Icons only**: every icon comes from a verified Samsung One UI source (`OneUIProject/oneui-icons`, `thatjoshguy67/oneui-icons`, `SamsungInternet/OneUI-Web`, or `one_uikit`); zero `Icons.*`, `CupertinoIcons.*`, or non-Samsung icons (`docs/ICONOGRAPHY.md`).
- [ ] All colours come from `Theme.of(context).colorScheme` or `context.statusColors` (`AppStatusColors`).
- [ ] All text styles come from `Theme.of(context).textTheme`.
- [ ] Spacing uses `AppSpacing`; no magic numbers.
- [ ] Looks correct in both light and dark mode.

## Responsive

- [ ] No overflow at widths 320, 400, 600, 840, 1200 and 1600.
- [ ] Layout adapts through `WindowSizeClass`, `ResponsiveBuilder`,
      `AdaptiveScaffold`, `AdaptiveContentContainer` or `ResponsiveSliverGrid`.
- [ ] Works in portrait and landscape.
- [ ] Works at 200 % text scale.
- [ ] Long content is scrollable; nothing is hard-sized to one device.

## Platforms

- [ ] No `dart:io` import in shared code.
- [ ] Works with touch, mouse and keyboard; hover and focus states are visible.
- [ ] Safe areas respected on mobile.

## Code quality

- [ ] Code is placed according to `docs/ARCHITECTURE.md`.
- [ ] Names are meaningful and follow `docs/NAMING_CONVENTIONS.md`.
- [ ] No widget-returning helper methods; widgets are classes.
- [ ] `const` is used wherever possible.
- [ ] No duplicated code, dead code, `print` calls or anonymous TODOs.
- [ ] No unnecessary dependencies were added.

## Documentation

- [ ] Every new public member has a `///` doc comment.
- [ ] Non-obvious logic has an explanatory `//` comment.
- [ ] Relevant files in `docs/` and `CHANGELOG.md` are updated.

## Accessibility

- [ ] Icon-only controls have tooltips or semantic labels.
- [ ] Touch targets are at least 48 × 48 dp.
- [ ] No information is conveyed by colour alone.

## Verification

- [ ] `dart format .` produces no changes.
- [ ] `flutter analyze` reports zero issues.
- [ ] `flutter test` passes, including tests for the new behaviour, 200 % text scale, and accessibility guidelines (`androidTapTargetGuideline`, `labeledTapTargetGuideline`, `textContrastGuideline`).
- [ ] The final message states exactly what was run and what was not.
