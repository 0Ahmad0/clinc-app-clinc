import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../controllers/appointments_controller.dart';
import 'widgets/appointment_card_widget.dart';
import 'widgets/search_bar_widget.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new appointment
        },
        backgroundColor: cs.primary,
        child: Icon(Icons.add, color: cs.onPrimary),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Sliver App Bar with Search
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cs.surface,
            elevation: 0,
            expandedHeight: 120.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.bottomCenter,
                child: const SearchBarWidget(),
              ),
            ),
            title: Text(
              tr(LocaleKeys.appointments_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
          ),

          // 2. Filters Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
              child: const _AppointmentsFilters(),
            ),
          ),

          // 3. Appointments List
          Obx(() {
            final list = controller.filtered;

            if (list.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy_outlined,
                        size: 60.sp,
                        color: cs.onSurface.withOpacity(0.3),
                      ),
                      16.verticalSpace,
                      Text(
                        tr(LocaleKeys.appointments_empty_title),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        tr(LocaleKeys.appointments_empty_subtitle),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurface.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 80.h),
              sliver: SliverList.separated(
                itemBuilder: (_, i) => AppointmentCardWidget(item: list[i]),
                separatorBuilder: (_, __) => 16.verticalSpace,
                itemCount: list.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AppointmentsFilters extends GetView<AppointmentsController> {
  const _AppointmentsFilters();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Obx(() {
      final f = controller.filter.value;

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            4.horizontalSpace,
            _FilterChipItem(
              title: tr(LocaleKeys.appointments_tabs_all),
              selected: f == null,
              onTap: () => controller.setFilter(null),
            ),
            8.horizontalSpace,
            _FilterChipItem(
              title: tr(LocaleKeys.appointments_tabs_pending),
              selected: f == AppointmentStatus.pending,
              onTap: () => controller.setFilter(AppointmentStatus.pending),
              color: cs.tertiary,
            ),
            8.horizontalSpace,
            _FilterChipItem(
              title: tr(LocaleKeys.appointments_tabs_approved),
              selected: f == AppointmentStatus.approved,
              onTap: () => controller.setFilter(AppointmentStatus.approved),
              color: cs.primary,
            ),
            8.horizontalSpace,
            _FilterChipItem(
              title: tr(LocaleKeys.appointments_tabs_completed),
              selected: f == AppointmentStatus.completed,
              onTap: () => controller.setFilter(AppointmentStatus.completed),
              color: Colors.green,
            ),
            8.horizontalSpace,
            _FilterChipItem(
              title: tr(LocaleKeys.appointments_tabs_rejected),
              selected: f == AppointmentStatus.rejected,
              onTap: () => controller.setFilter(AppointmentStatus.rejected),
              color: cs.error,
            ),
            4.horizontalSpace,
          ],
        ),
      );
    });
  }
}

class _FilterChipItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  const _FilterChipItem({
    required this.title,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final chipColor = color ?? cs.primaryContainer;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? chipColor : cs.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? chipColor.withOpacity(0.5) : cs.outlineVariant,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: chipColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : [],
        ),
        child: Text(
          title,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}