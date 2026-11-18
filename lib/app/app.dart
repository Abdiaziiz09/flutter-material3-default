import 'package:flutter/material.dart';
import 'package:flutter_material3_default/app/router/app_router.dart';
import 'package:flutter_material3_default/app/router/app_routes.dart';
import 'package:flutter_material3_default/core/constants/app_constants.dart';
import 'package:flutter_material3_default/core/platform/app_scroll_behavior.dart';
import 'package:flutter_material3_default/core/theme/app_theme.dart';
import 'package:flutter_material3_default/core/theme/theme_controller.dart';

/// Root widget of the application.
///
/// Configures [MaterialApp] with the Material 3 light and dark themes from
/// [AppTheme], the user-selected theme mode, routing and a scroll behaviour
/// that supports mouse dragging on desktop and web.
class MaterialDefaultApp extends StatefulWidget {
  /// Creates the root widget.
  const MaterialDefaultApp({super.key});

  @override
  State<MaterialDefaultApp> createState() => _MaterialDefaultAppState();
}

class _MaterialDefaultAppState extends State<MaterialDefaultApp> {
  /// Owns the theme mode for the lifetime of the application.
  final ThemeController _themeController = ThemeController();

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      themeController: _themeController,
      // Rebuild MaterialApp only when the theme mode changes.
      child: ListenableBuilder(
        listenable: _themeController,
        builder: (context, child) {
          return MaterialApp(
            title: AppConstants.applicationName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _themeController.themeMode,
            scrollBehavior: const AppScrollBehavior(),
            initialRoute: AppRoutes.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
