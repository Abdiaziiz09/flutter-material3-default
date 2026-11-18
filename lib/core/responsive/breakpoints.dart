/// Window size classes based on the Material 3 adaptive breakpoints.
///
/// Classify a width with [WindowSizeClass.fromWidth] and adapt layouts to the
/// resulting class instead of comparing raw pixel values throughout the code.
/// Design for [compact] first, then enhance for larger classes.
enum WindowSizeClass {
  /// Width below 600 dp: phones in portrait.
  compact(minimumWidth: 0, pageMargin: 16),

  /// Width from 600 dp to below 840 dp: tablets, foldables and phones in
  /// landscape.
  medium(minimumWidth: 600, pageMargin: 24),

  /// Width from 840 dp to below 1200 dp: large tablets and small desktop
  /// windows.
  expanded(minimumWidth: 840, pageMargin: 24),

  /// Width from 1200 dp to below 1600 dp: typical desktop windows.
  large(minimumWidth: 1200, pageMargin: 32),

  /// Width of 1600 dp and above: wide desktop monitors.
  extraLarge(minimumWidth: 1600, pageMargin: 32);

  /// Creates a window size class that starts at [minimumWidth] and recommends
  /// a [pageMargin] for page content.
  const WindowSizeClass({required this.minimumWidth, required this.pageMargin});

  /// Smallest width, in logical pixels, that belongs to this class.
  final double minimumWidth;

  /// Horizontal margin, in logical pixels, recommended for page content in this
  /// class.
  final double pageMargin;

  /// Returns the class that contains [width] (in logical pixels).
  ///
  /// Negative and `NaN` widths are classified as [compact] and an infinite
  /// width as [extraLarge], so unbounded constraints never throw.
  static WindowSizeClass fromWidth(double width) {
    // Walk from the largest class down; the first minimum that fits wins.
    for (final windowSizeClass in values.reversed) {
      if (width >= windowSizeClass.minimumWidth) {
        return windowSizeClass;
      }
    }
    return WindowSizeClass.compact;
  }

  /// Whether this class is at least as wide as [other].
  bool isAtLeast(WindowSizeClass other) => index >= other.index;
}
