import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/motion/smooth_expandable.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SmoothExpandable', () {
    testWidgets('shows child only when expanded', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const SmoothExpandable(
            isExpanded: false,
            child: Text('Hidden details'),
          ),
        ),
      );
      expect(find.text('Hidden details'), findsNothing);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const SmoothExpandable(
            isExpanded: true,
            child: Text('Hidden details'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Hidden details'), findsOneWidget);
    });

    testWidgets('expands immediately when reduced motion is enabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: SmoothExpandable(
              isExpanded: true,
              child: Text('Instant details'),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Instant details'), findsOneWidget);
    });
  });
}
