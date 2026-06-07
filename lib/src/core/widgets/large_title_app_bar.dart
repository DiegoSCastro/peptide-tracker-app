import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A Cupertino large-title navigation bar (iOS-style) that shows an oversized
/// title at the top and collapses, staying docked, on scroll.
///
/// Place it as the first sliver inside a [CustomScrollView]. It is wrapped in a
/// [CupertinoTheme] derived from the Material brightness so its default colors
/// follow the app's light/dark mode.
class LargeTitleAppBar extends StatelessWidget {
  /// Creates a large-title sliver navigation bar.
  const LargeTitleAppBar({required this.title, this.actions, super.key});

  /// Title shown large at rest and compact when docked.
  final String title;

  /// Optional trailing actions (e.g. a settings button).
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trailing = (actions == null || actions!.isEmpty)
        ? null
        : Row(mainAxisSize: MainAxisSize.min, children: actions!);

    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: theme.brightness,
        primaryColor: theme.colorScheme.primary,
      ),
      child: CupertinoSliverNavigationBar(
        largeTitle: Text(title),
        trailing: trailing,
        automaticallyImplyLeading: false,
        transitionBetweenRoutes: false,
      ),
    );
  }
}
