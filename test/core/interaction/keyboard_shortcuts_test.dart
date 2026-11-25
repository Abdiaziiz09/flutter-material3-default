import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material3_default/core/interaction/keyboard_shortcuts.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppShortcuts', () {
    testWidgets('invokes onDismiss when Escape is pressed', (tester) async {
      var dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppShortcuts(
              onDismiss: () => dismissed = true,
              child: const Focus(
                autofocus: true,
                child: Text('Focusable content'),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();

      expect(dismissed, isTrue);
    });
  });
}
