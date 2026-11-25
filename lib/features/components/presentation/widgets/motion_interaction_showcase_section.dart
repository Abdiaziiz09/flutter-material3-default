import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/interaction/tactile_surface.dart';
import 'package:flutter_material3_default/core/motion/contextual_switcher.dart';
import 'package:flutter_material3_default/core/motion/smooth_expandable.dart';
import 'package:flutter_material3_default/core/theme/app_radii.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/section_header.dart';

/// Demonstrates context-aware motion and tactile interaction primitives:
/// [TactileSurface], [SmoothExpandable] and [ContextualSwitcher].
class MotionInteractionShowcaseSection extends StatefulWidget {
  /// Creates the motion and interaction showcase section.
  const MotionInteractionShowcaseSection({super.key});

  @override
  State<MotionInteractionShowcaseSection> createState() =>
      _MotionInteractionShowcaseSectionState();
}

class _MotionInteractionShowcaseSectionState
    extends State<MotionInteractionShowcaseSection> {
  bool _isDetailsExpanded = false;
  int _statusStep = 0;

  static const List<({IconData icon, String label})> _statusStates = [
    (icon: Icons.edit_outlined, label: 'Draft'),
    (icon: Icons.sync_outlined, label: 'Syncing'),
    (icon: Icons.check_circle_outline, label: 'Saved'),
  ];

  void _handleToggleDetails() {
    setState(() {
      _isDetailsExpanded = !_isDetailsExpanded;
    });
  }

  void _handleAdvanceStatus() {
    setState(() {
      _statusStep = (_statusStep + 1) % _statusStates.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentStatus = _statusStates[_statusStep];
    final isReducedMotion = MediaQuery.disableAnimationsOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Motion and interaction',
          subtitle:
              'Tactile feedback and state continuity that respect reduced '
              'motion.',
        ),
        TactileSurface(
          onTap: _handleToggleDetails,
          borderRadius: AppRadii.borderRadiusMedium,
          tooltip: 'Toggle motion details',
          child: Card.outlined(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.touch_app_outlined,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: AppSpacing.medium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tactile interactive surface',
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              'Tap or press Space/Enter to expand',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _isDetailsExpanded
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                    ],
                  ),
                  SmoothExpandable(
                    isExpanded: _isDetailsExpanded,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.medium),
                      child: Text(
                        'Subtle press scaling, Material ink ripples and '
                        'smooth disclosure keep interactions grounded without '
                        'distracting motion. Reduced motion is currently '
                        '${isReducedMotion ? 'enabled' : 'disabled'}.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        Wrap(
          spacing: AppSpacing.medium,
          runSpacing: AppSpacing.small,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton.tonalIcon(
              onPressed: _handleAdvanceStatus,
              icon: const Icon(Icons.autorenew),
              label: const Text('Switch state'),
            ),
            ContextualSwitcher(
              child: Chip(
                key: ValueKey<int>(_statusStep),
                avatar: Icon(currentStatus.icon, size: 18),
                label: Text(currentStatus.label),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
