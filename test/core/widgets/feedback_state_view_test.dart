import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/widgets/feedback_state_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeedbackStateView', () {
    testWidgets('renders title, message and invokes action callback', (
      tester,
    ) async {
      var actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: FeedbackStateView(
              icon: Icons.inbox_outlined,
              title: 'Nothing here yet',
              message: 'Create your first item to get started.',
              actionLabel: 'Create item',
              onAction: () => actionPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Nothing here yet'), findsOneWidget);
      expect(
        find.text('Create your first item to get started.'),
        findsOneWidget,
      );

      await tester.tap(find.text('Create item'));
      expect(actionPressed, isTrue);
      expect(tester.takeException(), isNull);
    });
  });
}
