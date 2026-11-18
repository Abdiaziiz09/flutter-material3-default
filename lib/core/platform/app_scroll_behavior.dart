import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';

/// Scroll behaviour that works well with every input device.
///
/// Flutter's default behaviour does not let a mouse drag scrollable content,
/// which feels broken on desktop and web. This behaviour adds mouse dragging
/// while keeping the platform's native scroll physics and scrollbars.
class AppScrollBehavior extends MaterialScrollBehavior {
  /// Creates the application scroll behaviour.
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    ...super.dragDevices,
    PointerDeviceKind.mouse,
  };
}
