import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// A compact metric tile showing a value with a label.
class StatChip extends StatelessWidget {
  /// Creates a stat chip.
  const StatChip({
    required this.label,
    required this.value,
    this.accent,
    super.key,
  });

  /// Caption shown under the value.
  final String label;

  /// Primary value text.
  final String value;

  /// Optional accent color for the value.
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(color: accent),
          ),
          const SizedBox(height: 2),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
