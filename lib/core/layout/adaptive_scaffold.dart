import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/layout/floating_pill_nav_bar.dart';

/// Top-level scaffold that renders the mandatory floating frosted-glass pill
/// bottom navigation bar ([FloatingPillNavBar]) across **all** screen sizes
/// and platforms (mobile, tablet, web, and desktop).
///
/// The [body] extends behind the floating pill (`extendBody: true`) so scrolled
/// content passes smoothly underneath the translucent bar, while scrollable
/// widgets automatically receive bottom clearance at the end of their scroll
/// range.
///
/// When [destinations] exceeds [maxPrimaryItems], the highest-priority
/// destinations remain on the floating pill and the remaining destinations are
/// grouped into the `Menu` overflow sheet.
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

  /// Maximum number of primary slots shown directly on the floating pill
  /// before overflowing secondary destinations into `Menu`.
  final int maxPrimaryItems;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  final GlobalKey _bodyKey = GlobalKey(debugLabel: 'AdaptiveScaffold body');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: KeyedSubtree(key: _bodyKey, child: widget.body),
      bottomNavigationBar: FloatingPillNavBar(
        destinations: widget.destinations,
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: widget.onDestinationSelected,
        maxPrimaryItems: widget.maxPrimaryItems,
      ),
    );
  }
}
