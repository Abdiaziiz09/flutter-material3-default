import 'package:flutter/material.dart';
import 'package:flutter_material3_default/app/router/app_router.dart';
import 'package:flutter_material3_default/app/router/app_routes.dart';
import 'package:flutter_material3_default/app/shell/not_found_page.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/theme/theme_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRouter', () {
    testWidgets('opens deep-linked destinations directly', (tester) async {
      final controller = ThemeController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        ThemeScope(
          themeController: controller,
          child: MaterialApp(
            theme: AppTheme.light(),
            initialRoute: '${AppRoutes.settings}?source=notification',
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Appearance'), findsOneWidget);
    });

    testWidgets('falls back to NotFoundPage for unknown routes', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          initialRoute: '/does-not-exist',
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NotFoundPage), findsOneWidget);
    });
  });
}
