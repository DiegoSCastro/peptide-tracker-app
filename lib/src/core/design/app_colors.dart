import 'package:flutter/material.dart';

/// Brand color tokens for the "Vital Glass" design system.
///
/// The light palette mirrors `docs/example/DESIGN.md`; the dark palette is
/// derived from the same accent hues (see `docs/example/screen2.png`).
abstract final class AppColors {
  // --- Light scheme -------------------------------------------------------
  /// Tech Blue primary.
  static const Color primary = Color(0xFF0061A4);

  /// On primary.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Brighter primary used for fills and gradients.
  static const Color primaryContainer = Color(0xFF2196F3);

  /// On primary container.
  static const Color onPrimaryContainer = Color(0xFF002C4F);

  /// Energizing Orange secondary.
  static const Color secondary = Color(0xFF8B5000);

  /// On secondary.
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Orange container used for highlight fills and gradients.
  static const Color secondaryContainer = Color(0xFFFF9800);

  /// On secondary container.
  static const Color onSecondaryContainer = Color(0xFF653900);

  /// Bio-Teal tertiary.
  static const Color tertiary = Color(0xFF006876);

  /// On tertiary.
  static const Color onTertiary = Color(0xFFFFFFFF);

  /// Teal container.
  static const Color tertiaryContainer = Color(0xFF00A0B5);

  /// On tertiary container.
  static const Color onTertiaryContainer = Color(0xFF003037);

  /// Error.
  static const Color error = Color(0xFFBA1A1A);

  /// On error.
  static const Color onError = Color(0xFFFFFFFF);

  /// Error container.
  static const Color errorContainer = Color(0xFFFFDAD6);

  /// On error container.
  static const Color onErrorContainer = Color(0xFF93000A);

  /// Soft slate app background / surface.
  static const Color surface = Color(0xFFF6FAFE);

  /// On surface (near-black ink).
  static const Color onSurface = Color(0xFF171C1F);

  /// On surface variant (muted ink).
  static const Color onSurfaceVariant = Color(0xFF404752);

  /// Lowest container (clean white cards).
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);

  /// Low container.
  static const Color surfaceContainerLow = Color(0xFFF0F4F8);

  /// Container.
  static const Color surfaceContainer = Color(0xFFEAEEF2);

  /// High container.
  static const Color surfaceContainerHigh = Color(0xFFE4E9ED);

  /// Highest container.
  static const Color surfaceContainerHighest = Color(0xFFDFE3E7);

  /// Outline.
  static const Color outline = Color(0xFF707883);

  /// Outline variant.
  static const Color outlineVariant = Color(0xFFBFC7D4);

  /// Inverse surface.
  static const Color inverseSurface = Color(0xFF2C3134);

  /// Inverse on surface.
  static const Color inverseOnSurface = Color(0xFFEDF1F5);

  /// Inverse primary.
  static const Color inversePrimary = Color(0xFF9ECAFF);

  // --- Dark scheme --------------------------------------------------------
  /// Dark primary.
  static const Color darkPrimary = Color(0xFF9ECAFF);

  /// Dark on primary.
  static const Color darkOnPrimary = Color(0xFF003258);

  /// Dark primary container (vibrant blue used in gradients).
  static const Color darkPrimaryContainer = Color(0xFF2196F3);

  /// Dark on primary container.
  static const Color darkOnPrimaryContainer = Color(0xFFD1E4FF);

  /// Dark secondary.
  static const Color darkSecondary = Color(0xFFFFB870);

  /// Dark on secondary.
  static const Color darkOnSecondary = Color(0xFF472A00);

  /// Dark secondary container (orange gradient anchor).
  static const Color darkSecondaryContainer = Color(0xFFFF9800);

  /// Dark on secondary container.
  static const Color darkOnSecondaryContainer = Color(0xFF2C1600);

  /// Dark tertiary.
  static const Color darkTertiary = Color(0xFF44D8F1);

  /// Dark on tertiary.
  static const Color darkOnTertiary = Color(0xFF001F25);

  /// Dark tertiary container.
  static const Color darkTertiaryContainer = Color(0xFF00A0B5);

  /// Dark on tertiary container.
  static const Color darkOnTertiaryContainer = Color(0xFFA1EFFF);

  /// Dark error.
  static const Color darkError = Color(0xFFFFB4AB);

  /// Dark on error.
  static const Color darkOnError = Color(0xFF690005);

  /// Dark scaffold background / surface.
  static const Color darkSurface = Color(0xFF0B1020);

  /// Dark on surface.
  static const Color darkOnSurface = Color(0xFFE2E6EB);

  /// Dark on surface variant.
  static const Color darkOnSurfaceVariant = Color(0xFFAEB6C2);

  /// Dark lowest container.
  static const Color darkSurfaceContainerLowest = Color(0xFF080B16);

  /// Dark low container.
  static const Color darkSurfaceContainerLow = Color(0xFF12182A);

  /// Dark container (card surface).
  static const Color darkSurfaceContainer = Color(0xFF161D31);

  /// Dark high container.
  static const Color darkSurfaceContainerHigh = Color(0xFF1F273D);

  /// Dark highest container.
  static const Color darkSurfaceContainerHighest = Color(0xFF293149);

  /// Dark outline.
  static const Color darkOutline = Color(0xFF8A93A0);

  /// Dark outline variant.
  static const Color darkOutlineVariant = Color(0xFF3A4252);

  /// Dark inverse surface.
  static const Color darkInverseSurface = Color(0xFFE2E6EB);

  /// Dark inverse on surface.
  static const Color darkInverseOnSurface = Color(0xFF2C3134);

  /// Dark inverse primary.
  static const Color darkInversePrimary = Color(0xFF0061A4);

  // --- Brand gradients ----------------------------------------------------
  /// Blue action-card gradient.
  static const LinearGradient brandBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF35A0F6), Color(0xFF0061A4)],
  );

  /// Orange action-card gradient.
  static const LinearGradient brandOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFB35C), Color(0xFFF57C00)],
  );

  /// Ambient blue shadow used to make cards levitate.
  static const Color ambientShadow = Color(0x142196F3);
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

  /// Positive / completed / on-track state.
  final Color success;

  /// Attention / due-now state.
  final Color warning;

  /// Informational accent.
  final Color info;

  /// Streak / habit accent.
  final Color streak;

  /// Light-theme semantic palette.
  static const AppSemanticColors light = AppSemanticColors(
    success: Color(0xFF006876),
    warning: Color(0xFFF57C00),
    info: Color(0xFF0061A4),
    streak: Color(0xFFF57C00),
  );

  /// Dark-theme semantic palette.
  static const AppSemanticColors dark = AppSemanticColors(
    success: Color(0xFF44D8F1),
    warning: Color(0xFFFFB870),
    info: Color(0xFF9ECAFF),
    streak: Color(0xFFFFB870),
  );

  /// Safe accessor that falls back to [light] when the extension is missing
  /// (for example in tests that build a screen without the app theme).
  static AppSemanticColors of(BuildContext context) {
    return Theme.of(context).extension<AppSemanticColors>() ?? light;
  }

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
