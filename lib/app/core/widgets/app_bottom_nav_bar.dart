import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Data model for a single bottom-nav item.
class AppNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String labelKey;
  final Color color;

  const AppNavItem({
    required this.icon,
    required this.activeIcon,
    required this.labelKey,
    required this.color,
  });
}

/// A fully animated custom bottom navigation bar.
/// Pass [items], [currentIndex] and an [onTap] handler from the parent.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<AppNavItem> items;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs    = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border(
          top: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.2), width: 0.8),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (i) => _NavItemTile(
                item: items[i],
                isSelected: currentIndex == i,
                onTap: () => onTap(i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Single Tile ──────────────────────────────────────────────────────────────

class _NavItemTile extends StatelessWidget {
  final AppNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItemTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    item.color.withValues(alpha: 0.15),
                    item.color.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? Border.all(color: item.color.withValues(alpha: 0.2))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AnimatedIcon(item: item, isSelected: isSelected, cs: cs),
            _AnimatedLabel(item: item, isSelected: isSelected, theme: theme),
          ],
        ),
      ),
    );
  }
}

class _AnimatedIcon extends StatelessWidget {
  final AppNavItem item;
  final bool isSelected;
  final ColorScheme cs;
  const _AnimatedIcon({required this.item, required this.isSelected, required this.cs});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Icon(
        isSelected ? item.activeIcon : item.icon,
        key: ValueKey(isSelected),
        color: isSelected ? item.color : cs.onSurfaceVariant.withValues(alpha: 0.5),
        size: isSelected ? 24.sp : 22.sp,
      ),
    );
  }
}

class _AnimatedLabel extends StatelessWidget {
  final AppNavItem item;
  final bool isSelected;
  final ThemeData theme;
  const _AnimatedLabel({required this.item, required this.isSelected, required this.theme});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: isSelected
          ? Row(
              children: [
                8.horizontalSpace,
                Text(
                  tr(item.labelKey),
                  style: TextStyle(
                    color: item.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
