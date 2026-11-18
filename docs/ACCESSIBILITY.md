# Accessibility

Accessibility is part of the definition of done. Material 3 components are
accessible by default; these rules keep them that way.

## Requirements

| Area | Requirement |
| ---- | ----------- |
| Touch targets | At least 48 × 48 dp. Use the default `IconButton` and button sizes. |
| Labels | Every icon-only control has a `tooltip` (or `Semantics` label). Decorative images use `excludeFromSemantics`. |
| Contrast | Use colour scheme roles in matching pairs (`primary` with `onPrimary`). Never place custom colours on arbitrary backgrounds. |
| Meaning | Never convey information by colour alone; add text or an icon. |
| Text scaling | Layouts stay usable at 200 % text scale. Avoid fixed-height text containers. |
| Focus | Keyboard focus is visible and the traversal order is logical. |
| Motion | Respect `MediaQuery.disableAnimationsOf(context)` for non-essential animations. |
| Screen readers | Use meaningful semantics; group related elements with `MergeSemantics`; announce important state changes. |
| Forms | Every `TextField` has a `labelText`; show errors with `errorText`. |

## Practices

- Prefer built-in Material widgets: they ship with correct semantics, focus and
  keyboard behaviour.
- Test with TalkBack (Android), VoiceOver (iOS and macOS), NVDA or Narrator
  (Windows) and a keyboard only.
- Verify with `flutter test` using `tester.ensureSemantics()` and the
  `meetsGuideline` matchers:

  ```dart
  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  await expectLater(tester, meetsGuideline(textContrastGuideline));
  ```
