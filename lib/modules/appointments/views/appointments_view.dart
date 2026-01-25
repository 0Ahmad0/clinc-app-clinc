import 'package:clinc_app_clinc/modules/appointments/views/widgets/appointment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/appointments_controller.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cs.surface,
            elevation: 0,
            centerTitle: true,
            title: Text(
              tr(LocaleKeys.appointments_title),
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 12.h),
              child: const _AppointmentsFilters(),
            ),
          ),
          Obx(() {
            final list = controller.filtered;
            return SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              sliver: SliverList.separated(
                itemBuilder: (_, i) => AppointmentCardWidget(item: list[i]),
                separatorBuilder: (_, __) => 12.verticalSpace,
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
    return Obx(() {
      final f = controller.filter.value;

      return Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          _FilterChipItem(
            title: tr(LocaleKeys.appointments_tabs_all),
            selected: f == null,
            onTap: () => controller.setFilter(null),
          ),
          _FilterChipItem(
            title: tr(LocaleKeys.appointments_tabs_pending),
            selected: f ==
                AppointmentStatus.pending,
            onTap: () => controller.setFilter(AppointmentStatus.pending),
          ),
          _FilterChipItem(
            title: tr(LocaleKeys.appointments_tabs_approved),
            selected: f == AppointmentStatus.approved,
            onTap: () => controller.setFilter(AppointmentStatus.approved),
          ),
          _FilterChipItem(
            title: tr(LocaleKeys.appointments_tabs_completed),
            selected: f == AppointmentStatus.completed,
            onTap: () => controller.setFilter(AppointmentStatus.completed),
          ),
          _FilterChipItem(
            title: tr(LocaleKeys.appointments_tabs_rejected),
            selected: f == AppointmentStatus.rejected,
            onTap: () => controller.setFilter(AppointmentStatus.rejected),
          ),
        ],
      );
    });
  }
}

class _FilterChipItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChipItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? cs.primaryContainer : cs.outlineVariant),
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