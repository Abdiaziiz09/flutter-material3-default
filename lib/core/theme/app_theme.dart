import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_material3_default/core/theme/app_status_colors.dart';

/// Builds the Material 3 themes used by the whole application.
///
/// This is the only place where a [ThemeData] is created. Material 3 is always
/// enabled (`useMaterial3: true`) and every colour is derived from a single
/// [seedColor] through [ColorScheme.fromSeed], which guarantees accessible
/// contrast and consistent light and dark palettes.
///
/// Motion tokens ([AppMotion]) and semantic status colours ([AppStatusColors])
/// are registered as theme extensions so every widget can adapt consistently.
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
    AppStatusColors statusColors = AppStatusColors.light,
  }) => _buildTheme(
    Brightness.light,
    seedColor: seedColor,
    motion: motion,
    statusColors: statusColors,
  );

  /// Dark theme.
  static ThemeData dark({
    Color seedColor = AppTheme.seedColor,
    AppMotion motion = AppMotion.defaults,
    AppStatusColors statusColors = AppStatusColors.dark,
  }) => _buildTheme(
    Brightness.dark,
    seedColor: seedColor,
    motion: motion,
    statusColors: statusColors,
  );

  /// Creates a Material 3 theme for the given [brightness].
  static ThemeData _buildTheme(
    Brightness brightness, {
    required Color seedColor,
    required AppMotion motion,
    required AppStatusColors statusColors,
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
      extensions: <ThemeExtension<dynamic>>[motion, statusColors],
    );
  }
}
