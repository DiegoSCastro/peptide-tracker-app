import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_colors.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';

/// A single destination shown in [AppBottomNav].
class AppBottomNavItem {
  /// Creates a bottom-nav item.
  const AppBottomNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  /// Icon shown when the item is not selected.
  final IconData icon;

  /// Icon shown when the item is selected.
  final IconData selectedIcon;

  /// Visible label under the icon.
  final String label;
}

/// Custom bottom navigation styled after `docs/example/screen1.png`:
/// a rounded bar with always-visible labels and a raised central "+" button.
class AppBottomNav extends StatelessWidget {
  /// Creates the bottom navigation bar.
  const AppBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.onLog,
    super.key,
  });

  /// The four destinations (rendered two on each side of the "+").
  final List<AppBottomNavItem> items;

  /// Currently selected destination index.
  final int currentIndex;

  /// Called when a destination is tapped.
  final ValueChanged<int> onTap;

  /// Called when the central "+" button is tapped.
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? scheme.surfaceContainer
            : scheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? const Color(0x33000000) : AppColors.ambientShadow,
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: [
              _NavItem(
                item: items[0],
                selected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                item: items[1],
                selected: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _CenterButton(onTap: onLog),
              _NavItem(
                item: items[2],
                selected: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavItem(
                item: items[3],
                selected: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? item.selectedIcon : item.icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              item.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterButton extends StatelessWidget {
  const _CenterButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, -4),
          child: Semantics(
            button: true,
            label: 'Log',
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Ink(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.brandBlueGradient,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x332196F3),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: onTap,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
