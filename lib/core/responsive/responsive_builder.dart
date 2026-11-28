import 'package:flutter/widgets.dart';
import 'package:flutter_material3_default/core/responsive/breakpoints.dart';

/// Signature of a function that builds a widget for a [WindowSizeClass].
typedef ResponsiveWidgetBuilder =
    Widget Function(BuildContext context, WindowSizeClass windowSizeClass);

/// Builds its child from the [WindowSizeClass] of the space it is given.
///
/// Unlike a `MediaQuery` check, the class is derived from this widget's own
/// layout constraints. That makes it correct inside side panes, split-screen
/// windows and resizable desktop windows.
///
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, windowSizeClass) {
///     return windowSizeClass == WindowSizeClass.compact
///         ? const SingleColumnLayout()
///         : const TwoColumnLayout();
///   },
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a widget that calls [builder] with the current window size class.
  const ResponsiveBuilder({required this.builder, super.key});

  /// Builds the widget for the current [WindowSizeClass].
  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    // Use the full window width from MediaQuery so that top-level layout
    // decisions (e.g. mobile pill vs. desktop header nav) are based on the
    // actual screen/window width, not the width of the nearest constrained
    // ancestor. This prevents a narrow LayoutBuilder constraint (e.g. inside
    // a Column or Dialog) from being misclassified as a compact window.
    final windowWidth = MediaQuery.sizeOf(context).width;
    return builder(context, WindowSizeClass.fromWidth(windowWidth));
  }
}
