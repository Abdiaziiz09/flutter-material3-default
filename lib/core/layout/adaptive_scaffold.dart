import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/layout/floating_pill_nav_bar.dart';
import 'package:flutter_material3_default/core/layout/top_header_nav_bar.dart';
import 'package:flutter_material3_default/core/responsive/breakpoints.dart';
import 'package:flutter_material3_default/core/responsive/responsive_builder.dart';

/// Top-level scaffold that adapts navigation between mobile/narrow viewports
/// and desktop/laptop web viewports:
///
/// | Window size class                   | Navigation pattern                 |
/// | ----------------------------------- | ---------------------------------- |
/// | `compact` / `medium` (< 840 dp)     | [FloatingPillNavBar] (bottom pill) |
/// | `expanded` and up (>= 840 dp)       | [TopHeaderNavBar] (header + menu)  |
///
/// - On mobile and narrow responsive viewports, [FloatingPillNavBar] renders
///   as a floating, frosted-glass pill with `extendBody: true` so content
///   scrolls visibly underneath, overflowing excess destinations into `Menu`.
/// - On desktop, laptop, and wide web viewports, [TopHeaderNavBar] renders a
///   top header navigation bar with no bottom bar, overflowing excess
///   destinations into a header dropdown menu (`More`).
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
    this.maxPrimaryItems = 4,
    this.maxHeaderItems = 5,
    this.headerTitle,
    this.headerActions,
    super.key,
  }) : assert(
         destinations.length >= 2,
         'Navigation requires at least two destinations.',
       ),
       assert(
         selectedIndex >= 0 && selectedIndex < destinations.length,
         'selectedIndex must refer to an existing destination.',
       );

  /// Navigation destinations, ordered from highest to lowest priority.
  final List<AppDestination> destinations;

  /// Index of the currently selected destination.
  final int selectedIndex;

  /// Called with the index of the destination the user selected.
  final ValueChanged<int> onDestinationSelected;

  /// Content of the selected destination.
  final Widget body;

  /// Maximum number of primary slots shown on [FloatingPillNavBar] before
  /// overflowing secondary destinations into `Menu`.
  final int maxPrimaryItems;

  /// Maximum number of primary slots shown on [TopHeaderNavBar] before
  /// overflowing secondary destinations into the header dropdown menu.
  final int maxHeaderItems;

  /// Optional leading title or brand widget shown in [TopHeaderNavBar] on
  /// wide desktop/web viewports.
  final Widget? headerTitle;

  /// Optional trailing action widgets shown in [TopHeaderNavBar] on wide
  /// desktop/web viewports.
  final List<Widget>? headerActions;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  final GlobalKey _bodyKey = GlobalKey(debugLabel: 'AdaptiveScaffold body');

  @override
  Widget build(BuildContext context) {
    final keyedBody = KeyedSubtree(key: _bodyKey, child: widget.body);

    return ResponsiveBuilder(
      builder: (context, windowSizeClass) {
        if (windowSizeClass.isAtLeast(WindowSizeClass.expanded)) {
          return Scaffold(
            appBar: TopHeaderNavBar(
              destinations: widget.destinations,
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected,
              maxHeaderItems: widget.maxHeaderItems,
              title: widget.headerTitle,
              actions: widget.headerActions,
            ),
            body: keyedBody,
          );
        }

        return Scaffold(
          extendBody: true,
          body: keyedBody,
          bottomNavigationBar: FloatingPillNavBar(
            destinations: widget.destinations,
            selectedIndex: widget.selectedIndex,
            onDestinationSelected: widget.onDestinationSelected,
            maxPrimaryItems: widget.maxPrimaryItems,
          ),
        );
      },
    );
  }
}
