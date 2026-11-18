import 'package:flutter/material.dart';

/// Holds the user's selected [ThemeMode] and notifies listeners when it
/// changes.
///
/// Create one instance near the root of the application and expose it with
/// [ThemeScope].
class ThemeController extends ChangeNotifier {
  /// Creates a controller that starts with [initialThemeMode].
  ThemeController({ThemeMode initialThemeMode = ThemeMode.system})
    : _themeMode = initialThemeMode;

  ThemeMode _themeMode;

  /// The currently selected theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Selects [newThemeMode] and notifies listeners if it differs from the
  /// current mode.
  void updateThemeMode(ThemeMode newThemeMode) {
    if (newThemeMode == _themeMode) {
      return;
    }
    _themeMode = newThemeMode;
    notifyListeners();
  }
}

/// Makes a [ThemeController] available to the widget tree.
///
/// Widgets that call [ThemeScope.of] are rebuilt automatically when the theme
/// mode changes.
class ThemeScope extends InheritedNotifier<ThemeController> {
  /// Creates a scope that exposes [themeController] to [child] and its
  /// descendants.
  const ThemeScope({
    required ThemeController themeController,
    required super.child,
    super.key,
  }) : super(notifier: themeController);

  /// Returns the nearest [ThemeController] and subscribes [context] to its
  /// changes.
  ///
  /// Throws a [FlutterError] in debug mode if no [ThemeScope] is found.
  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'No ThemeScope found in the widget tree.');
    return scope!.notifier!;
  }
}
