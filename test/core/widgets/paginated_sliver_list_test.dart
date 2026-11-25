import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/widgets/paginated_sliver_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaginatedSliverList & ScrollPaginationListener', () {
    testWidgets('triggers onLoadMore when scrolling near bottom', (
      tester,
    ) async {
      var loadMoreCalls = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ScrollPaginationListener(
              onLoadMore: () => loadMoreCalls++,
              child: CustomScrollView(
                slivers: [
                  PaginatedSliverList(
                    itemCount: 30,
                    itemBuilder: (context, index) =>
                        ListTile(title: Text('Item $index')),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.fling(
        find.byType(CustomScrollView),
        const Offset(0, -1500),
        1000,
      );
      await tester.pumpAndSettle();

      expect(loadMoreCalls, greaterThan(0));
    });

    testWidgets('shows loading indicator footer when isLoadingMore is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                PaginatedSliverList(
                  itemCount: 2,
                  isLoadingMore: true,
                  itemBuilder: (context, index) =>
                      ListTile(title: Text('Item $index')),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
