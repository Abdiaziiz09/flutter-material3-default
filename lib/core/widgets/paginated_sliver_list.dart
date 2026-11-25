import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';

/// Listens to scroll notifications and invokes [onLoadMore] when the user
/// scrolls within [loadMoreThreshold] logical pixels of the end.
///
/// Wrap a `CustomScrollView`, `ListView`, or `GridView` with this widget to
/// implement continuous, jank-free pagination without fighting scroll physics.
class ScrollPaginationListener extends StatelessWidget {
  /// Creates a scroll pagination listener around [child].
  const ScrollPaginationListener({
    required this.child,
    required this.onLoadMore,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.loadMoreThreshold = 240,
    super.key,
  });

  /// Scrollable widget to observe.
  final Widget child;

  /// Called when the scroll position reaches within [loadMoreThreshold] of
  /// the maximum scroll extent while [hasMore] is `true` and [isLoadingMore]
  /// is `false`.
  final VoidCallback onLoadMore;

  /// Whether more items are available to load.
  final bool hasMore;

  /// Whether a load-more request is currently in flight.
  final bool isLoadingMore;

  /// Distance from the bottom edge (in logical pixels) that triggers loading.
  final double loadMoreThreshold;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!hasMore || isLoadingMore) {
      return false;
    }
    if (notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - loadMoreThreshold) {
      onLoadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: child,
    );
  }
}

/// A sliver list that supports continuous pagination with an optional loading
/// indicator footer.
///
/// Pair with [ScrollPaginationListener] inside a `CustomScrollView` to build
/// smooth, continuous feeds.
class PaginatedSliverList extends StatelessWidget {
  /// Creates a paginated sliver list of [itemCount] items.
  const PaginatedSliverList({
    required this.itemCount,
    required this.itemBuilder,
    this.isLoadingMore = false,
    super.key,
  });

  /// Number of loaded items.
  final int itemCount;

  /// Builds the item at a given index.
  final IndexedWidgetBuilder itemBuilder;

  /// Whether a loading indicator should appear below the last item.
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    final totalCount = isLoadingMore ? itemCount + 1 : itemCount;

    return SliverList.builder(
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (index >= itemCount) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.large),
            child: Center(
              child: Semantics(
                label: 'Loading more items',
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        }
        return itemBuilder(context, index);
      },
    );
  }
}
