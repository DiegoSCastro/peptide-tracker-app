import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_colors.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// Builds the light and dark [ThemeData] from the design tokens.
abstract final class AppTheme {
  /// Light theme.
  static ThemeData get light => _build(Brightness.light);

  /// Dark theme.
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandSeed,
      brightness: brightness,
    );
    final background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
    );

    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[
        if (isDark) AppSemanticColors.dark else AppSemanticColors.light,
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: colorScheme.surfaceContainerHigh,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark
            ? colorScheme.surfaceContainer
            : colorScheme.surface,
        elevation: 0,
        height: 68,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: colorScheme.secondaryContainer,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 2,
      ),
    );
  }
}
