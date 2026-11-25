import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/motion/contextual_switcher.dart';
import 'package:flutter_material3_default/core/responsive/breakpoints.dart';
import 'package:flutter_material3_default/core/responsive/responsive_builder.dart';

/// The position of the supporting pane relative to the main content.
enum SupportingPanePosition {
  /// Supporting pane is on the right of the main content (default).
  trailing,

  /// Supporting pane is on the left of the main content.
  leading,
}

/// Canonical Material 3 **supporting-pane** adaptive layout.
///
/// Material 3 defines three canonical adaptive layouts:
///
/// 1. **List-detail** (`ListDetailLayout`) — browse + inspect.
/// 2. **Supporting pane** (`SupportingPaneLayout`) — this widget — primary
///    work surface with a contextual, dismissible side panel (chat + detail,
///    code editor + properties, map + filter form, …).
/// 3. **Feed** — vertically scrolling card stream.
///
/// ## Behaviour
///
/// | Window size                   | Layout                                 |
/// |-------------------------------|----------------------------------------|
/// | `compact` / `medium`          | Full-width [body]; [supportingPane]    |
/// |                               | rendered as a modal bottom sheet or    |
/// |                               | slide-over via [onTogglePane].         |
/// | `expanded` / `large` /        | [body] and [supportingPane] side by    |
/// | `extraLarge`                  | side when [showSupportingPane] is `true`. |
///
/// On wide windows the layout does **not** push the supporting pane into an
/// overlay — it resizes [body] and shows [supportingPane] inline.
///
/// ## Example
///
/// ```dart
/// SupportingPaneLayout(
///   showSupportingPane: _showDetails,
///   body: ArticleEditor(controller: _controller),
///   supportingPane: PropertiesPanel(article: _draft),
///   onTogglePane: () => setState(() => _showDetails = !_showDetails),
/// )
/// ```
class SupportingPaneLayout extends StatelessWidget {
  /// Creates a supporting-pane adaptive layout.
  const SupportingPaneLayout({
    required this.body,
    required this.supportingPane,
    this.showSupportingPane = false,
    this.panePosition = SupportingPanePosition.trailing,
    this.bodyFlex = 3,
    this.paneFlex = 2,
    this.onTogglePane,
    super.key,
  }) : assert(bodyFlex > 0, 'bodyFlex must be positive.'),
       assert(paneFlex > 0, 'paneFlex must be positive.');

  /// Primary work-surface widget; always visible at every window size.
  final Widget body;

  /// Contextual supporting pane. Shown inline on wide windows; callers control
  /// it via a bottom-sheet or other overlay on narrow windows.
  final Widget supportingPane;

  /// Whether the supporting pane is currently open.
  ///
  /// - On wide (`expanded`+) windows: `true` renders both panes side by side;
  ///   `false` renders only [body].
  /// - On narrow windows: the layout does not control the pane visibility —
  ///   that is the caller's responsibility (see [onTogglePane]).
  final bool showSupportingPane;

  /// Position of the supporting pane relative to [body].
  final SupportingPanePosition panePosition;

  /// Flex factor for the [body] in two-pane mode.
  final int bodyFlex;

  /// Flex factor for [supportingPane] in two-pane mode.
  final int paneFlex;

  /// Callback invoked on narrow windows when the caller should open or close
  /// the supporting pane (e.g. show a bottom sheet). On wide windows the layout
  /// handles visibility itself.
  final VoidCallback? onTogglePane;

  List<Widget> _buildPanes({
    required Widget body,
    required Widget pane,
    required bool showPane,
  }) {
    final bodyWidget = Expanded(flex: bodyFlex, child: body);
    if (!showPane) return [bodyWidget];

    final paneWidget = Expanded(
      flex: paneFlex,
      child: ContextualSwitcher(alignment: Alignment.topLeft, child: pane),
    );
    const divider = VerticalDivider(width: 1, thickness: 1);

    switch (panePosition) {
      case SupportingPanePosition.trailing:
        return [bodyWidget, divider, paneWidget];
      case SupportingPanePosition.leading:
        return [paneWidget, divider, bodyWidget];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, windowSizeClass) {
        if (windowSizeClass.isAtLeast(WindowSizeClass.expanded)) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildPanes(
              body: body,
              pane: supportingPane,
              showPane: showSupportingPane,
            ),
          );
        }

        // Narrow windows: body fills the width; the caller owns the pane
        // overlay (bottom sheet, modal side drawer, etc.).
        return body;
      },
    );
  }
}
