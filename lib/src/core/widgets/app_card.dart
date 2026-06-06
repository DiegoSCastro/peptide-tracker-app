import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// A padded card with consistent radius and an optional tap action.
class AppCard extends StatelessWidget {
  /// Creates an app card.
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    super.key,
  });

  /// Card contents.
  final Widget child;

  /// Optional tap handler; when set the card shows a press ripple.
  final VoidCallback? onTap;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
