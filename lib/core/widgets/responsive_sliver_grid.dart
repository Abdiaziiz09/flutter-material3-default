import 'package:flutter/widgets.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/adaptive_content_container.dart';

/// A sliver grid whose number of columns follows the available width.
///
/// Instead of a fixed column count, items are at most [maxItemWidth] wide and
/// as many columns as fit are created: one on a phone, several on a desktop.
/// The grid is aligned with `AdaptiveContentContainer`, so both can be mixed in
/// one `CustomScrollView`.
///
/// Each item has a fixed height ([itemHeight]) that grows with the user's text
/// scale, so large text does not overflow.
class ResponsiveSliverGrid extends StatelessWidget {
  /// Creates a responsive grid of [itemCount] items.
  const ResponsiveSliverGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.maxItemWidth = 360,
    this.itemHeight = 168,
    this.spacing = AppSpacing.medium,
    super.key,
  });

  /// Number of items in the grid.
  final int itemCount;

  /// Builds the item at a given index.
  final IndexedWidgetBuilder itemBuilder;

  /// Maximum width of one item, in logical pixels.
  final double maxItemWidth;

  /// Height of one item at the default text scale, in logical pixels.
  final double itemHeight;

  /// Gap between items, both horizontally and vertically.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    // Scale the height with the text size so enlarged text still fits.
    final scaledItemHeight = MediaQuery.textScalerOf(context).scale(itemHeight);

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final horizontalInset = AdaptiveContentContainer.horizontalInsetFor(
          constraints.crossAxisExtent,
        );
        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalInset),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxItemWidth,
              mainAxisExtent: scaledItemHeight,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
            ),
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        );
      },
    );
  }
}
