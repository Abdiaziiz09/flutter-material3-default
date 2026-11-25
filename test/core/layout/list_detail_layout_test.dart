import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/list_detail_layout.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void _setWindowWidth(WidgetTester tester, double width) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, 800);
  addTearDown(tester.view.reset);
}

void main() {
  group('ListDetailLayout', () {
    testWidgets('shows only list on compact windows when showDetail is false', (
      tester,
    ) async {
      _setWindowWidth(tester, 400);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: ListDetailLayout(
              showDetail: false,
              list: Text('List pane'),
              detail: Text('Detail pane'),
            ),
          ),
        ),
      );

      expect(find.text('List pane'), findsOneWidget);
      expect(find.text('Detail pane'), findsNothing);
    });

    testWidgets(
      'shows only detail on compact windows when showDetail is true',
      (tester) async {
        _setWindowWidth(tester, 400);

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: const Scaffold(
              body: ListDetailLayout(
                showDetail: true,
                list: Text('List pane'),
                detail: Text('Detail pane'),
              ),
            ),
          ),
        );

        expect(find.text('List pane'), findsNothing);
        expect(find.text('Detail pane'), findsOneWidget);
      },
    );

    testWidgets('shows both panes side by side on expanded windows', (
      tester,
    ) async {
      _setWindowWidth(tester, 1000);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: ListDetailLayout(
              showDetail: true,
              list: Text('List pane'),
              detail: Text('Detail pane'),
            ),
          ),
        ),
      );

      expect(find.text('List pane'), findsOneWidget);
      expect(find.text('Detail pane'), findsOneWidget);
      expect(find.byType(VerticalDivider), findsOneWidget);
    });
  });
}
