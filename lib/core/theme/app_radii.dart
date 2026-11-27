import 'package:flutter/widgets.dart';

/// Corner radius scale aligned with Material 3 shape tokens.
///
/// Prefer the built-in shapes of Material 3 components (`Card`, `FilledButton`,
/// `Dialog`, `Chip`). Use these constants when building custom surfaces,
/// containers or ink clipping regions so radii stay consistent across the app.
abstract final class AppRadii {
  /// 0 dp. Sharp corners for full-bleed surfaces or dividers.
  static const double none = 0;

  /// 4 dp. Small badges, tooltips and compact indicators.
  static const double extraSmall = 4;

  /// 8 dp. Chips, compact buttons and dense list items.
  static const double small = 8;

  /// 12 dp. Default cards, input containers and standard surfaces.
  static const double medium = 12;

  /// 16 dp. Prominent cards, navigation drawers and floating panels.
  static const double large = 16;

  /// 28 dp. Dialogs, bottom sheets and large modal surfaces.
  static const double extraLarge = 28;

  /// 9999 dp. Pill shapes and circular controls.
  static const double full = 9999;

  /// Circular [BorderRadius] using [small] (8 dp).
  static const BorderRadius borderRadiusSmall = BorderRadius.all(
    Radius.circular(small),
  );

  /// Circular [BorderRadius] using [medium] (12 dp).
  static const BorderRadius borderRadiusMedium = BorderRadius.all(
    Radius.circular(medium),
  );

  /// Circular [BorderRadius] using [large] (16 dp).
  static const BorderRadius borderRadiusLarge = BorderRadius.all(
    Radius.circular(large),
  );

  /// Circular [BorderRadius] using [extraLarge] (28 dp).
  static const BorderRadius borderRadiusExtraLarge = BorderRadius.all(
    Radius.circular(extraLarge),
  );

  /// Circular [BorderRadius] using [full] (9999 dp) for capsule/pill shapes.
  static const BorderRadius borderRadiusFull = BorderRadius.all(
    Radius.circular(full),
  );
}
