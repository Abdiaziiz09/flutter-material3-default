import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/motion/contextual_switcher.dart';
import 'package:flutter_material3_default/core/responsive/breakpoints.dart';
import 'package:flutter_material3_default/core/responsive/responsive_builder.dart';

/// Canonical Material 3 adaptive layout for list-detail interfaces.
///
/// On [WindowSizeClass.compact] and [WindowSizeClass.medium] windows, either
/// [list] or [detail] is shown (controlled by [showDetail]), with a smooth
/// [ContextualSwitcher] transition. On [WindowSizeClass.expanded] and wider
/// windows, both panes are shown side by side separated by a vertical divider.
class ListDetailLayout extends StatelessWidget {
  /// Creates an adaptive list-detail layout.
  const ListDetailLayout({
    required this.list,
    required this.detail,
    this.showDetail = false,
    this.emptyDetail,
    this.listFlex = 2,
    this.detailFlex = 3,
    super.key,
  }) : assert(listFlex > 0, 'listFlex must be positive.'),
       assert(detailFlex > 0, 'detailFlex must be positive.');

  /// Primary list or master pane.
  final Widget list;

  /// Detail pane shown when an item is selected.
  final Widget detail;

  /// Whether a detail item is currently active.
  ///
  /// On narrow windows (`compact` and `medium`), `true` shows [detail] and
  /// `false` shows [list]. On wide windows (`expanded` and up), `false` shows
  /// [emptyDetail] if provided, or [detail] otherwise.
  final bool showDetail;

  /// Optional placeholder shown in the detail pane on wide windows when
  /// [showDetail] is `false`.
  final Widget? emptyDetail;

  /// Flex factor for the [list] pane in two-pane mode.
  final int listFlex;

  /// Flex factor for the [detail] pane in two-pane mode.
  final int detailFlex;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, windowSizeClass) {
        if (windowSizeClass.isAtLeast(WindowSizeClass.expanded)) {
          final resolvedDetail = showDetail ? detail : (emptyDetail ?? detail);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: listFlex, child: list),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(
                flex: detailFlex,
                child: ContextualSwitcher(
                  alignment: Alignment.topLeft,
                  child: resolvedDetail,
                ),
              ),
            ],
          );
        }

        return ContextualSwitcher(
          alignment: Alignment.topLeft,
          child: showDetail ? detail : list,
        );
      },
    );
  }
}
