import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Attaches common keyboard shortcuts (such as `Escape` to dismiss or cancel,
/// and `Ctrl+Enter` / `Cmd+Enter` to submit) to a subtree.
///
/// Keeps desktop and web workflows fast without duplicating `Shortcuts` and
/// `Actions` boilerplate in feature widgets.
class AppShortcuts extends StatelessWidget {
  /// Creates a keyboard shortcut wrapper around [child].
  const AppShortcuts({
    required this.child,
    this.onDismiss,
    this.onPrimarySubmit,
    super.key,
  });

  /// The widget subtree that receives these shortcuts while focused.
  final Widget child;

  /// Called when the user presses `Escape`.
  final VoidCallback? onDismiss;

  /// Called when the user presses `Ctrl+Enter` (Windows/Linux) or
  /// `Cmd+Enter` (macOS).
  final VoidCallback? onPrimarySubmit;

  @override
  Widget build(BuildContext context) {
    final bindings = <ShortcutActivator, VoidCallback>{
      const SingleActivator(LogicalKeyboardKey.escape): ?onDismiss,
      const SingleActivator(LogicalKeyboardKey.enter, control: true):
          ?onPrimarySubmit,
      const SingleActivator(LogicalKeyboardKey.enter, meta: true):
          ?onPrimarySubmit,
    };

    if (bindings.isEmpty) {
      return child;
    }

    return CallbackShortcuts(bindings: bindings, child: child);
  }
}
