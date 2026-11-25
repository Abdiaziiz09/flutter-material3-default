import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/motion/contextual_switcher.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContextualSwitcher', () {
    testWidgets('transitions between keyed children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const ContextualSwitcher(
            child: Text('First', key: ValueKey<String>('first')),
          ),
        ),
      );
      expect(find.text('First'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const ContextualSwitcher(
            child: Text('Second', key: ValueKey<String>('second')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Second'), findsOneWidget);
      expect(find.text('First'), findsNothing);
    });

    testWidgets('switches immediately when reduced motion is enabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: ContextualSwitcher(
              child: Text('Initial', key: ValueKey<String>('initial')),
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: ContextualSwitcher(
              child: Text('Updated', key: ValueKey<String>('updated')),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Updated'), findsOneWidget);
      expect(find.text('Initial'), findsNothing);
    });
  });
}
