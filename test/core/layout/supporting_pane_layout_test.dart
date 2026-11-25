import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/layout/supporting_pane_layout.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void setWindowSize(WidgetTester tester, Size size) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  Widget wrap(Widget child) => MaterialApp(
    theme: ThemeData(extensions: const [AppMotion.defaults]),
    home: Scaffold(body: child),
  );

  group('SupportingPaneLayout', () {
    testWidgets(
      'shows only body on compact windows regardless of showSupportingPane',
      (tester) async {
        setWindowSize(tester, const Size(400, 800));

        await tester.pumpWidget(
          wrap(
            const SupportingPaneLayout(
              showSupportingPane: true,
              body: Text('Body'),
              supportingPane: Text('Pane'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Body'), findsOneWidget);
        expect(find.text('Pane'), findsNothing);
      },
    );

    testWidgets(
      'shows only body on expanded when showSupportingPane is false',
      (tester) async {
        setWindowSize(tester, const Size(1024, 768));

        await tester.pumpWidget(
          wrap(
            const SupportingPaneLayout(
              showSupportingPane: false,
              body: Text('Body'),
              supportingPane: Text('Pane'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Body'), findsOneWidget);
        expect(find.text('Pane'), findsNothing);
      },
    );

    testWidgets(
      'shows both panes on expanded when showSupportingPane is true',
      (tester) async {
        setWindowSize(tester, const Size(1024, 768));

        await tester.pumpWidget(
          wrap(
            const SupportingPaneLayout(
              showSupportingPane: true,
              body: Text('Body'),
              supportingPane: Text('Pane'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Body'), findsOneWidget);
        expect(find.text('Pane'), findsOneWidget);
      },
    );

    testWidgets('leading position puts pane before body on expanded windows', (
      tester,
    ) async {
      setWindowSize(tester, const Size(1200, 800));

      await tester.pumpWidget(
        wrap(
          const SupportingPaneLayout(
            showSupportingPane: true,
            panePosition: SupportingPanePosition.leading,
            body: Text('Body'),
            supportingPane: Text('Pane'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final bodyOffset = tester.getTopLeft(find.text('Body'));
      final paneOffset = tester.getTopLeft(find.text('Pane'));
      expect(paneOffset.dx, lessThan(bodyOffset.dx));
    });

    testWidgets('no overflow on compact at 200% text scale', (tester) async {
      setWindowSize(tester, const Size(400, 800));

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
          child: wrap(
            const SupportingPaneLayout(
              body: Text('Body'),
              supportingPane: Text('Pane'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
