import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/core/widgets/app_section_title.dart';
import '../../../app/routes/app_routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/dashboard_sliver_header.dart';
import 'widgets/dashboard_quick_actions.dart';
import 'widgets/dashboard_stats_grid.dart';
import 'widgets/dashboard_appointments_list.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const DashboardSliverHeader(),
          const DashboardQuickActions(),
          SliverToBoxAdapter(child: AppSectionTitle(title: 'إحصائيات العيادة')),
          const DashboardStatsGrid(),
          SliverToBoxAdapter(
            child: AppSectionTitle(
              title: tr(LocaleKeys.dashboard_todays_appointments),
              trailingLabel: tr(LocaleKeys.dashboard_view_all),
              trailingAction: () => Get.toNamed(AppRoutes.appointments),
            ),
          ),
          const DashboardAppointmentsList(),
          SliverToBoxAdapter(child: 40.verticalSpace),
        ],
      ),
    );
  }
}
