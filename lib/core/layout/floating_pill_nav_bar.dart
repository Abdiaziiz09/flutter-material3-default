import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/interaction/app_haptics.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_material3_default/core/theme/app_radii.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';

/// A floating, translucent, capsule-shaped bottom navigation bar.
///
/// Designed for thumb-zone ergonomics (Fitts's Law), reduced cognitive load
/// (Hick's Law), and continuous spatial depth: scrolled content passes visibly
/// behind the frosted-glass pill while the navigation controls stay crisp and
/// immediately reachable.
///
/// When [destinations] exceeds [maxPrimaryItems], the highest-priority items
/// stay directly on the pill and the remaining destinations are grouped into a
/// `Menu` button that opens an overflow sheet.
class FloatingPillNavBar extends StatelessWidget {
  /// Creates a floating pill navigation bar.
  const FloatingPillNavBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.maxPrimaryItems = 4,
    this.menuLabel = 'Menu',
    this.menuIcon = Icons.menu_rounded,
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
         maxPrimaryItems >= 2,
         'maxPrimaryItems must allow at least two items.',
       );

  /// All top-level destinations ordered from highest to lowest priority.
  final List<AppDestination> destinations;

  /// Index of the currently active destination in [destinations].
  final int selectedIndex;

  /// Invoked when the user selects a destination index.
  final ValueChanged<int> onDestinationSelected;

  /// Maximum number of slots rendered directly on the pill (including the
  /// overflow `Menu` slot when [destinations.length] exceeds this cap).
  final int maxPrimaryItems;

  /// Label shown for the overflow slot when [destinations] exceeds
  /// [maxPrimaryItems].
  final String menuLabel;

  /// Icon shown for the overflow slot.
  final IconData menuIcon;

  bool get _hasOverflow => destinations.length > maxPrimaryItems;

  int get _visiblePrimaryCount =>
      _hasOverflow ? maxPrimaryItems - 1 : destinations.length;

  void _handleItemTap(int index) {
    unawaited(AppHaptics.selection());
    onDestinationSelected(index);
  }

  Future<void> _handleMenuTap(BuildContext context) async {
    unawaited(AppHaptics.selection());
    final overflowDestinations = destinations.sublist(_visiblePrimaryCount);
    final selectedOverflowIndex = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (sheetContext) {
        return _OverflowMenuSheet(
          destinations: overflowDestinations,
          baseIndex: _visiblePrimaryCount,
          selectedIndex: selectedIndex,
        );
      },
    );

    if (selectedOverflowIndex != null) {
      unawaited(AppHaptics.lightImpact());
      onDestinationSelected(selectedOverflowIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final primaryDestinations = destinations
        .take(_visiblePrimaryCount)
        .toList();
    final isMenuSelected =
        _hasOverflow && selectedIndex >= _visiblePrimaryCount;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.medium,
          AppSpacing.small,
          AppSpacing.medium,
          AppSpacing.medium,
        ),
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: AppRadii.borderRadiusFull,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(
                      alpha: isDark ? 0.36 : 0.12,
                    ),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: AppRadii.borderRadiusFull,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow.withValues(
                        alpha: isDark ? 0.80 : 0.84,
                      ),
                      borderRadius: AppRadii.borderRadiusFull,
                      border: Border.all(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: isDark ? 0.35 : 0.45,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.extraSmall),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < primaryDestinations.length; i++)
                            Flexible(
                              child: _PillNavItem(
                                label: primaryDestinations[i].label,
                                icon: primaryDestinations[i].icon,
                                selectedIcon:
                                    primaryDestinations[i].selectedIcon,
                                isSelected: selectedIndex == i,
                                onTap: () => _handleItemTap(i),
                              ),
                            ),
                          if (_hasOverflow)
                            Flexible(
                              child: _PillNavItem(
                                label: menuLabel,
                                icon: menuIcon,
                                selectedIcon: menuIcon,
                                isSelected: isMenuSelected,
                                onTap: () => _handleMenuTap(context),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PillNavItem extends StatefulWidget {
  const _PillNavItem({
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
  State<_PillNavItem> createState() => _PillNavItemState();
}

class _PillNavItemState extends State<_PillNavItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final motion = context.motion;
    final duration = motion.durationFor(context, motion.quick);

    final activeBackground = colorScheme.secondaryContainer.withValues(
      alpha: 0.92,
    );
    final foregroundColor = widget.isSelected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: widget.isSelected,
      label: widget.label,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: duration,
        curve: motion.emphasizedDecelerateCurve,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: AppRadii.borderRadiusFull,
            onTap: widget.onTap,
            onHighlightChanged: (pressed) {
              if (_isPressed != pressed) {
                setState(() => _isPressed = pressed);
              }
            },
            child: AnimatedContainer(
              duration: duration,
              curve: motion.emphasizedDecelerateCurve,
              constraints: const BoxConstraints(
                minWidth: 64,
                minHeight: AppSpacing.huge,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.medium,
                vertical: AppSpacing.small,
              ),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? activeBackground
                    : Colors.transparent,
                borderRadius: AppRadii.borderRadiusFull,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.isSelected ? widget.selectedIcon : widget.icon,
                    size: 22,
                    color: foregroundColor,
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: foregroundColor,
                        fontWeight: widget.isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OverflowMenuSheet extends StatelessWidget {
  const _OverflowMenuSheet({
    required this.destinations,
    required this.baseIndex,
    required this.selectedIndex,
  });

  final List<AppDestination> destinations;
  final int baseIndex;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        0,
        AppSpacing.medium,
        AppSpacing.large,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.small,
              vertical: AppSpacing.small,
            ),
            child: Text('Menu', style: theme.textTheme.titleMedium),
          ),
          for (var i = 0; i < destinations.length; i++)
            ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadii.borderRadiusMedium,
              ),
              selected: selectedIndex == baseIndex + i,
              selectedTileColor: colorScheme.secondaryContainer.withValues(
                alpha: 0.45,
              ),
              leading: Icon(
                selectedIndex == baseIndex + i
                    ? destinations[i].selectedIcon
                    : destinations[i].icon,
              ),
              title: Text(destinations[i].label),
              onTap: () => Navigator.of(context).pop(baseIndex + i),
            ),
        ],
      ),
    );
  }
}
