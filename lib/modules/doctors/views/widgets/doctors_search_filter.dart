import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/doctors_controller.dart';

/// Pinned search-bar + specialty chips — use directly in NestedScrollView.headerSliverBuilder.
class DoctorsSearchFilter extends StatelessWidget {
  const DoctorsSearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SearchFilterDelegate(),
    );
  }
}

// ─── Delegate ─────────────────────────────────────────────────────────────────

class _SearchFilterDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 56 + ScreenUtil().setHeight(10);

  @override
  double get maxExtent => 56 + ScreenUtil().setHeight(70);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: const Column(children: [_SearchBar(), _SpecialtyFilters()]),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate _) => false;
}

// ─── Search Bar ───────────────────────────────────────────────────────────────

class _SearchBar extends GetView<DoctorsController> {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 6.h),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
        ),
        child: TextField(
          controller: controller.searchController,
          onChanged: controller.runSearch,
          decoration: InputDecoration(
            hintText: 'ابحث عن طبيب أو تخصص...',
            hintStyle: TextStyle(
              color: cs.onSurfaceVariant.withValues(alpha: 0.5),
              fontSize: 14.sp,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: cs.onSurfaceVariant,
              size: 20.sp,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Specialty Filter Chips ───────────────────────────────────────────────────

class _SpecialtyFilters extends GetView<DoctorsController> {
  const _SpecialtyFilters();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Obx(() {
      final specialties = controller.specialties;
      final selected = controller.selectedSpecialty.value;

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        child: Row(
          children: [
            _SpecialtyChip(
              label: 'الكل',
              selected: selected.isEmpty,
              color: const Color(0xFF3949AB),
              onTap: () => controller.filterBySpecialty(''),
            ),
            ...specialties.map(
              (s) => Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: _SpecialtyChip(
                  label: s,
                  selected: selected == s,
                  color: DoctorsController.specialtyColor(s),
                  onTap: () => controller.filterBySpecialty(s),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SpecialtyChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _SpecialtyChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          alignment: AlignmentDirectional.center,
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(colors: [color.withValues(alpha: 0.85), color])
                : null,
            color: selected
                ? null
                : cs.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected
                  ? Colors.transparent
                  : cs.outlineVariant.withValues(alpha: 0.5),
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected
                  ? Colors.white
                  : cs.onSurfaceVariant.withValues(alpha: 0.8),
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
