import 'package:flutter/widgets.dart';
import 'package:flutter_material3_default/core/responsive/breakpoints.dart';

/// Convenience accessors for responsive information on a [BuildContext].
extension ResponsiveContextExtension on BuildContext {
  /// The [WindowSizeClass] of the whole window.
  ///
  /// Subscribes the calling widget to size changes. To respond to the space
  /// available to a smaller region of the screen, use `ResponsiveBuilder`
  /// instead.
  WindowSizeClass get windowSizeClass {
    return WindowSizeClass.fromWidth(MediaQuery.sizeOf(this).width);
  }
}
