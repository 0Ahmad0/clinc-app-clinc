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
import '../models/dashboard_model.dart';
import '../../main_layout/controllers/main_layout_controller.dart';
import 'widgets/dashboard_header_widget.dart';
import 'widgets/dashboard_stats_grid_widget.dart';
import 'widgets/dashboard_today_appointments_widget.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // استخدام AppScaffoldWidget من الكود القديم مع المحتوى الجديد
    return AppScaffoldWidget(
      body: SafeArea(
        child: Obx(() {
          final dashboard = controller.dashboard.value;

          // حالات التحميل والخطأ (من الكود القديم)
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
                // الهيدر الجديد مع ربط قديم
                _buildHeader(theme, cs, isDark, dashboard),

                // الأزرار السريعة (جديد)
                _buildQuickActions(theme, cs),

                // عنوان الإحصائيات (جديد)
                _buildSectionTitle(
                  theme,
                  cs,
                  tr('dashboard.stats_title') ?? 'إحصائيات العيادة',
                  Icons.bar_chart_rounded,
                ),

                // شبكة الإحصائيات (مدمجة من القديم والجديد)
                _buildStatsGrid(theme, cs, dashboard),

                // عنوان مواعيد اليوم (مدمج من القديم والجديد)
                _buildSectionTitle(
                  theme,
                  cs,
                  tr(LocaleKeys.dashboard_todays_appointments),
                  Icons.calendar_today_rounded,
                  trailingLabel: tr(LocaleKeys.dashboard_view_all),
                  trailingAction: () => Get.toNamed(AppRoutes.appointments),
                ),

                // قائمة المواعيد (مدمجة من القديم والجديد)
                _buildAppointmentsList(theme, cs, dashboard),

                SliverToBoxAdapter(child: 40.verticalSpace),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ===== الهيدر الجديد مع ربط قديم =====
  Widget _buildHeader(
    ThemeData theme,
    ColorScheme cs,
    bool isDark,
    DashboardModel dashboard,
  ) {
    final now = DateTime.now();
    final months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    final days = [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];
    final dateStr =
        '${days[now.weekday % 7]}، ${now.day} ${months[now.month - 1]}';

    // استخدام اسم العيادة من الكود القديم
    final clinicName = dashboard.clinic.name;

    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 155.h,
      backgroundColor: const Color(0xFF00695C),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        // زر الإشعارات (جديد)
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.notifications),
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 26,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // زر الإعدادات (جديد)
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.settings),
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
        12.horizontalSpace,
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF004D40), const Color(0xFF002B22)]
                  : [const Color(0xFF00897B), const Color(0xFF004D40)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // صورة العيادة أو الأحرف الأولى (جديد)
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.settings),
                        child: Container(
                          width: 50.r,
                          height: 50.r,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF26A69A), Color(0xFF00695C)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              clinicName.isNotEmpty ? clinicName[0] : 'ع',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      14.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clinicName,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              dateStr,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  // حالة العيادة (جديد)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: const Color(0xFF4ADE80),
                          size: 9.r,
                        ),
                        8.horizontalSpace,
                        Text(
                          tr('dashboard.clinic.open') ??
                              'العيادة مفتوحة — ٨:٠٠ ص - ٨:٠٠ م',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      title: Text(
        tr(LocaleKeys.dashboard_title) ?? 'لوحة التحكم',
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  // ===== الأزرار السريعة (جديد) =====
  Widget _buildQuickActions(ThemeData theme, ColorScheme cs) {
    final actions = [
      _QuickAction(
        tr(LocaleKeys.dashboard_new_appointment) ?? 'موعد جديد',
        Icons.add_circle_rounded,
        const Color(0xFF009688),
        () => Get.find<MainLayoutController>().changeTab(3),
      ),
      _QuickAction(
        tr(LocaleKeys.nav_doctors) ?? 'الأطباء',
        Icons.people_rounded,
        const Color(0xFF3949AB),
        () => Get.find<MainLayoutController>().changeTab(1),
      ),
      _QuickAction(
        tr(LocaleKeys.nav_services) ?? 'الخدمات',
        Icons.medical_services_rounded,
        const Color(0xFF2563EB),
        () => Get.find<MainLayoutController>().changeTab(2),
      ),
      _QuickAction(
        tr(LocaleKeys.nav_reports) ?? 'التقارير',
        Icons.analytics_rounded,
        const Color(0xFF10B981),
        () => Get.find<MainLayoutController>().changeTab(4),
      ),
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions
              .map((a) => Expanded(child: _buildQuickActionItem(theme, a)))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(ThemeData theme, _QuickAction action) {
    return GestureDetector(
      onTap: action.onTap,
      child: Column(
        children: [
          Container(
            width: 54.r,
            height: 54.r,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: action.color.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: Icon(action.icon, color: action.color, size: 26.sp),
          ),
          8.verticalSpace,
          Text(
            action.label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 11.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ===== عنوان القسم (جديد) =====
  Widget _buildSectionTitle(
    ThemeData theme,
    ColorScheme cs,
    String title,
    IconData icon, {
    String? trailingLabel,
    VoidCallback? trailingAction,
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: 18.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF009688), Color(0xFF004D40)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            10.horizontalSpace,
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            if (trailingLabel != null)
              GestureDetector(
                onTap: trailingAction,
                child: Text(
                  trailingLabel,
                  style: TextStyle(
                    color: const Color(0xFF009688),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ===== شبكة الإحصائيات (مدمجة من القديم والجديد) =====
  Widget _buildStatsGrid(
    ThemeData theme,
    ColorScheme cs,
    DashboardModel dashboard,
  ) {
    final stats = dashboard.stats;

    // استخدام بيانات من الكود القديم مع تصميم جديد
    final statItems = [
      _StatItem(
        tr(LocaleKeys.dashboard_stats_doctors) ?? 'الأطباء',
        '${stats.doctorsCount}',
        Icons.people_alt_rounded,
        const Color(0xFF8B5CF6),
        '+2',
      ),
      _StatItem(
        tr(LocaleKeys.dashboard_stats_patients) ?? 'المرضى',
        '${stats.patientsCount}',
        Icons.groups_rounded,
        const Color(0xFF3949AB),
        '+18',
      ),
      _StatItem(
        tr(LocaleKeys.dashboard_stats_today_appointments) ?? 'مواعيد اليوم',
        '${stats.todayAppointmentsCount}',
        Icons.calendar_today_rounded,
        const Color(0xFF009688),
        '${dashboard.todayAppointments.where((item) => item.status == 'upcoming').length} قادمة',
      ),
      _StatItem(
        tr('dashboard.stats.daily_income'),
        '${stats.dailyIncome}',
        Icons.monetization_on_rounded,
        const Color(0xFFF59E0B),
        'ر.س',
      ),
    ];

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, i) => _buildStatCard(theme, statItems[i]),
          childCount: statItems.length,
        ),
      ),
    );
  }

  Widget _buildStatCard(ThemeData theme, _StatItem stat) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [stat.color.withValues(alpha: 0.85), stat.color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: stat.color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                stat.icon,
                color: Colors.white.withValues(alpha: 0.9),
                size: 20.sp,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  stat.badge,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              4.verticalSpace,
              Text(
                stat.label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== قائمة المواعيد (مدمجة من القديم والجديد) =====
  Widget _buildAppointmentsList(
    ThemeData theme,
    ColorScheme cs,
    DashboardModel dashboard,
  ) {
    final appointments = dashboard.todayAppointments;

    if (appointments.isEmpty) {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        sliver: SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(
                tr(LocaleKeys.dashboard_no_appointments) ??
                    'لا توجد مواعيد اليوم',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList.separated(
        itemCount: appointments.length,
        separatorBuilder: (_, __) => 10.verticalSpace,
        itemBuilder: (context, i) {
          final appointment = appointments[i];
          return _buildAppointmentCard(
            theme,
            cs,
            appointment.patientName,
            appointment.consultationType,
            appointment.time,
            appointment.status,
            _getStatusIcon(appointment.status),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(
    ThemeData theme,
    ColorScheme cs,
    String name,
    String service,
    String time,
    String status,
    IconData icon,
  ) {
    Color statusColor;
    String statusText;
    switch (status) {
      case 'completed':
        statusColor = const Color(0xFF10B981);
        statusText = tr(LocaleKeys.appointment_status_completed) ?? 'مكتمل';
        break;
      case 'cancelled':
        statusColor = const Color(0xFFEF4444);
        statusText = tr(LocaleKeys.appointment_status_cancelled) ?? 'ملغي';
        break;
      default:
        statusColor = const Color(0xFFF59E0B);
        statusText = tr(LocaleKeys.appointment_status_upcoming) ?? 'قادم';
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.appointments),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: statusColor.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: statusColor.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              child: Icon(icon, color: statusColor, size: 20.sp),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  Text(
                    service,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
                6.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.schedule_rounded;
    }
  }
}

// ===== حالة الخطأ (من الكود القديم) =====
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
              child: Text(tr('dashboard.retry') ?? 'إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== نماذج البيانات المساعدة =====
class _QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  _QuickAction(this.label, this.icon, this.color, this.onTap);
}

class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String badge;
  _StatItem(this.label, this.value, this.icon, this.color, this.badge);
}
