import 'package:clinc_app_clinc/app/core/widgets/app_padding_widget.dart';
import 'package:clinc_app_clinc/app/core/widgets/app_scaffold_widget.dart';
import 'package:clinc_app_clinc/app/core/widgets/app_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import './widgets/dashboard_header_widget.dart';
import './widgets/dashboard_stats_grid_widget.dart';
import './widgets/dashboard_today_appointments_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppScaffoldWidget(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: const DashboardHeaderWidget(clinicName: "عيادة الشفاء"),
            ),
            const DashboardStatsGridWidget(),
            SliverToBoxAdapter(
              child: AppPaddingWidget(
                child: Row(
                  children: [
                    Text(
                      tr(LocaleKeys.dashboard_todays_appointments),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    AppTextButtonWidget(
                      onPressed: () {
                        // انتقل لكل المواعيد
                        Get.toNamed('/appointments');
                      },
                      text: tr(LocaleKeys.dashboard_view_all),
                    ),
                  ],
                ),
              ),
            ),
            const DashboardTodayAppointmentsWidget(),
          ],
        ),
      ),
    );
  }
}
