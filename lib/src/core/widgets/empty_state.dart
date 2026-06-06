import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// A consistent empty/placeholder state with icon, copy, and optional action.
class EmptyState extends StatelessWidget {
  /// Creates an empty state.
  const EmptyState({
    required this.icon,
    required this.title,
    this.message,
    this.action,
    super.key,
  });

  /// Leading icon.
  final IconData icon;

  /// Headline text.
  final String title;

  /// Optional supporting text.
  final String? message;

  /// Optional call-to-action widget.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: theme.colorScheme.primary),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.md),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
