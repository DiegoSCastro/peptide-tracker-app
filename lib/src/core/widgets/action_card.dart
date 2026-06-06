import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_colors.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// Accent options for [ActionCard], mapped to the brand gradients.
enum ActionCardTone {
  /// Tech Blue gradient.
  blue,

  /// Energizing Orange gradient.
  orange,
}

/// Large, highly-rounded gradient action card with a frosted icon tile,
/// styled after the 2x2 quick-action grid in `docs/example/screen1.png`.
class ActionCard extends StatelessWidget {
  /// Creates an action card.
  const ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
    this.tone = ActionCardTone.blue,
    super.key,
  });

  /// Icon shown inside the frosted tile.
  final IconData icon;

  /// Action label.
  final String label;

  /// Tap handler.
  final VoidCallback onTap;

  /// Visual tone (blue or orange).
  final ActionCardTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradient = tone == ActionCardTone.blue
        ? AppColors.brandBlueGradient
        : AppColors.brandOrangeGradient;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F0061A4),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(AppRadii.sm + 2),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
