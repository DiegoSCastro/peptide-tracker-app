import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_colors.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';
import 'package:peptide_tracker_app/src/core/design/app_typography.dart';

/// Builds the light and dark [ThemeData] from the "Vital Glass" tokens.
abstract final class AppTheme {
  /// Light theme.
  static ThemeData get light => _build(Brightness.light);

  /// Dark theme.
  static ThemeData get dark => _build(Brightness.dark);

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,
    tertiaryContainer: AppColors.tertiaryContainer,
    onTertiaryContainer: AppColors.onTertiaryContainer,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    surfaceContainerLowest: AppColors.surfaceContainerLowest,
    surfaceContainerLow: AppColors.surfaceContainerLow,
    surfaceContainer: AppColors.surfaceContainer,
    surfaceContainerHigh: AppColors.surfaceContainerHigh,
    surfaceContainerHighest: AppColors.surfaceContainerHighest,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    inverseSurface: AppColors.inverseSurface,
    onInverseSurface: AppColors.inverseOnSurface,
    inversePrimary: AppColors.inversePrimary,
    surfaceTint: AppColors.primary,
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.darkOnPrimaryContainer,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    secondaryContainer: AppColors.darkSecondaryContainer,
    onSecondaryContainer: AppColors.darkOnSecondaryContainer,
    tertiary: AppColors.darkTertiary,
    onTertiary: AppColors.darkOnTertiary,
    tertiaryContainer: AppColors.darkTertiaryContainer,
    onTertiaryContainer: AppColors.darkOnTertiaryContainer,
    error: AppColors.darkError,
    onError: AppColors.darkOnError,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    surfaceContainerLowest: AppColors.darkSurfaceContainerLowest,
    surfaceContainerLow: AppColors.darkSurfaceContainerLow,
    surfaceContainer: AppColors.darkSurfaceContainer,
    surfaceContainerHigh: AppColors.darkSurfaceContainerHigh,
    surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
    outline: AppColors.darkOutline,
    outlineVariant: AppColors.darkOutlineVariant,
    inverseSurface: AppColors.darkInverseSurface,
    onInverseSurface: AppColors.darkInverseOnSurface,
    inversePrimary: AppColors.darkInversePrimary,
    surfaceTint: AppColors.darkPrimaryContainer,
  );

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = isDark ? _darkScheme : _lightScheme;
    final textTheme = AppTypography.textTheme(brightness);

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
    );

    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[
        if (isDark) AppSemanticColors.dark else AppSemanticColors.light,
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        elevation: isDark ? 6 : 4,
        color: isDark
            ? colorScheme.surfaceContainer
            : colorScheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shadowColor: isDark
            ? const Color(0x66000000)
            : const Color(0x330061A4),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        space: AppSpacing.xl,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? colorScheme.surfaceContainerHigh
            : colorScheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm + 2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm + 2,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.xl),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: AppColors.onPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
    );
  }
}
