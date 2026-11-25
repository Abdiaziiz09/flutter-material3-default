import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/interaction/tactile_surface.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TactileSurface', () {
    testWidgets('invokes onTap and exposes tooltip', (tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: TactileSurface(
                onTap: () => tapCount++,
                tooltip: 'Open item',
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Interactive item'),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);
      await tester.tap(find.text('Interactive item'));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
      expect(tester.takeException(), isNull);
    });
  });
}
