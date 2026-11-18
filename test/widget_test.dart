import 'package:flutter/material.dart';
import 'package:flutter_material3_default/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

/// Window widths, in logical pixels, that cover every window size class.
const List<double> _windowWidths = [320, 400, 600, 840, 1200, 1600];

/// The top-level destinations and the icon used to open each one. The home
/// page is open at start-up, so it has no icon to tap.
const List<({String name, IconData? icon})> _destinations = [
  (name: 'home', icon: null),
  (name: 'components', icon: Icons.widgets_outlined),
  (name: 'settings', icon: Icons.settings_outlined),
];

/// Sets the simulated window to the given size and restores it when the test
/// ends.
void _setWindowSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('starts on the home page', (tester) async {
    await tester.pumpWidget(const MaterialDefaultApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Material 3 foundation'), findsOneWidget);
  });

  testWidgets('uses Material 3', (tester) async {
    await tester.pumpWidget(const MaterialDefaultApp());
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(Scaffold).first);

    expect(Theme.of(context).useMaterial3, isTrue);
  });

  testWidgets('opens the settings page and switches to the dark theme', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialDefaultApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });

  group('responsive layout', () {
    for (final width in _windowWidths) {
      for (final destination in _destinations) {
        testWidgets(
          'has no overflow on the ${destination.name} page at '
          '${width.toInt()} px',
          (tester) async {
            _setWindowSize(tester, Size(width, 800));

            await tester.pumpWidget(const MaterialDefaultApp());
            await tester.pumpAndSettle();

            final icon = destination.icon;
            if (icon != null) {
              await tester.tap(find.byIcon(icon));
              await tester.pumpAndSettle();
            }

            // Layout overflows are reported as exceptions during the test.
            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  });
}
