import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_status_colors.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppStatusColors', () {
    test('is registered on both light and dark themes', () {
      expect(AppTheme.light().extension<AppStatusColors>(), isNotNull);
      expect(AppTheme.dark().extension<AppStatusColors>(), isNotNull);
    });

    testWidgets('context.statusColors matches theme brightness', (
      tester,
    ) async {
      late AppStatusColors lightColors;
      late AppStatusColors darkColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              lightColors = context.statusColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Builder(
            builder: (context) {
              darkColors = context.statusColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(lightColors.success, AppStatusColors.light.success);
      expect(darkColors.success, AppStatusColors.dark.success);
    });
  });
}
