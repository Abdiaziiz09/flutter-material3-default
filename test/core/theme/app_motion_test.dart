import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/motion/motion_priority.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppMotion', () {
    test('is registered on both light and dark themes', () {
      expect(AppTheme.light().extension<AppMotion>(), isNotNull);
      expect(AppTheme.dark().extension<AppMotion>(), isNotNull);
    });

    testWidgets('context.motion returns registered AppMotion extension', (
      tester,
    ) async {
      late AppMotion resolvedMotion;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              resolvedMotion = context.motion;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolvedMotion.standard, AppMotion.defaults.standard);
      expect(resolvedMotion.quick, AppMotion.defaults.quick);
    });

    testWidgets('durationFor returns base duration when animations enabled', (
      tester,
    ) async {
      late Duration resolvedDuration;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: false),
            child: Builder(
              builder: (context) {
                resolvedDuration = context.motion.durationFor(
                  context,
                  context.motion.standard,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(resolvedDuration, AppMotion.defaults.standard);
    });

    testWidgets('durationFor returns Duration.zero when animations disabled', (
      tester,
    ) async {
      late Duration standardDuration;
      late Duration decorativeDuration;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: Builder(
              builder: (context) {
                standardDuration = context.motion.durationFor(
                  context,
                  context.motion.standard,
                );
                decorativeDuration = context.motion.durationFor(
                  context,
                  context.motion.emphasized,
                  priority: MotionPriority.decorative,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(standardDuration, Duration.zero);
      expect(decorativeDuration, Duration.zero);
    });
  });
}
