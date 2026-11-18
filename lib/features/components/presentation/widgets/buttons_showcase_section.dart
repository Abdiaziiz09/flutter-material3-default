import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/section_header.dart';

/// Shows the Material 3 button family and when to use each button.
///
/// The buttons are not connected to real actions; their callbacks are empty so
/// that they appear enabled.
class ButtonsShowcaseSection extends StatelessWidget {
  /// Creates the buttons section.
  const ButtonsShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Buttons',
          subtitle:
              'Pick the emphasis that matches the importance of the action.',
        ),
        // Wrap moves buttons to a new line instead of overflowing.
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            FilledButton(onPressed: () {}, child: const Text('Filled')),
            FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
            ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
            TextButton(onPressed: () {}, child: const Text('Text')),
          ],
        ),
        const SizedBox(height: AppSpacing.medium),
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('With icon'),
            ),
            // Icon-only buttons always need a tooltip for accessibility.
            IconButton.filled(
              onPressed: () {},
              tooltip: 'Favourite',
              icon: const Icon(Icons.favorite_outline),
            ),
            IconButton.filledTonal(
              onPressed: () {},
              tooltip: 'Share',
              icon: const Icon(Icons.share_outlined),
            ),
            IconButton.outlined(
              onPressed: () {},
              tooltip: 'Bookmark',
              icon: const Icon(Icons.bookmark_outline),
            ),
          ],
        ),
      ],
    );
  }
}
