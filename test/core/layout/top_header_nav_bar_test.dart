import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/layout/top_header_nav_bar.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<AppDestination> _manyDestinations = [
  AppDestination(
    label: 'Overview',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  AppDestination(
    label: 'Tasks',
    icon: Icons.check_circle_outline,
    selectedIcon: Icons.check_circle,
  ),
  AppDestination(
    label: 'Projects',
    icon: Icons.folder_outlined,
    selectedIcon: Icons.folder,
  ),
  AppDestination(
    label: 'Analytics',
    icon: Icons.bar_chart_outlined,
    selectedIcon: Icons.bar_chart,
  ),
  AppDestination(
    label: 'Team',
    icon: Icons.group_outlined,
    selectedIcon: Icons.group,
  ),
  AppDestination(
    label: 'Settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  ),
];

void main() {
  group('TopHeaderNavBar', () {
    testWidgets(
      'shows primary items in header and overflows extra items into dropdown',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(1280, 800);
        addTearDown(tester.view.reset);

        int? selectedIndex;

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              appBar: TopHeaderNavBar(
                title: const Text('Workspace'),
                destinations: _manyDestinations,
                selectedIndex: 0,
                maxHeaderItems: 5,
                onDestinationSelected: (index) => selectedIndex = index,
              ),
              body: const SizedBox.expand(),
            ),
          ),
        );

        expect(find.text('Workspace'), findsOneWidget);
        expect(find.text('Overview'), findsOneWidget);
        expect(find.text('Tasks'), findsOneWidget);
        expect(find.text('Projects'), findsOneWidget);
        expect(find.text('Analytics'), findsOneWidget);
        expect(find.text('More'), findsOneWidget);
        expect(find.text('Team'), findsNothing);
        expect(find.text('Settings'), findsNothing);

        // Open header dropdown menu and pick an overflow destination.
        await tester.tap(find.text('More'));
        await tester.pumpAndSettle();

        expect(find.text('Team'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(selectedIndex, 5);
      },
    );

    testWidgets('renders without overflow at 840 px and 200% text scale', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(840, 800);
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              appBar: TopHeaderNavBar(
                destinations: _manyDestinations,
                selectedIndex: 1,
                onDestinationSelected: (_) {},
              ),
              body: const SizedBox.expand(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
