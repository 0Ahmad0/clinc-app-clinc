import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../app/routes/app_routes.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeader(theme, cs, isDark),
          _buildQuickActions(theme, cs),
          _buildSectionTitle(theme, cs, 'إحصائيات العيادة', Icons.bar_chart_rounded),
          _buildStatsGrid(theme, cs),
          _buildSectionTitle(theme, cs, tr(LocaleKeys.dashboard_todays_appointments), Icons.calendar_today_rounded, trailingLabel: tr(LocaleKeys.dashboard_view_all), trailingAction: () => Get.toNamed('/appointments')),
          _buildAppointmentsList(theme, cs),
          SliverToBoxAdapter(child: 40.verticalSpace),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme cs, bool isDark) {
    final now = DateTime.now();
    final months = ['يناير','فبراير','مارس','أبريل','مايو','يونيو','يوليو','أغسطس','سبتمبر','أكتوبر','نوفمبر','ديسمبر'];
    final days = ['الأحد','الاثنين','الثلاثاء','الأربعاء','الخميس','الجمعة','السبت'];
    final dateStr = '${days[now.weekday % 7]}، ${now.day} ${months[now.month - 1]}';

    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 180.h,
      backgroundColor: const Color(0xFF00695C),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.notifications),
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined, color: Colors.white, size: 26),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.settings),
          icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 24),
        ),
        16.horizontalSpace,
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
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
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
                              'ع',
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
                              'عيادة الشفاء',
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
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
      title: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: const BoxDecoration(
              color: Color(0xFF26A69A),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'ع',
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          10.horizontalSpace,
          Text(
            'عيادة الشفاء',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeData theme, ColorScheme cs) {
    final actions = [
      _QuickAction('موعد جديد', Icons.add_circle_rounded, const Color(0xFF009688), () => Get.toNamed('/appointments')),
      _QuickAction('الأطباء', Icons.people_rounded, const Color(0xFF3949AB), () => Get.toNamed('/doctors')),
      _QuickAction('الخدمات', Icons.medical_services_rounded, const Color(0xFF2563EB), () => Get.toNamed('/services')),
      _QuickAction('التقارير', Icons.analytics_rounded, const Color(0xFF10B981), () => Get.toNamed('/reports')),
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions.map((a) => _buildQuickActionItem(theme, a)).toList(),
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
          ),
        ],
      ),
    );
  }

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

  Widget _buildStatsGrid(ThemeData theme, ColorScheme cs) {
    final stats = [
      _StatItem('الأطباء', '12', Icons.people_alt_rounded, const Color(0xFF8B5CF6), '+2 هذا الشهر'),
      _StatItem('المرضى', '248', Icons.groups_rounded, const Color(0xFF3949AB), '+18 هذا الأسبوع'),
      _StatItem('مواعيد اليوم', '8', Icons.calendar_today_rounded, const Color(0xFF009688), '5 قادمة'),
      _StatItem('الدخل اليومي', '٢٥٠٠', Icons.monetization_on_rounded, const Color(0xFFF59E0B), 'ر.س'),
    ];

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.55,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, i) => _buildStatCard(theme, stats[i]),
          childCount: stats.length,
        ),
      ),
    );
  }

  Widget _buildStatCard(ThemeData theme, _StatItem stat) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            stat.color.withValues(alpha: 0.85),
            stat.color,
          ],
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
              Icon(stat.icon, color: Colors.white.withValues(alpha: 0.9), size: 20.sp),
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

  Widget _buildAppointmentsList(ThemeData theme, ColorScheme cs) {
    final appointments = [
      _AppointmentItem('أحمد محمد السيد', 'استشارة قلب', '٩:٠٠ ص', 'upcoming', Icons.monitor_heart_rounded),
      _AppointmentItem('فاطمة علي الزهراني', 'تحليل دم شامل', '١٠:٣٠ ص', 'completed', Icons.biotech_rounded),
      _AppointmentItem('محمد عبدالله الغامدي', 'فحص عيون', '١٢:٠٠ م', 'upcoming', Icons.visibility_rounded),
      _AppointmentItem('نورة سلمان القحطاني', 'استشارة عامة', '٢:٠٠ م', 'cancelled', Icons.healing_rounded),
      _AppointmentItem('عبدالرحمن خالد العتيبي', 'أشعة سينية', '٤:٠٠ م', 'upcoming', Icons.biotech_rounded),
    ];

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList.separated(
        itemCount: appointments.length,
        separatorBuilder: (_, __) => 10.verticalSpace,
        itemBuilder: (context, i) => _buildAppointmentCard(theme, cs, appointments[i]),
      ),
    );
  }

  Widget _buildAppointmentCard(ThemeData theme, ColorScheme cs, _AppointmentItem item) {
    Color statusColor;
    String statusText;
    switch (item.status) {
      case 'completed':
        statusColor = const Color(0xFF10B981);
        statusText = 'مكتمل';
        break;
      case 'cancelled':
        statusColor = const Color(0xFFEF4444);
        statusText = 'ملغي';
        break;
      default:
        statusColor = const Color(0xFFF59E0B);
        statusText = 'قادم';
    }

    return Container(
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
            child: Icon(item.icon, color: statusColor, size: 20.sp),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.verticalSpace,
                Text(
                  item.service,
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
                item.time,
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
    );
  }
}

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

class _AppointmentItem {
  final String name;
  final String service;
  final String time;
  final String status;
  final IconData icon;
  _AppointmentItem(this.name, this.service, this.time, this.status, this.icon);
}
