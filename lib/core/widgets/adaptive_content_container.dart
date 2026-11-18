import 'package:flutter/widgets.dart';
import 'package:flutter_material3_default/core/responsive/breakpoints.dart';

/// Centres page content, limits its width and applies responsive page margins.
///
/// On compact windows the content fills the width with a 16 dp margin. On wide
/// windows the content stops growing at [maxWidth] and is centred, which keeps
/// text lines at a comfortable length.
///
/// Use [AdaptiveContentContainer.sliver] inside a `CustomScrollView`.
class AdaptiveContentContainer extends StatelessWidget {
  /// Creates a container that constrains [child] to [maxWidth].
  const AdaptiveContentContainer({
    required this.child,
    this.maxWidth = defaultMaxContentWidth,
    super.key,
  });

  /// Default maximum content width, in logical pixels.
  static const double defaultMaxContentWidth = 1200;

  /// The page content.
  final Widget child;

  /// Maximum width of [child], in logical pixels.
  final double maxWidth;

  /// Wraps [child] in a container that can be placed directly in a
  /// `CustomScrollView`'s `slivers` list.
  static Widget sliver({
    required Widget child,
    double maxWidth = defaultMaxContentWidth,
    Key? key,
  }) {
    return SliverToBoxAdapter(
      key: key,
      child: AdaptiveContentContainer(maxWidth: maxWidth, child: child),
    );
  }

  /// Returns the horizontal inset that content needs inside an area that is
  /// [availableWidth] wide.
  ///
  /// The inset is the page margin of the matching [WindowSizeClass], or the
  /// amount required to centre content of at most [maxWidth], whichever is
  /// larger. Slivers that cannot use [AdaptiveContentContainer] directly, such
  /// as `ResponsiveSliverGrid`, use this to stay aligned with it.
  static double horizontalInsetFor(
    double availableWidth, {
    double maxWidth = defaultMaxContentWidth,
  }) {
    final pageMargin = WindowSizeClass.fromWidth(availableWidth).pageMargin;
    final centeringInset = (availableWidth - maxWidth) / 2;
    return centeringInset > pageMargin ? centeringInset : pageMargin;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalInset = horizontalInsetFor(
          constraints.maxWidth,
          maxWidth: maxWidth,
        );
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalInset),
          child: child,
        );
      },
    );
  }
}
