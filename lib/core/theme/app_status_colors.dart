import 'package:flutter/material.dart';

/// Semantic status colours (`success`, `warning`, `info`) registered as a
/// [ThemeExtension] on [ThemeData].
///
/// Material 3's [ColorScheme] provides `error` out of the box, but real
/// applications also need accessible, theme-aware colours for confirmations,
/// warnings and neutral notices. Access these through `context.statusColors`
/// instead of hard-coding `Colors.green` or `Colors.orange`.
@immutable
class AppStatusColors extends ThemeExtension<AppStatusColors> {
  /// Creates a set of semantic status colours.
  const AppStatusColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
  });

  /// Light-mode semantic status colours with accessible contrast.
  static const AppStatusColors light = AppStatusColors(
    success: Color(0xFF1B6E2D),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFA3F5A9),
    onSuccessContainer: Color(0xFF002107),
    warning: Color(0xFF7D5700),
    onWarning: Color(0xFFFFFFFF),
    warningContainer: Color(0xFFFFDEAA),
    onWarningContainer: Color(0xFF271900),
    info: Color(0xFF0061A4),
    onInfo: Color(0xFFFFFFFF),
    infoContainer: Color(0xFFD1E4FF),
    onInfoContainer: Color(0xFF001D36),
  );

  /// Dark-mode semantic status colours with accessible contrast.
  static const AppStatusColors dark = AppStatusColors(
    success: Color(0xFF88D98E),
    onSuccess: Color(0xFF003910),
    successContainer: Color(0xFF00531B),
    onSuccessContainer: Color(0xFFA3F5A9),
    warning: Color(0xFFF6BE48),
    onWarning: Color(0xFF422C00),
    warningContainer: Color(0xFF5F4100),
    onWarningContainer: Color(0xFFFFDEAA),
    info: Color(0xFF9ECAFF),
    onInfo: Color(0xFF003258),
    infoContainer: Color(0xFF00497D),
    onInfoContainer: Color(0xFFD1E4FF),
  );

  /// Foreground / accent colour for positive outcomes.
  final Color success;

  /// Contrast-paired foreground colour on [success].
  final Color onSuccess;

  /// Soft container background for positive status banners and badges.
  final Color successContainer;

  /// Contrast-paired foreground colour on [successContainer].
  final Color onSuccessContainer;

  /// Foreground / accent colour for cautionary states.
  final Color warning;

  /// Contrast-paired foreground colour on [warning].
  final Color onWarning;

  /// Soft container background for warning banners and badges.
  final Color warningContainer;

  /// Contrast-paired foreground colour on [warningContainer].
  final Color onWarningContainer;

  /// Foreground / accent colour for neutral informational states.
  final Color info;

  /// Contrast-paired foreground colour on [info].
  final Color onInfo;

  /// Soft container background for informational banners and badges.
  final Color infoContainer;

  /// Contrast-paired foreground colour on [infoContainer].
  final Color onInfoContainer;

  @override
  AppStatusColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
  }) {
    return AppStatusColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
    );
  }

  @override
  AppStatusColors lerp(
    covariant ThemeExtension<AppStatusColors>? other,
    double t,
  ) {
    if (other is! AppStatusColors) {
      return this;
    }
    return AppStatusColors(
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t) ??
          successContainer,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t) ??
          onSuccessContainer,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t) ??
          warningContainer,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t) ??
          onWarningContainer,
      info: Color.lerp(info, other.info, t) ?? info,
      onInfo: Color.lerp(onInfo, other.onInfo, t) ?? onInfo,
      infoContainer:
          Color.lerp(infoContainer, other.infoContainer, t) ?? infoContainer,
      onInfoContainer:
          Color.lerp(onInfoContainer, other.onInfoContainer, t) ??
          onInfoContainer,
    );
  }
}

/// Convenience accessor for [AppStatusColors] on a [BuildContext].
extension StatusColorsContextExtension on BuildContext {
  /// Returns the [AppStatusColors] extension from the nearest [Theme], falling
  /// back to [AppStatusColors.light] or [AppStatusColors.dark] by brightness.
  AppStatusColors get statusColors {
    final theme = Theme.of(this);
    return theme.extension<AppStatusColors>() ??
        (theme.brightness == Brightness.dark
            ? AppStatusColors.dark
            : AppStatusColors.light);
  }
}
