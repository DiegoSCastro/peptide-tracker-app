import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// A frosted chip with a colored status dot (e.g. "On Track", "Due now").
class StatusChip extends StatelessWidget {
  /// Creates a status chip.
  const StatusChip({required this.label, required this.color, super.key});

  /// Chip text.
  final String label;

  /// Dot color signalling the status.
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs + 2,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
