import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/doctors_controller.dart';
import 'widgets/doctor_card.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (ctx, _) => [
          SliverToBoxAdapter(child: _DoctorsHeader()),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchAndFilterDelegate(),
          ),
        ],
        body: Obx(() {
          final list = controller.displayedDoctors;
          if (list.isEmpty) {
            return _EmptyState();
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 100.h),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, __) => 12.verticalSpace,
            itemBuilder: (_, i) => DoctorCard(
              doctor: list[i],
              onTap: () => controller.goToDoctorDetails(list[i]),
              onToggleStatus: () => controller.toggleStatus(list[i].id!),
            ),
          );
        }),
      ),
      floatingActionButton: _AddDoctorFab(),
    );
  }
}

class _DoctorsHeader extends GetView<DoctorsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child:
                    Icon(Icons.people_rounded, color: Colors.white, size: 26.sp),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الأطباء',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Obx(() {
                      final total = controller.allDoctors.length;
                      final active = controller.allDoctors
                          .where((d) => d.isAvailable)
                          .length;
                      return Text(
                        '$total طبيب • $active متاح الآن',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Obx(() {
                final total = controller.allDoctors.length;
                final inactive =
                    controller.allDoctors.where((d) => !d.isAvailable).length;
                return Row(
                  children: [
                    _MiniStat(count: total, label: 'إجمالي', theme: theme),
                    8.horizontalSpace,
                    _MiniStat(
                        count: inactive, label: 'غير متاح', theme: theme),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final int count;
  final String label;
  final ThemeData theme;
  const _MiniStat(
      {required this.count, required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text('$count',
              style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white, fontWeight: FontWeight.w900)),
          Text(label,
              style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 9.sp)),
        ],
      ),
    );
  }
}

class _SearchAndFilterDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 56 + ScreenUtil().setHeight(40);
  @override
  double get maxExtent => 56 + ScreenUtil().setHeight(40);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final cs = Theme.of(context).colorScheme;
    return ColoredBox(
      color: cs.surface,
      child: const Column(
        children: [
          _SearchBar(),
          _SpecialtyFilters(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

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
                fontSize: 14.sp),
            prefixIcon:
                Icon(Icons.search_rounded, color: cs.onSurfaceVariant, size: 20.sp),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
      ),
    );
  }
}

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
              theme: theme,
              cs: cs,
            ),
            ...specialties.map((s) {
              final color = DoctorsController.specialtyColor(s);
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: _SpecialtyChip(
                  label: s,
                  selected: selected == s,
                  color: color,
                  onTap: () => controller.filterBySpecialty(s),
                  theme: theme,
                  cs: cs,
                ),
              );
            }),
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
  final ThemeData theme;
  final ColorScheme cs;

  const _SpecialtyChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    colors: [color.withValues(alpha: 0.85), color])
                : null,
            color: selected ? null : cs.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? Colors.transparent : cs.outlineVariant.withValues(alpha: 0.5),
            ),
            boxShadow: selected
                ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))]
                : [],
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected ? Colors.white : cs.onSurfaceVariant.withValues(alpha: 0.8),
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90.r,
            height: 90.r,
            decoration: BoxDecoration(
              color: const Color(0xFF3949AB).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_search_rounded,
                size: 44.sp,
                color: const Color(0xFF3949AB).withValues(alpha: 0.5)),
          ),
          20.verticalSpace,
          Text('لا يوجد أطباء',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          10.verticalSpace,
          Text('حاول تغيير كلمة البحث أو الفلتر',
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant.withValues(alpha: 0.7))),
        ],
      ),
    );
  }
}

class _AddDoctorFab extends GetView<DoctorsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3949AB).withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.goToAddDoctor,
          borderRadius: BorderRadius.circular(18.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person_add_rounded, color: Colors.white, size: 22.sp),
                8.horizontalSpace,
                Text('إضافة طبيب',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
