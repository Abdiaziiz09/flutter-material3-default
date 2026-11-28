import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/interaction/app_haptics.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_material3_default/core/theme/app_radii.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';

/// Top header navigation bar used on desktop and laptop web viewports
/// ([WindowSizeClass.expanded] and wider).
///
/// Displays the highest-priority [destinations] horizontally in the header.
/// When [destinations] exceeds [maxHeaderItems], secondary destinations
/// automatically overflow into a header dropdown menu (`More`).
class TopHeaderNavBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a top header navigation bar.
  const TopHeaderNavBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.maxHeaderItems = 5,
    this.overflowLabel = 'More',
    this.title,
    this.actions,
    super.key,
  }) : assert(
         destinations.length >= 2,
         'Navigation requires at least two destinations.',
       ),
       assert(
         selectedIndex >= 0 && selectedIndex < destinations.length,
         'selectedIndex must refer to an existing destination.',
       ),
       assert(
         maxHeaderItems >= 2,
         'maxHeaderItems must allow at least two items.',
       );

  /// All top-level destinations, ordered from highest to lowest priority.
  final List<AppDestination> destinations;

  /// Index of the currently active destination in [destinations].
  final int selectedIndex;

  /// Invoked when the user selects a destination index.
  final ValueChanged<int> onDestinationSelected;

  /// Maximum number of primary slots shown directly in the header before
  /// overflowing secondary destinations into a header dropdown menu.
  final int maxHeaderItems;

  /// Label for the header dropdown menu button when destinations overflow.
  final String overflowLabel;

  /// Optional leading title or brand widget displayed on the left side of the
  /// header.
  final Widget? title;

  /// Optional trailing action widgets displayed on the right side of the
  /// header.
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  bool get _hasOverflow => destinations.length > maxHeaderItems;

  int get _visiblePrimaryCount =>
      _hasOverflow ? maxHeaderItems - 1 : destinations.length;

  void _handleItemTap(int index) {
    unawaited(AppHaptics.selection());
    onDestinationSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryDestinations = destinations
        .take(_visiblePrimaryCount)
        .toList();
    final overflowDestinations = _hasOverflow
        ? destinations.sublist(_visiblePrimaryCount)
        : const <AppDestination>[];
    final isOverflowSelected =
        _hasOverflow && selectedIndex >= _visiblePrimaryCount;
    final titleWidget = title;
    final trailingActions = actions;

    return Material(
      color: colorScheme.surface,
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.45),
            ),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                ),
                child: Row(
                  children: [
                    if (titleWidget != null) ...[
                      titleWidget,
                      const SizedBox(width: AppSpacing.large),
                    ],
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (
                              var i = 0;
                              i < primaryDestinations.length;
                              i++
                            ) ...[
                              _HeaderNavItem(
                                label: primaryDestinations[i].label,
                                icon: primaryDestinations[i].icon,
                                selectedIcon:
                                    primaryDestinations[i].selectedIcon,
                                isSelected: selectedIndex == i,
                                onTap: () => _handleItemTap(i),
                              ),
                              if (i < primaryDestinations.length - 1 ||
                                  _hasOverflow)
                                const SizedBox(width: AppSpacing.extraSmall),
                            ],
                            if (_hasOverflow)
                              _HeaderOverflowDropdown(
                                label: overflowLabel,
                                destinations: overflowDestinations,
                                baseIndex: _visiblePrimaryCount,
                                selectedIndex: selectedIndex,
                                isSelected: isOverflowSelected,
                                onSelected: _handleItemTap,
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (trailingActions != null &&
                        trailingActions.isNotEmpty) ...[
                      const SizedBox(width: AppSpacing.medium),
                      ...trailingActions,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderNavItem extends StatelessWidget {
  const _HeaderNavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final motion = context.motion;
    final duration = motion.durationFor(context, motion.quick);

    final foregroundColor = isSelected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        borderRadius: AppRadii.borderRadiusFull,
        onTap: onTap,
        child: AnimatedContainer(
          duration: duration,
          curve: motion.emphasizedDecelerateCurve,
          constraints: const BoxConstraints(minHeight: AppSpacing.huge),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.small,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.secondaryContainer
                : Colors.transparent,
            borderRadius: AppRadii.borderRadiusFull,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                size: 20,
                color: foregroundColor,
              ),
              const SizedBox(width: AppSpacing.small),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderOverflowDropdown extends StatelessWidget {
  const _HeaderOverflowDropdown({
    required this.label,
    required this.destinations,
    required this.baseIndex,
    required this.selectedIndex,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final List<AppDestination> destinations;
  final int baseIndex;
  final int selectedIndex;
  final bool isSelected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final foregroundColor = isSelected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;

    return PopupMenuButton<int>(
      tooltip: label,
      onSelected: onSelected,
      position: PopupMenuPosition.under,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.borderRadiusMedium,
      ),
      itemBuilder: (context) => [
        for (var i = 0; i < destinations.length; i++)
          PopupMenuItem<int>(
            value: baseIndex + i,
            child: Row(
              children: [
                Icon(
                  selectedIndex == baseIndex + i
                      ? destinations[i].selectedIcon
                      : destinations[i].icon,
                  size: 20,
                  color: selectedIndex == baseIndex + i
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.small),
                Text(
                  destinations[i].label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: selectedIndex == baseIndex + i
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
      ],
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSpacing.huge),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.secondaryContainer
              : Colors.transparent,
          borderRadius: AppRadii.borderRadiusFull,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: foregroundColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            const SizedBox(width: AppSpacing.extraSmall),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: foregroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
