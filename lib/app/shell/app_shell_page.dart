import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/adaptive_scaffold.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/features/components/presentation/pages/components_page.dart';
import 'package:flutter_material3_default/features/home/presentation/pages/home_page.dart';
import 'package:flutter_material3_default/features/settings/presentation/pages/settings_page.dart';

/// Hosts the top-level destinations inside an [AdaptiveScaffold].
///
/// This is the composition root for navigation: it is the only place that
/// connects features together. To add a top-level destination, add an entry to
/// both [_destinations] and [_pages] (the lists must stay in the same order).
class AppShellPage extends StatefulWidget {
  /// Creates the navigation shell, optionally starting at
  /// [initialDestinationIndex].
  const AppShellPage({this.initialDestinationIndex = 0, super.key})
    : assert(
        initialDestinationIndex >= 0 && initialDestinationIndex < 3,
        'initialDestinationIndex must refer to a valid destination.',
      );

  /// Initial destination selected when the shell is first built.
  final int initialDestinationIndex;

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
  static const List<AppDestination> _destinations = [
    AppDestination(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    AppDestination(
      label: 'Components',
      icon: Icons.widgets_outlined,
      selectedIcon: Icons.widgets,
    ),
    AppDestination(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];

  static const List<Widget> _pages = [
    HomePage(),
    ComponentsPage(),
    SettingsPage(),
  ];

  late int _selectedDestinationIndex = widget.initialDestinationIndex;

  void _handleDestinationSelected(int newDestinationIndex) {
    setState(() {
      _selectedDestinationIndex = newDestinationIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      destinations: _destinations,
      selectedIndex: _selectedDestinationIndex,
      onDestinationSelected: _handleDestinationSelected,
      // Only the selected page is built. Each page restores its scroll position
      // through a PageStorageKey, and building one page at a time avoids
      // several scroll views sharing the route's primary scroll controller.
      body: _pages[_selectedDestinationIndex],
    );
  }
}
