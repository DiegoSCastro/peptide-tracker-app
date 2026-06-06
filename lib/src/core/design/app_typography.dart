import 'package:flutter/material.dart';

/// Typography for the "Vital Glass" design system.
///
/// Mirrors the type scale in `docs/example/DESIGN.md`. The Inter family is not
/// bundled, so the scale (size / weight / spacing / line-height) is applied on
/// top of the platform default font for an Inter-like, data-dense feel.
abstract final class AppTypography {
  /// Builds the text theme for the given [brightness].
  static TextTheme textTheme(Brightness brightness) {
    final ink = brightness == Brightness.dark
        ? const Color(0xFFE2E6EB)
        : const Color(0xFF171C1F);

    return TextTheme(
      // display-lg: hero headings (e.g. "Today").
      displayLarge: TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.9,
        height: 1.05,
        color: ink,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        height: 1.1,
        color: ink,
      ),
      // headline-lg.
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        height: 1.2,
        color: ink,
      ),
      // headline-lg-mobile.
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.2,
        color: ink,
      ),
      // headline-md.
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: ink,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: ink,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: ink,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: ink,
      ),
      // body-lg.
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: ink,
      ),
      // body-sm.
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: ink,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: ink,
      ),
      // label-caps.
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: ink,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: ink,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: ink,
      ),
    );
  }
}
