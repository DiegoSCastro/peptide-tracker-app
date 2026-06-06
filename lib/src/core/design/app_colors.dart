import 'package:flutter/material.dart';

/// Brand color tokens used to derive the Material color schemes.
abstract final class AppColors {
  /// Primary brand seed.
  static const Color brandSeed = Color(0xFF2E5BFF);

  /// Dark theme scaffold background.
  static const Color darkBackground = Color(0xFF0B1020);

  /// Light theme scaffold background.
  static const Color lightBackground = Color(0xFFF6F7FB);
}

/// Semantic colors not covered by [ColorScheme] (status, streaks, etc.).
///
/// Exposed as a [ThemeExtension] so widgets can read them via
/// `Theme.of(context).extension<AppSemanticColors>()`.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  /// Creates a semantic color set.
  const AppSemanticColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.streak,
  });

  /// Positive / completed state.
  final Color success;

  /// Attention / due-now state.
  final Color warning;

  /// Informational accent.
  final Color info;

  /// Streak / habit accent.
  final Color streak;

  /// Light-theme semantic palette.
  static const AppSemanticColors light = AppSemanticColors(
    success: Color(0xFF1E7B5A),
    warning: Color(0xFFB26B00),
    info: Color(0xFF2E5BFF),
    streak: Color(0xFFE2592B),
  );

  /// Dark-theme semantic palette.
  static const AppSemanticColors dark = AppSemanticColors(
    success: Color(0xFF4ED6A1),
    warning: Color(0xFFF4B740),
    info: Color(0xFF6E8BFF),
    streak: Color(0xFFFF8A4C),
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? streak,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      streak: streak ?? this.streak,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) {
      return this;
    }
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      streak: Color.lerp(streak, other.streak, t)!,
    );
  }
}
