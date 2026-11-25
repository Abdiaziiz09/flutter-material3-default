import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/widgets/app_feedback.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFeedback', () {
    testWidgets(
      'showUndoSnackBar displays message and triggers undo callback',
      (tester) async {
        var undone = false;

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return FilledButton(
                    onPressed: () {
                      AppFeedback.showUndoSnackBar(
                        context,
                        message: 'Item archived',
                        onUndo: () => undone = true,
                      );
                    },
                    child: const Text('Archive'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Archive'));
        await tester.pumpAndSettle();

        expect(find.text('Item archived'), findsOneWidget);
        expect(find.text('Undo'), findsOneWidget);

        await tester.tap(find.text('Undo'));
        await tester.pumpAndSettle();

        expect(undone, isTrue);
      },
    );
  });
}
