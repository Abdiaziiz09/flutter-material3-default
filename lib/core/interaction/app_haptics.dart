import 'package:flutter/services.dart';
import 'package:flutter_material3_default/core/platform/app_platform.dart';

/// Semantic, platform-aware haptic feedback for touch interactions.
///
/// Haptics reinforce direct manipulation and meaningful state confirmations on
/// mobile devices (`Android` and `iOS`) while remaining a safe no-op on web and
/// desktop platforms. Use sparingly—reserve haptics for moments where physical
/// confirmation genuinely improves confidence.
abstract final class AppHaptics {
  /// Subtle tick for lightweight selection changes such as toggling a filter,
  /// stepping a slider or switching a segmented control.
  static Future<void> selection() async {
    if (!AppPlatform.isMobile) {
      return;
    }
    await HapticFeedback.selectionClick();
  }

  /// Light physical tap for primary tactile interactions or drag-snap moments.
  static Future<void> lightImpact() async {
    if (!AppPlatform.isMobile) {
      return;
    }
    await HapticFeedback.lightImpact();
  }

  /// Medium physical tap for notable completions such as saving, publishing or
  /// confirming an important action.
  static Future<void> confirm() async {
    if (!AppPlatform.isMobile) {
      return;
    }
    await HapticFeedback.mediumImpact();
  }
}
