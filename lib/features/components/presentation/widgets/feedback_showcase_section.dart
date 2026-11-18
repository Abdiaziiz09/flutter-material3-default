import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/section_header.dart';

/// Shows Material 3 containers and feedback components: cards, progress
/// indicators, a badge, a snack bar and a dialog.
class FeedbackShowcaseSection extends StatelessWidget {
  /// Creates the feedback section.
  const FeedbackShowcaseSection({super.key});

  void _handleShowSnackBarPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This is a Material 3 snack bar')),
    );
  }

  Future<void> _handleShowDialogPressed(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Material 3 dialog'),
          content: const Text(
            'Dialogs interrupt the user for an important decision. Keep the '
            'text short and the actions clear.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Cards and feedback',
          subtitle: 'Cards group content; feedback keeps people informed.',
        ),
        // Material 3 offers three card styles: filled, elevated and outlined.
        const Card.filled(
          child: ListTile(
            leading: Icon(Icons.layers_outlined),
            title: Text('Filled card'),
            subtitle: Text('Lowest emphasis, no shadow'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.layers),
            title: Text('Elevated card'),
            subtitle: Text('Uses tonal elevation'),
          ),
        ),
        const Card.outlined(
          child: ListTile(
            leading: Icon(Icons.layers_outlined),
            title: Text('Outlined card'),
            subtitle: Text('Separated by an outline'),
          ),
        ),
        const SizedBox(height: AppSpacing.large),
        Wrap(
          spacing: AppSpacing.large,
          runSpacing: AppSpacing.medium,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Badge(
              label: Text('3'),
              child: Icon(Icons.mail_outlined),
            ),
            // Determinate indicators do not animate, which keeps tests stable.
            const CircularProgressIndicator(value: 0.6),
            Text('60% complete', style: theme.textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSpacing.medium),
        const LinearProgressIndicator(value: 0.6),
        const SizedBox(height: AppSpacing.large),
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            FilledButton.tonal(
              onPressed: () => _handleShowSnackBarPressed(context),
              child: const Text('Show snack bar'),
            ),
            OutlinedButton(
              onPressed: () => _handleShowDialogPressed(context),
              child: const Text('Show dialog'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.extraLarge),
      ],
    );
  }
}
