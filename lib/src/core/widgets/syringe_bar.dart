import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_colors.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// A simple horizontal syringe visual: a barrel filled proportionally to the
/// draw volume against the selected syringe size.
///
/// Purely a visual aid for user-entered math. It does not recommend a dose.
class SyringeBar extends StatelessWidget {
  /// Creates a syringe bar.
  const SyringeBar({
    required this.volumeMl,
    required this.syringeSizeMl,
    super.key,
  });

  /// Volume to draw, in milliliters (user-derived).
  final double volumeMl;

  /// Selected syringe capacity, in milliliters.
  final double syringeSizeMl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clampedFraction = syringeSizeMl <= 0
        ? 0.0
        : (volumeMl / syringeSizeMl).clamp(0.0, 1.0);
    final units = volumeMl * 100;
    final overCapacity = volumeMl > syringeSizeMl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: Stack(
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
              ),
              FractionallySizedBox(
                widthFactor: clampedFraction,
                child: Container(
                  height: 28,
                  decoration: const BoxDecoration(
                    gradient: AppColors.brandBlueGradient,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          overCapacity
              ? 'Draw exceeds the ${_trim(syringeSizeMl)} mL syringe'
              : 'Draw ${_trim(volumeMl)} mL '
                    '(≈ ${units.round()} units on a '
                    '${_trim(syringeSizeMl)} mL syringe)',
          style: theme.textTheme.bodySmall?.copyWith(
            color: overCapacity
                ? theme.colorScheme.error
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _trim(double value) {
    final fixed = value.toStringAsFixed(2);
    return fixed
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
}
