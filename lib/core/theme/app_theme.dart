import 'package:flutter/material.dart';

/// Builds the Material 3 themes used by the whole application.
///
/// This is the only place where a [ThemeData] is created. Material 3 is always
/// enabled (`useMaterial3: true`) and every colour is derived from a single
/// [seedColor] through [ColorScheme.fromSeed], which guarantees accessible
/// contrast and consistent light and dark palettes.
///
/// To rebrand an application, change [seedColor]; do not recolour individual
/// widgets.
abstract final class AppTheme {
  /// Seed colour from which the complete Material 3 colour scheme is generated.
  static const Color seedColor = Color(0xFF6750A4);

  /// Light theme.
  static ThemeData light() => _buildTheme(Brightness.light);

  /// Dark theme.
  static ThemeData dark() => _buildTheme(Brightness.dark);

  /// Creates a Material 3 theme for the given [brightness].
  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Compact density on desktop and web, comfortable density on mobile.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
