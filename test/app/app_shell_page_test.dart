import 'package:flutter/material.dart';
import 'package:flutter_material3_default/app/shell/app_shell_page.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/theme/theme_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrapWithShell({int initialDestinationIndex = 0}) {
    final controller = ThemeController();
    addTearDown(controller.dispose);

    return ThemeScope(
      themeController: controller,
      child: MaterialApp(
        theme: AppTheme.light(),
        home: AppShellPage(initialDestinationIndex: initialDestinationIndex),
      ),
    );
  }

  group('AppShellPage back navigation', () {
    testWidgets(
      'returns to Home when back is invoked from a secondary destination',
      (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(wrapWithShell(initialDestinationIndex: 2));
        await tester.pumpAndSettle();

        // Starts on Settings (index 2).
        expect(find.text('Appearance'), findsOneWidget);

        // Simulate system back button/gesture.
        final navigatorState = tester.state<NavigatorState>(
          find.byType(Navigator),
        );
        await navigatorState.maybePop();
        await tester.pumpAndSettle();

        // Navigated back to Home (index 0) instead of popping the route.
        expect(find.text('Appearance'), findsNothing);
        expect(find.byType(AppShellPage), findsOneWidget);
        final popScope = tester.widget<PopScope<dynamic>>(
          find.byWidgetPredicate((widget) => widget is PopScope),
        );
        expect(popScope.canPop, isTrue);
      },
    );

    testWidgets('allows pop when already on Home (index 0)', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(wrapWithShell(initialDestinationIndex: 0));
      await tester.pumpAndSettle();

      final popScope = tester.widget<PopScope<dynamic>>(
        find.byWidgetPredicate((widget) => widget is PopScope),
      );
      expect(popScope.canPop, isTrue);
    });
  });
}
