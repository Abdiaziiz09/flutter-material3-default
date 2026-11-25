import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/storage/key_value_store.dart';

/// Holds the user's selected [ThemeMode] and notifies listeners when it
/// changes.
///
/// Create one instance near the root of the application and expose it with
/// [ThemeScope]. Pass an optional [KeyValueStore] to persist the selected
/// [ThemeMode] across sessions.
class ThemeController extends ChangeNotifier {
  /// Creates a controller that restores its mode from [store] when available,
  /// falling back to [initialThemeMode].
  ThemeController({
    ThemeMode initialThemeMode = ThemeMode.system,
    KeyValueStore? store,
  }) : _store = store,
       _themeMode = _restoreThemeMode(store) ?? initialThemeMode;

  /// Storage key used when persisting the selected [ThemeMode].
  static const String storageKey = 'app.theme_mode';

  final KeyValueStore? _store;
  ThemeMode _themeMode;

  /// The currently selected theme mode.
  ThemeMode get themeMode => _themeMode;

  static ThemeMode? _restoreThemeMode(KeyValueStore? store) {
    final storedName = store?.readString(storageKey);
    if (storedName == null) {
      return null;
    }
    for (final mode in ThemeMode.values) {
      if (mode.name == storedName) {
        return mode;
      }
    }
    return null;
  }

  /// Selects [newThemeMode] and notifies listeners if it differs from the
  /// current mode.
  void updateThemeMode(ThemeMode newThemeMode) {
    if (newThemeMode == _themeMode) {
      return;
    }
    _themeMode = newThemeMode;
    notifyListeners();
    final store = _store;
    if (store != null) {
      unawaited(store.writeString(storageKey, newThemeMode.name));
    }
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
