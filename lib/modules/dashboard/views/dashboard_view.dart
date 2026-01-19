import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../../main_layout/controllers/main_layout_controller.dart';
import 'widgets/dashboard_app_bar.dart';
import 'widgets/dashboard_appointment_tile.dart';
import 'widgets/dashboard_stats_grid.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // استدعاء الثيم مرة واحدة لاستخدامه
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final mainController = Get.find<MainLayoutController>();

    return Scaffold(
      backgroundColor: colorScheme.background, // لون الخلفية من الثيم
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const DashboardSliverAppBar(),

          // 2. بانر التنبيه (SliverToBoxAdapter لأنه عنصر واحد)
         //TODO : Show Complete Profile
          // SliverToBoxAdapter(
          //   child: Obx(() {
          //     if (!mainController.isProfileCompleted) {
          //       return Padding(
          //         padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
          //         child: _buildIncompleteBanner(context),
          //       );
          //     }
          //     return const SizedBox.shrink();
          //   }),
          // ),

          // 3. شبكة الإحصائيات (SliverGrid)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 1.5, // النسبة الذهبية للكروت
              ),
              delegate: SliverChildListDelegate([
                DashboardStatCard(
                  count: "12",
                  label: LocaleKeys.dashboard_stats_doctors,
                  // نمرر لون مخصص من الثيم إذا أردنا تمييز الأرقام
                  iconColor: colorScheme.primary,
                ),
                DashboardStatCard(
                  count: "178",
                  label: LocaleKeys.dashboard_stats_reports,
                  iconColor: colorScheme.secondary,
                ),
                DashboardStatCard(
                  count: "25",
                  label: LocaleKeys.dashboard_stats_appointments,
                  iconColor: colorScheme.tertiary,
                ),
                DashboardStatCard(
                  count: "15",
                  label: LocaleKeys.dashboard_stats_services,
                  iconColor: colorScheme.error, // أو أي لون آخر من السكيم
                ),
              ]),
            ),
          ),

          // 4. عنوان القائمة (SliverToBoxAdapter)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(LocaleKeys.dashboard_todays_appointments),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      tr(LocaleKeys.dashboard_view_all),
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  )
                ],
              ),
            ),
          ),

          // 5. قائمة المواعيد (SliverList) - للأداء العالي
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  // بيانات وهمية (يفترض أن تأتي من الكنترولر)
                  final appointments = [
                    {'name': 'Liam Harper', 'doc': 'Dr. Emily Carter', 'time': '10:00 AM', 'status': 'upcoming'},
                    {'name': 'Olivia Bennett', 'doc': 'Dr. Benjamin Hayes', 'time': '11:30 AM', 'status': 'cancelled'},
                    {'name': 'Noah Thompson', 'doc': 'Dr. Sophia Clark', 'time': '01:00 PM', 'status': 'completed'},
                    {'name': 'Sarah Connor', 'doc': 'Dr. House', 'time': '02:30 PM', 'status': 'upcoming'},
                  ];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h), // مسافة بين العناصر
                    child: DashboardAppointmentTile(item: appointments[index]),
                  );
                },
                childCount: 4, // عدد العناصر
              ),
            ),
          ),

          // مسافة سفلية عشان الـ BottomBar ما يغطي آخر عنصر
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }

  // ويدجت البانر (معزولة لاستخدام الثيم)
  Widget _buildIncompleteBanner(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // نستخدم لون الـ ErrorContainer للتنبيهات أو Custom Color
    // هنا سنستخدم لون مخصص مشتق من الثيم ليشبه الـ Warning
    final warningColor = Colors.orange; // يمكن وضعه في الثيم كـ extension

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: warningColor.withOpacity(0.1), // خلفية شفافة
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warningColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: warningColor),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr(LocaleKeys.home_incomplete_profile_alert_title),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface
                  ),
                ),
                Text(
                  tr(LocaleKeys.home_incomplete_profile_alert_message),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: warningColor),
            child: Text(tr(LocaleKeys.alerts_complete_now)),
          )
        ],
      ),
    );
  }
}