import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/adaptive_scaffold.dart';
import 'package:flutter_material3_default/core/layout/app_destination.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<AppDestination> _testDestinations = [
  AppDestination(
    label: 'First',
    icon: Icons.looks_one_outlined,
    selectedIcon: Icons.looks_one,
  ),
  AppDestination(
    label: 'Second',
    icon: Icons.looks_two_outlined,
    selectedIcon: Icons.looks_two,
  ),
];

/// Sets the simulated window to [width] logical pixels and restores it when
/// the test ends.
void _setWindowWidth(WidgetTester tester, double width) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, 800);
  addTearDown(tester.view.reset);
}

Future<void> _pumpScaffold(
  WidgetTester tester, {
  ValueChanged<int>? onDestinationSelected,
  Widget body = const Text('Body content'),
}) {
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: AdaptiveScaffold(
        destinations: _testDestinations,
        selectedIndex: 0,
        onDestinationSelected: onDestinationSelected ?? (_) {},
        body: body,
      ),
    ),
  );
}

void main() {
  group('AdaptiveScaffold', () {
    testWidgets('shows a navigation bar on compact windows', (tester) async {
      _setWindowWidth(tester, 400);

      await _pumpScaffold(tester);

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.text('Body content'), findsOneWidget);
    });

    testWidgets('shows a collapsed rail on medium windows', (tester) async {
      _setWindowWidth(tester, 700);

      await _pumpScaffold(tester);

      expect(find.byType(NavigationBar), findsNothing);
      expect(
        tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
        isFalse,
      );
    });

    for (final width in [900.0, 1300.0, 1800.0]) {
      testWidgets('shows an extended rail at ${width.toInt()} px', (
        tester,
      ) async {
        _setWindowWidth(tester, width);

        await _pumpScaffold(tester);

        expect(find.byType(NavigationBar), findsNothing);
        expect(
          tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
          isTrue,
        );
      });
    }

    testWidgets('reports the index of the tapped destination', (tester) async {
      _setWindowWidth(tester, 400);
      int? selectedIndex;

      await _pumpScaffold(
        tester,
        onDestinationSelected: (index) => selectedIndex = index,
      );
      await tester.tap(find.text('Second'));

      expect(selectedIndex, 1);
    });

    testWidgets('keeps the body state when the window is resized', (
      tester,
    ) async {
      _setWindowWidth(tester, 400);
      await _pumpScaffold(tester, body: const TextField());
      await tester.enterText(find.byType(TextField), 'kept text');

      // Cross the compact/medium breakpoint, which swaps the navigation bar
      // for a navigation rail.
      tester.view.physicalSize = const Size(900, 800);
      await tester.pump();

      expect(find.text('kept text'), findsOneWidget);
      expect(find.byType(NavigationRail), findsOneWidget);
    });
  });
}
