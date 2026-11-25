import 'package:flutter/material.dart';
import 'package:flutter_material3_default/app/router/app_routes.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/adaptive_content_container.dart';

/// Shown when the application is asked to open a route that does not exist.
class NotFoundPage extends StatelessWidget {
  /// Creates the page for the unknown [routeName].
  const NotFoundPage({required this.routeName, super.key});

  /// Name of the route that could not be found, if known.
  final String? routeName;

  void _handleGoHomePressed(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requestedRoute = routeName ?? 'unknown';

    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: SafeArea(
        child: Center(
          // Scrolling keeps the content reachable on very small windows.
          child: SingleChildScrollView(
            child: AdaptiveContentContainer(
              maxWidth: 560,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off,
                    size: AppSpacing.huge,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Text(
                    'We could not find "$requestedRoute".',
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.large),
                  FilledButton(
                    onPressed: () => _handleGoHomePressed(context),
                    child: const Text('Go to home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
