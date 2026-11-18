import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/constants/app_constants.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/theme/theme_controller.dart';
import 'package:flutter_material3_default/core/widgets/adaptive_content_container.dart';
import 'package:flutter_material3_default/core/widgets/section_header.dart';

/// Lets the user choose the appearance of the application.
///
/// Demonstrates reading and updating shared state through [ThemeScope].
class SettingsPage extends StatelessWidget {
  /// Creates the settings page.
  const SettingsPage({super.key});

  static const List<_ThemeModeOption> _themeModeOptions = [
    _ThemeModeOption(themeMode: ThemeMode.system, label: 'System'),
    _ThemeModeOption(themeMode: ThemeMode.light, label: 'Light'),
    _ThemeModeOption(themeMode: ThemeMode.dark, label: 'Dark'),
  ];

  void _handleAboutPressed(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.applicationName,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Subscribing here rebuilds the chips when the theme mode changes.
    final themeController = ThemeScope.of(context);

    return CustomScrollView(
      // Persists the scroll offset when the user switches destinations.
      key: const PageStorageKey<String>('settings-scroll-view'),
      slivers: [
        const SliverAppBar.large(title: Text('Settings')),
        AdaptiveContentContainer.sliver(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Appearance',
                subtitle: 'Choose how the application looks.',
              ),
              // Chips wrap onto new lines, so they stay usable at any width and
              // text size.
              Wrap(
                spacing: AppSpacing.small,
                runSpacing: AppSpacing.small,
                children: [
                  for (final option in _themeModeOptions)
                    ChoiceChip(
                      label: Text(option.label),
                      selected: themeController.themeMode == option.themeMode,
                      onSelected: (_) {
                        themeController.updateThemeMode(option.themeMode);
                      },
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.large),
              const SectionHeader(title: 'About'),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline),
                title: const Text('About this application'),
                subtitle: const Text('Flutter Material 3 default foundation'),
                onTap: () => _handleAboutPressed(context),
              ),
              const SizedBox(height: AppSpacing.extraLarge),
            ],
          ),
        ),
      ],
    );
  }
}

/// A selectable theme mode together with its display label.
class _ThemeModeOption {
  const _ThemeModeOption({required this.themeMode, required this.label});

  final ThemeMode themeMode;
  final String label;
}
