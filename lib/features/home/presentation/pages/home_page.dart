import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/adaptive_content_container.dart';
import 'package:flutter_material3_default/core/widgets/responsive_sliver_grid.dart';
import 'package:flutter_material3_default/core/widgets/section_header.dart';
import 'package:flutter_material3_default/features/home/presentation/widgets/highlight_card.dart';

/// Landing page that demonstrates the standard page structure: a large
/// Material 3 app bar, width-limited content and a responsive card grid.
///
/// Use this page as a reference when creating new screens.
class HomePage extends StatelessWidget {
  /// Creates the home page.
  const HomePage({super.key});

  static const List<_HighlightContent> _highlights = [
    _HighlightContent(
      icon: Icons.palette_outlined,
      title: 'Material 3 by default',
      description:
          'Colour, typography and components come from the Material 3 theme, '
          'so every screen looks consistent in light and dark mode.',
    ),
    _HighlightContent(
      icon: Icons.devices_outlined,
      title: 'Six platforms, one codebase',
      description:
          'Android, iOS, web, Windows, macOS and Linux share the same '
          'responsive user interface.',
    ),
    _HighlightContent(
      icon: Icons.view_quilt_outlined,
      title: 'Adaptive navigation',
      description:
          'A navigation bar, rail or extended rail is chosen automatically '
          'from the available width.',
    ),
    _HighlightContent(
      icon: Icons.animation_outlined,
      title: 'Context-aware motion',
      description:
          'Tactile interactions and smooth state transitions that adapt to '
          'purpose and respect reduced-motion preferences.',
    ),
    _HighlightContent(
      icon: Icons.accessibility_new_outlined,
      title: 'Accessible',
      description:
          'Large touch targets, labelled controls and layouts that survive '
          'large text sizes.',
    ),
    _HighlightContent(
      icon: Icons.integration_instructions_outlined,
      title: 'AI-ready design system',
      description:
          'AGENTS.md and tokenised primitives guide coding agents to build '
          'consistent, durable applications.',
    ),
    _HighlightContent(
      icon: Icons.rule_outlined,
      title: 'Verified by tooling',
      description:
          'Strict lint rules, documentation checks and tests keep the '
          'standard enforceable.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // Persists the scroll offset when the user switches destinations.
      key: const PageStorageKey<String>('home-scroll-view'),
      slivers: [
        const SliverAppBar.large(title: Text('Home')),
        AdaptiveContentContainer.sliver(
          child: const SectionHeader(
            title: 'Flutter Material 3 foundation',
            subtitle:
                'Resize the window or rotate the device to see the layout '
                'adapt.',
          ),
        ),
        ResponsiveSliverGrid(
          itemCount: _highlights.length,
          itemBuilder: (context, index) {
            final highlight = _highlights[index];
            return HighlightCard(
              icon: highlight.icon,
              title: highlight.title,
              description: highlight.description,
            );
          },
        ),
        // Space at the end so the last row never touches the screen edge.
        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.extraLarge),
        ),
      ],
    );
  }
}

/// Content of one highlight card shown by [HomePage].
class _HighlightContent {
  const _HighlightContent({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
