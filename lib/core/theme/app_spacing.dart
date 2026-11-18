/// Spacing scale based on Material's 4 dp baseline grid.
///
/// Use these constants for padding, margins and gaps instead of literal
/// numbers so every screen shares the same rhythm.
abstract final class AppSpacing {
  /// 4 dp. Tight gaps, such as between a title and its subtitle.
  static const double extraSmall = 4;

  /// 8 dp. Gaps between closely related elements, such as chips or buttons.
  static const double small = 8;

  /// 16 dp. Default padding inside cards and gaps between components.
  static const double medium = 16;

  /// 24 dp. Gaps between groups of components.
  static const double large = 24;

  /// 32 dp. Gaps between major sections of a page.
  static const double extraLarge = 32;

  /// 48 dp. Large illustrative icons and the minimum touch target size.
  static const double huge = 48;
}
