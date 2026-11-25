import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/motion/motion_priority.dart';
import 'package:flutter_material3_default/core/theme/app_motion.dart';
import 'package:flutter_material3_default/core/theme/app_radii.dart';

/// An interactive surface that provides subtle, organic tactile feedback on
/// press while preserving Material 3 ink ripples, hover highlights and keyboard
/// focus.
///
/// Use this to give clickable cards, tiles or custom controls a responsive
/// physical feel without adding distracting animations. When [onTap] is `null`,
/// the surface behaves as non-interactive. When reduced motion is enabled, the
/// scale micro-interaction is skipped automatically.
class TactileSurface extends StatefulWidget {
  /// Creates a tactile interactive surface.
  const TactileSurface({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.borderRadius = AppRadii.borderRadiusMedium,
    this.pressedScale = defaultPressedScale,
    this.tooltip,
    this.semanticLabel,
    super.key,
  }) : assert(
         pressedScale > 0 && pressedScale <= 1.0,
         'pressedScale must be in (0, 1.0].',
       );

  /// Default subtle scale factor applied while pressed.
  static const double defaultPressedScale = 0.985;

  /// Content rendered inside the interactive surface.
  final Widget child;

  /// Called when the user taps or activates the surface with a keyboard.
  final VoidCallback? onTap;

  /// Called when the user long-presses the surface.
  final VoidCallback? onLongPress;

  /// Corner radius used to clip the Material ink splash and hover overlay.
  final BorderRadius borderRadius;

  /// Scale factor applied while the pointer or key is actively pressing down.
  final double pressedScale;

  /// Optional tooltip shown on hover or long-press.
  final String? tooltip;

  /// Optional accessibility label for screen readers.
  final String? semanticLabel;

  @override
  State<TactileSurface> createState() => _TactileSurfaceState();
}

class _TactileSurfaceState extends State<TactileSurface> {
  bool _isPressed = false;

  void _setPressed(bool isPressed) {
    if (_isPressed == isPressed) {
      return;
    }
    setState(() {
      _isPressed = isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.onTap != null || widget.onLongPress != null;
    final motion = context.motion;
    final scaleDuration = motion.durationFor(
      context,
      motion.quick,
      priority: MotionPriority.standard,
    );
    final targetScale = isInteractive && _isPressed ? widget.pressedScale : 1.0;

    Widget content = AnimatedScale(
      scale: targetScale,
      duration: scaleDuration,
      curve: motion.emphasizedDecelerateCurve,
      child: Material(
        type: MaterialType.transparency,
        borderRadius: widget.borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          onHighlightChanged: isInteractive ? _setPressed : null,
          borderRadius: widget.borderRadius,
          child: widget.child,
        ),
      ),
    );

    final tooltipMessage = widget.tooltip;
    if (tooltipMessage != null) {
      content = Tooltip(message: tooltipMessage, child: content);
    }

    final label = widget.semanticLabel;
    if (label != null) {
      content = Semantics(button: isInteractive, label: label, child: content);
    }

    return content;
  }
}
