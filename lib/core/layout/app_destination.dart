import 'package:flutter/widgets.dart';

/// Describes one top-level navigation destination.
///
/// Ordered by priority: `AdaptiveScaffold` renders the highest-priority
/// destinations directly on `FloatingPillNavBar` and groups overflow
/// destinations into the `Menu` sheet.
@immutable
class AppDestination {
  /// Creates a navigation destination.
  const AppDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  /// Text shown for the destination. It is also the accessibility label.
  final String label;

  /// Icon shown while the destination is not selected. Use the outlined
  /// Material icon variant.
  final IconData icon;

  /// Icon shown while the destination is selected. Use the filled Material
  /// icon variant.
  final IconData selectedIcon;
}
