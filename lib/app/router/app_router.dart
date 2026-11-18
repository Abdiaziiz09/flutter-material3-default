import 'package:flutter/material.dart';
import 'package:flutter_material3_default/app/router/app_routes.dart';
import 'package:flutter_material3_default/app/shell/app_shell_page.dart';
import 'package:flutter_material3_default/app/shell/not_found_page.dart';

/// Maps route names to pages.
///
/// When an application needs deep linking, URL-driven state or nested
/// navigation, replace this class with `go_router` and record the decision in
/// `docs/ARCHITECTURE.md`.
abstract final class AppRouter {
  /// Creates the route for [settings].
  ///
  /// Unknown route names lead to [NotFoundPage] instead of a crash.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const AppShellPage(),
        );
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => NotFoundPage(routeName: settings.name),
        );
    }
  }
}
