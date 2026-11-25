import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_material3_default/core/theme/app_radii.dart';

/// A calm, theme-aware placeholder block used while content is loading.
///
/// Preserves layout geometry so screens do not jump when real content arrives.
/// Gently pulses between container opacities when animations are enabled, and
/// renders as a static placeholder when `MediaQuery.disableAnimationsOf(context)`
/// is `true`.
class SkeletonBox extends StatefulWidget {
  /// Creates a loading skeleton placeholder.
  const SkeletonBox({
    this.width,
    required this.height,
    this.borderRadius = AppRadii.borderRadiusSmall,
    super.key,
  });

  /// Optional width of the placeholder. Expands to the parent's width when
  /// omitted.
  final double? width;

  /// Height of the placeholder, in logical pixels.
  final double height;

  /// Corner radius of the placeholder.
  final BorderRadius borderRadius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.defaults.slow * 2,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 0.5;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;

    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final opacity = 0.45 + (_controller.value * 0.4);
          return Opacity(opacity: opacity, child: child);
        },
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: widget.borderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
