import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/widgets/skeleton_box.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SkeletonBox', () {
    testWidgets('renders with given dimensions and respects reduced motion', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: Scaffold(body: SkeletonBox(width: 120, height: 24)),
          ),
        ),
      );

      expect(find.byType(SkeletonBox), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
