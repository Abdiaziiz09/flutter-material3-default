import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/responsive/breakpoints.dart';
import 'package:flutter_material3_default/core/responsive/responsive_builder.dart';

/// Top-level scaffold that picks the Material 3 navigation pattern that fits
/// the available width.
///
/// | Window size class | Navigation                |
/// | ----------------- | ------------------------- |
/// | compact           | [NavigationBar] (bottom)  |
/// | medium            | [NavigationRail]          |
/// | expanded and up   | extended [NavigationRail] |
///
/// The [body] keeps its state when the window is resized across a breakpoint,
/// for example when a phone is rotated or a desktop window is dragged wider.
///
/// ```dart
/// AdaptiveScaffold(
///   destinations: destinations,
///   selectedIndex: selectedIndex,
///   onDestinationSelected: handleDestinationSelected,
///   body: currentPage,
/// )
/// ```
class AdaptiveScaffold extends StatefulWidget {
  /// Creates an adaptive scaffold.
  ///
  /// At least two [destinations] are required, and [selectedIndex] must refer
  /// to one of them.
  const AdaptiveScaffold({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    super.key,
  }) : assert(
         destinations.length >= 2,
         'Navigation requires at least two destinations.',
       ),
       assert(
         selectedIndex >= 0 && selectedIndex < destinations.length,
         'selectedIndex must refer to an existing destination.',
       );

  /// Navigation destinations, in display order.
  final List<AppDestination> destinations;

  /// Index of the currently selected destination.
  final int selectedIndex;

  /// Called with the index of the destination the user selected.
  final ValueChanged<int> onDestinationSelected;

  /// Content of the selected destination.
  final Widget body;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  /// Width of the divider between the navigation rail and the body.
  static const double _railDividerWidth = 1;

  /// A global key lets Flutter move the body between the bottom-bar layout and
  /// the rail layout without rebuilding its state (scroll position, input...).
  final GlobalKey _bodyKey = GlobalKey(debugLabel: 'AdaptiveScaffold body');

  @override
  Widget build(BuildContext context) {
    final keyedBody = KeyedSubtree(key: _bodyKey, child: widget.body);

    return ResponsiveBuilder(
      builder: (context, windowSizeClass) {
        if (windowSizeClass == WindowSizeClass.compact) {
          return Scaffold(
            body: keyedBody,
            bottomNavigationBar: NavigationBar(
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected,
              destinations: [
                for (final destination in widget.destinations)
                  NavigationDestination(
                    icon: Icon(destination.icon),
                    selectedIcon: Icon(destination.selectedIcon),
                    label: destination.label,
                  ),
              ],
            ),
          );
        }

        final isRailExtended = windowSizeClass.isAtLeast(
          WindowSizeClass.expanded,
        );

        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: widget.selectedIndex,
                onDestinationSelected: widget.onDestinationSelected,
                extended: isRailExtended,
                // An extended rail always shows labels beside the icons, so its
                // label type must be `none`.
                labelType: isRailExtended
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.selected,
                destinations: [
                  for (final destination in widget.destinations)
                    NavigationRailDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: Text(destination.label),
                    ),
                ],
              ),
              const VerticalDivider(
                width: _railDividerWidth,
                thickness: _railDividerWidth,
              ),
              Expanded(child: keyedBody),
            ],
          ),
        );
      },
    );
  }
}
