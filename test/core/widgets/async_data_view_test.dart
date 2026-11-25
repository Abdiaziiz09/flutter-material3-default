import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_material3_default/core/widgets/async_data_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: ThemeData(extensions: const [AppMotion.defaults]),
    home: Scaffold(body: child),
  );

  group('AsyncDataView', () {
    testWidgets('shows skeleton when state is loading', (tester) async {
      await tester.pumpWidget(
        wrap(
          AsyncDataView(
            state: AsyncDataState.loading,
            contentBuilder: (_) => const Text('content'),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('content'), findsNothing);
    });

    testWidgets('shows content widget when state is content', (tester) async {
      await tester.pumpWidget(
        wrap(
          AsyncDataView(
            state: AsyncDataState.content,
            contentBuilder: (_) => const Text('My content'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('My content'), findsOneWidget);
    });

    testWidgets('shows default empty state with title', (tester) async {
      await tester.pumpWidget(
        wrap(
          AsyncDataView(
            state: AsyncDataState.empty,
            contentBuilder: (_) => const Text('content'),
            emptyTitle: 'Nothing here',
            emptyMessage: 'Try again later.',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Try again later.'), findsOneWidget);
    });

    testWidgets('shows default error state with retry button', (tester) async {
      var retried = false;
      await tester.pumpWidget(
        wrap(
          AsyncDataView(
            state: AsyncDataState.error,
            contentBuilder: (_) => const Text('content'),
            errorTitle: 'Load failed',
            retryLabel: 'Retry',
            onRetry: () => retried = true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Load failed'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(retried, isTrue);
    });

    testWidgets('uses custom empty builder when provided', (tester) async {
      await tester.pumpWidget(
        wrap(
          AsyncDataView(
            state: AsyncDataState.empty,
            contentBuilder: (_) => const Text('content'),
            emptyBuilder: (_) => const Text('Custom empty'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Custom empty'), findsOneWidget);
    });

    testWidgets('uses custom error builder when provided', (tester) async {
      await tester.pumpWidget(
        wrap(
          AsyncDataView(
            state: AsyncDataState.error,
            contentBuilder: (_) => const Text('content'),
            errorBuilder: (_) => const Text('Custom error'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Custom error'), findsOneWidget);
    });

    testWidgets('no retry button when onRetry is null', (tester) async {
      await tester.pumpWidget(
        wrap(
          AsyncDataView(
            state: AsyncDataState.error,
            contentBuilder: (_) => const Text('content'),
            errorTitle: 'Error',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('transitions from loading to content without overflow', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final state = ValueNotifier(AsyncDataState.loading);
      addTearDown(state.dispose);

      await tester.pumpWidget(
        wrap(
          ValueListenableBuilder<AsyncDataState>(
            valueListenable: state,
            builder: (_, currentState, _) => AsyncDataView(
              state: currentState,
              contentBuilder: (_) => const Text('Done'),
            ),
          ),
        ),
      );

      state.value = AsyncDataState.content;
      await tester.pumpAndSettle();
      expect(find.text('Done'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
