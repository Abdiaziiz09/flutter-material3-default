import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/widgets/adaptive_content_container.dart';
import 'package:flutter_material3_default/features/components/presentation/widgets/buttons_showcase_section.dart';
import 'package:flutter_material3_default/features/components/presentation/widgets/feedback_showcase_section.dart';
import 'package:flutter_material3_default/features/components/presentation/widgets/input_controls_showcase_section.dart';

/// Catalogue of the Material 3 components that applications built from this
/// foundation are expected to use.
///
/// It doubles as a visual regression surface: check new theme changes here in
/// light and dark mode.
class ComponentsPage extends StatelessWidget {
  /// Creates the components page.
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // Persists the scroll offset when the user switches destinations.
      key: const PageStorageKey<String>('components-scroll-view'),
      slivers: [
        const SliverAppBar.large(title: Text('Components')),
        AdaptiveContentContainer.sliver(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonsShowcaseSection(),
              InputControlsShowcaseSection(),
              FeedbackShowcaseSection(),
            ],
          ),
        ),
      ],
    );
  }
}
