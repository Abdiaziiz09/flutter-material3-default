import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';

/// A filled Material 3 card that presents one highlight with an icon, a title
/// and a short description.
///
/// The card is designed for a grid cell with a bounded height: the description
/// takes the remaining space and fades out instead of overflowing.
class HighlightCard extends StatelessWidget {
  /// Creates a card for a highlight.
  const HighlightCard({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  /// Icon that illustrates the highlight.
  final IconData icon;

  /// Short title, shown on at most two lines.
  final String title;

  /// Supporting text that explains the highlight.
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: AppSpacing.small),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.extraSmall),
            Expanded(
              child: Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
