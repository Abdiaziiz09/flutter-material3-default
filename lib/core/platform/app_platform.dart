import 'package:flutter/foundation.dart';

/// Web-safe platform detection.
///
/// Shared UI code must never import `dart:io`, because it is unavailable on
/// Flutter Web. Use these getters instead, which rely only on
/// [defaultTargetPlatform] and [kIsWeb].
abstract final class AppPlatform {
  /// Whether the application runs in a web browser.
  static bool get isWeb => kIsWeb;

  /// Whether the application runs as a native Android or iOS app.
  static bool get isMobile {
    return !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);
  }

  /// Whether the application runs as a native Windows, macOS or Linux app.
  static bool get isDesktop {
    return !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux);
  }
}
