import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';

/// Title (and optional subtitle) that introduces a group of content.
///
/// The title is exposed to screen readers as a heading so users can navigate
/// between sections.
class SectionHeader extends StatelessWidget {
  /// Creates a section header with a [title] and an optional [subtitle].
  const SectionHeader({required this.title, this.subtitle, super.key});

  /// Heading text.
  final String title;

  /// Optional supporting text shown below the [title].
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitleText = subtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: theme.textTheme.titleLarge),
          ),
          if (subtitleText != null) ...[
            const SizedBox(height: AppSpacing.extraSmall),
            Text(
              subtitleText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
