import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/motion/motion_priority.dart';

/// Material 3–aligned timing and easing tokens registered on [ThemeData].
///
/// Read these tokens through `context.motion` (or
/// `Theme.of(context).extension<AppMotion>()`) instead of hard-coding
/// `Duration` and `Curve` literals across feature widgets.
///
/// Always resolve durations with [durationFor] so reduced-motion accessibility
/// settings (`MediaQuery.disableAnimationsOf(context)`) are respected
/// automatically.
@immutable
class AppMotion extends ThemeExtension<AppMotion> {
  /// Creates a set of motion tokens.
  const AppMotion({
    required this.instant,
    required this.quick,
    required this.standard,
    required this.emphasized,
    required this.slow,
    required this.standardCurve,
    required this.emphasizedCurve,
    required this.emphasizedDecelerateCurve,
    required this.emphasizedAccelerateCurve,
  });

  /// Default Material 3–aligned motion tokens.
  static const AppMotion defaults = AppMotion(
    instant: Duration.zero,
    quick: Duration(milliseconds: 100),
    standard: Duration(milliseconds: 250),
    emphasized: Duration(milliseconds: 400),
    slow: Duration(milliseconds: 500),
    standardCurve: Curves.easeInOutCubic,
    emphasizedCurve: Curves.easeInOutCubicEmphasized,
    emphasizedDecelerateCurve: Cubic(0.05, 0.7, 0.1, 1.0),
    emphasizedAccelerateCurve: Cubic(0.3, 0.0, 0.8, 0.15),
  );

  /// Zero duration for immediate state updates or reduced-motion fallbacks.
  final Duration instant;

  /// 100 ms. Micro-interactions: hover highlights, tactile press feedback.
  final Duration quick;

  /// 250 ms. Standard state changes, switches, inline reveals and fades.
  final Duration standard;

  /// 400 ms. Spatial transitions, pane changes and prominent layout shifts.
  final Duration emphasized;

  /// 500 ms. Large structural transitions that benefit from clear continuity.
  final Duration slow;

  /// Balanced curve for symmetric state transitions and cross-fades.
  final Curve standardCurve;

  /// Expressive Material 3 curve for spatial and layout transitions.
  final Curve emphasizedCurve;

  /// Deceleration curve for elements entering the screen or settling in place.
  final Curve emphasizedDecelerateCurve;

  /// Acceleration curve for elements leaving the screen.
  final Curve emphasizedAccelerateCurve;

  /// Resolves [baseDuration] for [context], returning [instant] when the user
  /// has disabled animations in platform accessibility settings.
  Duration durationFor(
    BuildContext context,
    Duration baseDuration, {
    MotionPriority priority = MotionPriority.standard,
  }) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return switch (priority) {
        MotionPriority.essential => instant,
        MotionPriority.standard => instant,
        MotionPriority.decorative => instant,
      };
    }
    return baseDuration;
  }

  /// Returns whether non-essential motion should run in [context].
  bool shouldAnimate(
    BuildContext context, {
    MotionPriority priority = MotionPriority.standard,
  }) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return false;
    }
    return priority != MotionPriority.decorative ||
        !MediaQuery.disableAnimationsOf(context);
  }

  @override
  AppMotion copyWith({
    Duration? instant,
    Duration? quick,
    Duration? standard,
    Duration? emphasized,
    Duration? slow,
    Curve? standardCurve,
    Curve? emphasizedCurve,
    Curve? emphasizedDecelerateCurve,
    Curve? emphasizedAccelerateCurve,
  }) {
    return AppMotion(
      instant: instant ?? this.instant,
      quick: quick ?? this.quick,
      standard: standard ?? this.standard,
      emphasized: emphasized ?? this.emphasized,
      slow: slow ?? this.slow,
      standardCurve: standardCurve ?? this.standardCurve,
      emphasizedCurve: emphasizedCurve ?? this.emphasizedCurve,
      emphasizedDecelerateCurve:
          emphasizedDecelerateCurve ?? this.emphasizedDecelerateCurve,
      emphasizedAccelerateCurve:
          emphasizedAccelerateCurve ?? this.emphasizedAccelerateCurve,
    );
  }

  @override
  AppMotion lerp(covariant ThemeExtension<AppMotion>? other, double t) {
    if (other is! AppMotion) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

/// Convenience accessor for [AppMotion] on a [BuildContext].
extension MotionContextExtension on BuildContext {
  /// Returns the [AppMotion] extension from the nearest [Theme], falling back
  /// to [AppMotion.defaults] if none is registered.
  AppMotion get motion {
    return Theme.of(this).extension<AppMotion>() ?? AppMotion.defaults;
  }
}
