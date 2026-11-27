import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/layout/floating_pill_nav_bar.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<AppDestination> _manyDestinations = [
  AppDestination(
    label: 'Games',
    icon: Icons.sports_esports_outlined,
    selectedIcon: Icons.sports_esports,
  ),
  AppDestination(
    label: 'Apps',
    icon: Icons.grid_view_outlined,
    selectedIcon: Icons.grid_view_rounded,
  ),
  AppDestination(
    label: 'Deals',
    icon: Icons.local_offer_outlined,
    selectedIcon: Icons.local_offer,
  ),
  AppDestination(
    label: 'Updates',
    icon: Icons.update_outlined,
    selectedIcon: Icons.update,
  ),
  AppDestination(
    label: 'Settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  ),
];

void main() {
  group('FloatingPillNavBar', () {
    testWidgets(
      'keeps highest-priority items on pill and overflows rest into Menu',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(400, 800);
        addTearDown(tester.view.reset);

        int? selectedIndex;

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              extendBody: true,
              body: const SizedBox.expand(),
              bottomNavigationBar: FloatingPillNavBar(
                destinations: _manyDestinations,
                selectedIndex: 0,
                maxPrimaryItems: 4,
                onDestinationSelected: (index) => selectedIndex = index,
              ),
            ),
          ),
        );

        // Top 3 primary destinations + Menu are shown directly on the pill.
        expect(find.text('Games'), findsOneWidget);
        expect(find.text('Apps'), findsOneWidget);
        expect(find.text('Deals'), findsOneWidget);
        expect(find.text('Menu'), findsOneWidget);
        expect(find.text('Updates'), findsNothing);
        expect(find.text('Settings'), findsNothing);

        // Open the Menu overflow sheet and select an overflow destination.
        await tester.tap(find.text('Menu'));
        await tester.pumpAndSettle();

        expect(find.text('Updates'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(selectedIndex, 4);
      },
    );

    testWidgets('renders without overflow at 320 px and 200% text scale', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 800);
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              extendBody: true,
              body: ListView.builder(
                itemCount: 30,
                itemBuilder: (_, index) => ListTile(title: Text('Item $index')),
              ),
              bottomNavigationBar: FloatingPillNavBar(
                destinations: _manyDestinations,
                selectedIndex: 1,
                onDestinationSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
