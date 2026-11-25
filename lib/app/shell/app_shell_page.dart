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
///
/// ## Platform back navigation
///
/// On Android, the system back gesture is handled by [PopScope] wrapping
/// [AdaptiveScaffold]:
///
/// - When the user is **not** on the first destination (index 0), back
///   navigates to destination 0 (Home) instead of popping the route. This
///   mirrors the standard Android multi-tab app pattern.
/// - When already on destination 0, back is passed through to the Flutter
///   navigator so the app exits normally.
///
/// iOS swipe-back and predictive back are handled automatically by Flutter's
/// route transitions; no additional code is needed inside this shell.
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

  /// Handles the system back button / gesture on Android.
  ///
  /// - If the user is on a destination other than Home (index 0), navigate back
  ///   to Home instead of exiting.
  /// - If already on Home, allow the route to pop normally (app exits).
  void _handleBackInvoked(bool didPop, Object? result) {
    if (didPop) return;
    if (_selectedDestinationIndex != 0) {
      setState(() {
        _selectedDestinationIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Allow the pop when already on the first destination so the app exits.
      canPop: _selectedDestinationIndex == 0,
      onPopInvokedWithResult: _handleBackInvoked,
      child: AdaptiveScaffold(
        destinations: _destinations,
        selectedIndex: _selectedDestinationIndex,
        onDestinationSelected: _handleDestinationSelected,
        // Only the selected page is built. Each page restores its scroll
        // position through a PageStorageKey, and building one page at a time
        // avoids several scroll views sharing the route's primary scroll
        // controller.
        body: _pages[_selectedDestinationIndex],
      ),
    );
  }
}
