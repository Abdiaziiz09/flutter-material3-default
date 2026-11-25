import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';

/// Builds the Material 3 themes used by the whole application.
///
/// This is the only place where a [ThemeData] is created. Material 3 is always
/// enabled (`useMaterial3: true`) and every colour is derived from a single
/// [seedColor] through [ColorScheme.fromSeed], which guarantees accessible
/// contrast and consistent light and dark palettes.
///
/// Motion tokens ([AppMotion]) are registered as a theme extension so every
/// widget can adapt transitions and interactions consistently.
///
/// To rebrand an application, change [seedColor] or pass a custom `seedColor`
/// to [light] and [dark]; do not recolour individual widgets.
abstract final class AppTheme {
  /// Default seed colour from which the Material 3 colour scheme is generated.
  static const Color seedColor = Color(0xFF6750A4);

  /// Light theme.
  static ThemeData light({
    Color seedColor = AppTheme.seedColor,
    AppMotion motion = AppMotion.defaults,
  }) => _buildTheme(Brightness.light, seedColor: seedColor, motion: motion);

  /// Dark theme.
  static ThemeData dark({
    Color seedColor = AppTheme.seedColor,
    AppMotion motion = AppMotion.defaults,
  }) => _buildTheme(Brightness.dark, seedColor: seedColor, motion: motion);

  /// Creates a Material 3 theme for the given [brightness].
  static ThemeData _buildTheme(
    Brightness brightness, {
    required Color seedColor,
    required AppMotion motion,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Compact density on desktop and web, comfortable density on mobile.
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: <ThemeExtension<dynamic>>[motion],
    );
  }
}
