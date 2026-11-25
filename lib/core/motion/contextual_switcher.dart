import 'package:flutter/widgets.dart';
import 'package:flutter_material3_default/core/motion/motion_priority.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';

/// Smoothly transitions between [child] widgets when their keys or types change,
/// while automatically respecting platform reduced-motion settings.
///
/// Use this for state transitions (such as loading → content → empty/error)
/// where a sudden swap feels jarring, without introducing distracting spatial
/// jumps. When `MediaQuery.disableAnimationsOf(context)` is `true`, the switch
/// happens instantaneously ([Duration.zero]).
class ContextualSwitcher extends StatelessWidget {
  /// Creates a context-aware animated switcher.
  const ContextualSwitcher({
    required this.child,
    this.duration,
    this.priority = MotionPriority.standard,
    this.alignment = Alignment.center,
    super.key,
  });

  /// The widget currently displayed. Give distinct states different `Key`s so
  /// transitions trigger reliably.
  final Widget child;

  /// Optional override for the transition duration. Defaults to
  /// `context.motion.standard`.
  final Duration? duration;

  /// Functional priority of this transition.
  final MotionPriority priority;

  /// Alignment applied to the incoming and outgoing children during transition.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final motion = context.motion;
    final resolvedDuration = motion.durationFor(
      context,
      duration ?? motion.standard,
      priority: priority,
    );

    return AnimatedSwitcher(
      duration: resolvedDuration,
      reverseDuration: resolvedDuration,
      switchInCurve: motion.emphasizedDecelerateCurve,
      switchOutCurve: motion.emphasizedAccelerateCurve,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: alignment,
          children: [...previousChildren, ?currentChild],
        );
      },
      child: child,
    );
  }
}
