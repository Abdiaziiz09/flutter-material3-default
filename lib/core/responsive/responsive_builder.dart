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
    return LayoutBuilder(
      builder: (context, constraints) {
        // An unbounded width reports infinity, which classifies as the largest
        // class; that is the safest assumption for unconstrained parents.
        return builder(
          context,
          WindowSizeClass.fromWidth(constraints.maxWidth),
        );
      },
    );
  }
}
