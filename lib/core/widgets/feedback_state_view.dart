import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/adaptive_content_container.dart';

/// Displays a consistent, accessible empty, error or status state.
///
/// Centres its content inside an [AdaptiveContentContainer] so it remains
/// readable on both narrow phones and wide desktop windows, and scrolls safely
/// on short landscape viewports or large text scales.
class FeedbackStateView extends StatelessWidget {
  /// Creates a feedback state view.
  const FeedbackStateView({
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.isError = false,
    super.key,
  });

  /// Illustrative icon for the state.
  final IconData icon;

  /// Short, clear summary of the state.
  final String title;

  /// Optional supporting explanation or recovery hint.
  final String? message;

  /// Optional label for the primary action button.
  final String? actionLabel;

  /// Callback invoked when the primary action button is pressed.
  final VoidCallback? onAction;

  /// Whether this view represents an error state, which uses the error colour
  /// role for the icon.
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final messageText = message;
    final buttonLabel = actionLabel;
    final actionCallback = onAction;

    return Center(
      child: SingleChildScrollView(
        child: AdaptiveContentContainer(
          maxWidth: 480,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.large),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: AppSpacing.huge,
                  color: isError
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
                const SizedBox(height: AppSpacing.medium),
                Semantics(
                  header: true,
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (messageText != null) ...[
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    messageText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (buttonLabel != null && actionCallback != null) ...[
                  const SizedBox(height: AppSpacing.large),
                  FilledButton(
                    onPressed: actionCallback,
                    child: Text(buttonLabel),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
