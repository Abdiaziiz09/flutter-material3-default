import 'package:flutter/material.dart';

/// Convenience helpers for non-blocking transient feedback (`SnackBar`).
///
/// Encourages forgiving workflows: perform reversible actions immediately and
/// offer an Undo action via [showUndoSnackBar] instead of interrupting the user
/// with confirmation dialogs.
abstract final class AppFeedback {
  /// Default duration for transient feedback messages.
  static const Duration defaultDuration = Duration(seconds: 4);

  /// Shows a standard [SnackBar] message, replacing any currently visible bar
  /// so rapid actions never queue stale notifications.
  static void showMessage(
    BuildContext context,
    String message, {
    Duration duration = defaultDuration,
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), duration: duration));
  }

  /// Shows a [SnackBar] with an Undo action for reversible operations.
  static void showUndoSnackBar(
    BuildContext context, {
    required String message,
    required VoidCallback onUndo,
    String undoLabel = 'Undo',
    Duration duration = defaultDuration,
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          action: SnackBarAction(label: undoLabel, onPressed: onUndo),
        ),
      );
  }
}
