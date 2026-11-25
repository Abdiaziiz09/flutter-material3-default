import 'package:flutter/widgets.dart';
import 'package:flutter_material3_default/core/motion/motion_priority.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';

/// Smoothly expands or collapses [child] vertically and fades its contents.
///
/// Use this for progressive disclosure (for example, inline details, advanced
/// filters or validation hints) where revealing content in place preserves
/// spatial context. When `MediaQuery.disableAnimationsOf(context)` is `true`,
/// expansion and collapse happen instantaneously.
class SmoothExpandable extends StatelessWidget {
  /// Creates an expandable container.
  const SmoothExpandable({
    required this.isExpanded,
    required this.child,
    this.duration,
    this.priority = MotionPriority.standard,
    this.alignment = Alignment.topCenter,
    super.key,
  });

  /// Whether [child] is currently visible and expanded.
  final bool isExpanded;

  /// Content shown when [isExpanded] is `true`.
  final Widget child;

  /// Optional override for the expand/collapse duration. Defaults to
  /// `context.motion.standard`.
  final Duration? duration;

  /// Functional priority of this transition.
  final MotionPriority priority;

  /// Alignment of [child] while its size animates.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final motion = context.motion;
    final resolvedDuration = motion.durationFor(
      context,
      duration ?? motion.standard,
      priority: priority,
    );

    return ClipRect(
      child: AnimatedSize(
        duration: resolvedDuration,
        curve: motion.emphasizedCurve,
        alignment: alignment,
        child: AnimatedOpacity(
          opacity: isExpanded ? 1 : 0,
          duration: resolvedDuration,
          curve: motion.standardCurve,
          child: isExpanded ? child : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
