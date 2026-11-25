import 'package:flutter/material.dart';
import 'package:flutter_material3_default/app/router/app_routes.dart';
import 'package:flutter_material3_default/app/shell/app_shell_page.dart';
import 'package:flutter_material3_default/app/shell/not_found_page.dart';

/// Maps route names and deep-link URIs to pages.
///
/// Supports deep linking directly to top-level destinations (such as
/// `/components` or `/settings`, including query parameters). When an
/// application needs nested URL-driven navigation, replace this class with
/// `go_router` and record the decision in `docs/ARCHITECTURE.md`.
abstract final class AppRouter {
  /// Creates the route for [settings].
  ///
  /// Unknown route names lead to [NotFoundPage] instead of a crash.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.tryParse(settings.name ?? '');
    final path = uri?.path ?? settings.name;

    switch (path) {
      case AppRoutes.home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const AppShellPage(initialDestinationIndex: 0),
        );
      case AppRoutes.components:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const AppShellPage(initialDestinationIndex: 1),
        );
      case AppRoutes.settings:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const AppShellPage(initialDestinationIndex: 2),
        );
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => NotFoundPage(routeName: settings.name),
        );
    }
  }
}
