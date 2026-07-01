import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/core/widgets/app_padding_widget.dart';
import '../../../app/core/widgets/app_scaffold_widget.dart';
import '../../../app/core/widgets/app_text_button_widget.dart';
import '../../../app/routes/app_routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/dashboard_header_widget.dart';
import 'widgets/dashboard_stats_grid_widget.dart';
import 'widgets/dashboard_today_appointments_widget.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: SafeArea(
        child: Obx(() {
          final dashboard = controller.dashboard.value;
          if (controller.isLoading.value && dashboard == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.value.isNotEmpty && dashboard == null) {
            return _DashboardError(
              message: controller.errorMessage.value,
              onRetry: controller.loadDashboard,
            );
          }
          if (dashboard == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: controller.loadDashboard,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: DashboardHeaderWidget(clinic: dashboard.clinic),
                ),
                DashboardStatsGridWidget(stats: dashboard.stats),
                SliverToBoxAdapter(
                  child: AppPaddingWidget(
                    child: Row(
                      children: [
                        Text(
                          tr(LocaleKeys.dashboard_todays_appointments),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        AppTextButtonWidget(
                          onPressed: () => Get.toNamed(AppRoutes.appointments),
                          text: tr(LocaleKeys.dashboard_view_all),
                        ),
                      ],
                    ),
                  ),
                ),
                DashboardTodayAppointmentsWidget(
                  appointments: dashboard.todayAppointments,
                ),
                SliverToBoxAdapter(child: 24.verticalSpace),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _DashboardError extends StatelessWidget {
  const _DashboardError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            12.verticalSpace,
            Text(message, textAlign: TextAlign.center),
            12.verticalSpace,
            FilledButton(
              onPressed: onRetry,
              child: Text(tr('dashboard.retry')),
            ),
          ],
        ),
      ),
    );
  }
}
