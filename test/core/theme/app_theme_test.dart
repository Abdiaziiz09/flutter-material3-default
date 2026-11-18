import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/theme/theme_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('light theme uses Material 3 and a light colour scheme', () {
      final theme = AppTheme.light();

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('dark theme uses Material 3 and a dark colour scheme', () {
      final theme = AppTheme.dark();

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });
  });

  group('ThemeController', () {
    test('starts with the system theme mode by default', () {
      final controller = ThemeController();
      addTearDown(controller.dispose);

      expect(controller.themeMode, ThemeMode.system);
    });

    test('notifies listeners when the theme mode changes', () {
      final controller = ThemeController();
      addTearDown(controller.dispose);
      var notificationCount = 0;
      controller.addListener(() => notificationCount++);

      controller.updateThemeMode(ThemeMode.dark);

      expect(controller.themeMode, ThemeMode.dark);
      expect(notificationCount, 1);
    });

    test('does not notify listeners when the theme mode is unchanged', () {
      final controller = ThemeController(initialThemeMode: ThemeMode.light);
      addTearDown(controller.dispose);
      var notificationCount = 0;
      controller.addListener(() => notificationCount++);

      controller.updateThemeMode(ThemeMode.light);

      expect(notificationCount, 0);
    });
  });
}
