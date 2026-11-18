# Documentation Standards

Code is read far more often than it is written. Meaningful comments make the
codebase understandable to the next developer and to the next AI agent.

## Doc comments (`///`)

Required on **every public** class, enum, extension, mixin, function, method,
field, constant and constructor with non-obvious behaviour. The
`public_member_api_docs` lint enforces this for `lib/`.

Rules:

1. Start with a single-sentence summary that ends in a period.
2. Explain **what** it is for and **why** it exists, not just a restatement of
   the name.
3. Document parameters, return values and thrown errors when they are not
   obvious, using prose (Dart does not use `@param`).
4. Reference other symbols with square brackets: `[WindowSizeClass]`.
5. Add a short code example for APIs that are not self-explanatory.

```dart
/// Chooses the navigation pattern for the current window width.
///
/// Compact windows show a [NavigationBar], medium windows show a
/// [NavigationRail] and larger windows show an extended [NavigationRail].
/// This follows the Material 3 adaptive navigation guidance.
///
/// ```dart
/// AdaptiveScaffold(
///   destinations: destinations,
///   selectedIndex: selectedIndex,
///   onDestinationSelected: handleSelection,
///   body: currentPage,
/// )
/// ```
class AdaptiveScaffold extends StatelessWidget {
```

## Implementation comments (`//`)

Use them inside function bodies to explain:

- non-obvious logic or workarounds, and the reason for them;
- why one approach was chosen over a more obvious one;
- constraints (platform limitations, Flutter issues, accessibility needs).

Do not narrate trivial code.

```dart
// Extended rails cannot show labels below icons, so labelType must be none.
labelType: isExtended ? NavigationRailLabelType.none : NavigationRailLabelType.selected,
```

## Good and bad

| Bad | Good |
| --- | ---- |
| `/// The width.` | `/// Maximum content width in logical pixels before the layout stops growing.` |
| `// increment i` | `// Skip the header row, which is rendered separately.` |
| Commented-out code | Delete it; Git keeps history. |

## TODO comments

Format: `// TODO(owner): Description and, if possible, an issue link.` Do not
leave anonymous TODOs.

## File-level documentation

Start each non-trivial file with a library-level doc comment describing its
purpose when the file contains more than one related declaration.

## Markdown docs

- Keep `docs/` accurate: update the relevant document in the same change as the
  code.
- Use relative links between documents.
- Use fenced code blocks with a language tag.
