import 'package:flutter/material.dart';

/// A section title with an optional trailing action.
class SectionHeader extends StatelessWidget {
  /// Creates a section header.
  const SectionHeader({required this.title, this.action, super.key});

  /// Section title text.
  final String title;

  /// Optional trailing action (e.g. a "See all" button).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(title, style: theme.textTheme.titleMedium),
        ),
        if (action != null) action!,
      ],
    );
  }
}
