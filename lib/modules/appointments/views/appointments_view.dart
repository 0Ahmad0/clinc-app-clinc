import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/colors/status_colors.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../controllers/appointments_controller.dart';
import 'widgets/appointment_card_widget.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (ctx, innerScrolled) => [
          SliverToBoxAdapter(child: _AppHeader()),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(),
          ),
        ],
        body: Obx(() {
          final list = controller.filtered;

          if (list.isEmpty) {
            return _EmptyState(filter: controller.filter.value);
          }

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, __) => 14.verticalSpace,
            itemBuilder: (_, i) => AppointmentCardWidget(item: list[i]),
          );
        }),
      ),
      floatingActionButton: _AddFab(),
    );
  }
}

class _AppHeader extends GetView<AppointmentsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00695C), Color(0xFF009688), Color(0xFF26A69A)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                      size: 26.sp,
                    ),
                  ),
                  14.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المواعيد',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Obx(() {
                          final total = Get.find<AppointmentsController>().items.length;
                          final pending = Get.find<AppointmentsController>()
                              .items
                              .where((e) => e.status == AppointmentStatus.pending)
                              .length;
                          return Text(
                            '$total موعد • $pending قيد المراجعة',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  _StatsRow(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends GetView<AppointmentsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final approved = controller.items
          .where((e) => e.status == AppointmentStatus.approved)
          .length;
      final completed = controller.items
          .where((e) => e.status == AppointmentStatus.completed)
          .length;
      return Row(
        children: [
          _MiniStat(
            count: approved,
            label: 'مؤكد',
            color: const Color(0xFF80CBC4),
            theme: theme,
          ),
          8.horizontalSpace,
          _MiniStat(
            count: completed,
            label: 'مكتمل',
            color: const Color(0xFFA5D6A7),
            theme: theme,
          ),
        ],
      );
    });
  }
}

class _MiniStat extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  final ThemeData theme;

  const _MiniStat({
    required this.count,
    required this.label,
    required this.color,
    required this.theme,
  });

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
          Text(
            '$count',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 64;
  @override
  double get maxExtent => 64;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final cs = Theme.of(context).colorScheme;
    final isScrolled = shrinkOffset > 0;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: const _FilterTabs(),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _FilterTabs extends GetView<AppointmentsController> {
  const _FilterTabs();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final tabs = [
      _TabItem(label: 'الكل', status: null, icon: Icons.apps_rounded),
      _TabItem(
        label: 'قيد المراجعة',
        status: AppointmentStatus.pending,
        icon: Icons.pending_actions_rounded,
      ),
      _TabItem(
        label: 'المؤكد',
        status: AppointmentStatus.approved,
        icon: Icons.check_circle_outline_rounded,
      ),
      _TabItem(
        label: 'المكتمل',
        status: AppointmentStatus.completed,
        icon: Icons.task_alt_rounded,
      ),
      _TabItem(
        label: 'المرفوض',
        status: AppointmentStatus.rejected,
        icon: Icons.cancel_outlined,
      ),
    ];

    return Obx(() {
      final current = controller.filter.value;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: tabs.map((tab) {
            final isSelected = current == tab.status;
            final tabColor = tab.status != null
                ? AppStatusColors.forStatus(tab.status!)
                : cs.primary;

            return Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: GestureDetector(
                onTap: () => controller.setFilter(tab.status),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              tabColor.withValues(alpha: 0.85),
                              tabColor,
                            ],
                          )
                        : null,
                    color: isSelected ? null : cs.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : cs.outlineVariant.withValues(alpha: 0.5),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: tabColor.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tab.icon,
                        size: 15.sp,
                        color: isSelected
                            ? Colors.white
                            : cs.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                      6.horizontalSpace,
                      Text(
                        tab.label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? Colors.white
                              : cs.onSurfaceVariant.withValues(alpha: 0.8),
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                      Obx(() {
                        final count = tab.status == null
                            ? controller.items.length
                            : controller.items
                                .where((e) => e.status == tab.status)
                                .length;
                        if (count == 0 && tab.status != null) {
                          return const SizedBox.shrink();
                        }
                        return Row(
                          children: [
                            6.horizontalSpace,
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.25)
                                    : tabColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                '$count',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: isSelected ? Colors.white : tabColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

class _TabItem {
  final String label;
  final AppointmentStatus? status;
  final IconData icon;
  const _TabItem({required this.label, required this.status, required this.icon});
}

class _EmptyState extends StatelessWidget {
  final AppointmentStatus? filter;
  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final color = filter != null
        ? AppStatusColors.forStatus(filter!)
        : cs.primary;

    final messages = {
      null: ('لا توجد مواعيد', 'لم يتم إضافة أي موعد بعد'),
      AppointmentStatus.pending: ('لا توجد مواعيد قيد المراجعة', 'جميع المواعيد تمت مراجعتها'),
      AppointmentStatus.approved: ('لا توجد مواعيد مؤكدة', 'لم يتم تأكيد أي موعد بعد'),
      AppointmentStatus.completed: ('لا توجد مواعيد مكتملة', 'لم يكتمل أي موعد بعد'),
      AppointmentStatus.rejected: ('لا توجد مواعيد مرفوضة', 'ممتاز! لم يُرفض أي موعد'),
    };

    final msg = messages[filter] ?? ('لا توجد مواعيد', '');

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.r,
              height: 90.r,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.event_busy_outlined,
                size: 44.sp,
                color: color.withValues(alpha: 0.6),
              ),
            ),
            20.verticalSpace,
            Text(
              msg.$1,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            Text(
              msg.$2,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00695C), Color(0xFF009688)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF009688).withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(18.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, color: Colors.white, size: 22.sp),
                8.horizontalSpace,
                Text(
                  'موعد جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
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
