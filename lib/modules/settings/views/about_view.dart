import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  static const _slate = Color(0xFF475569);
  static const _darkSlate = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
         
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(theme, isDark)),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildAppCard(theme, cs),
                20.verticalSpace,
                _InfoSection(
                  icon: Icons.info_rounded,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'عن التطبيق',
                  children: [
                    _InfoRow(label: 'اسم التطبيق', value: 'Clinic Manager'),
                    _InfoRow(label: 'الإصدار', value: '1.0.0'),
                    _InfoRow(label: 'رقم البناء', value: '100'),
                    _InfoRow(label: 'تاريخ الإصدار', value: 'يناير 2025', isLast: true),
                  ],
                ),
                16.verticalSpace,
                _InfoSection(
                  icon: Icons.code_rounded,
                  iconColor: const Color(0xFF8B5CF6),
                  title: 'التقنيات المستخدمة',
                  children: [
                    _InfoRow(label: 'إطار العمل', value: 'Flutter 3.x'),
                    _InfoRow(label: 'إدارة الحالة', value: 'GetX'),
                    _InfoRow(label: 'المنصات', value: 'Android & iOS'),
                    _InfoRow(label: 'الإصدار التقني', value: 'Dart 3.x', isLast: true),
                  ],
                ),
                16.verticalSpace,
                _InfoSection(
                  icon: Icons.business_rounded,
                  iconColor: const Color(0xFF10B981),
                  title: 'معلومات المطوّر',
                  children: [
                    _InfoRow(label: 'الشركة', value: 'Clinic Solutions'),
                    _InfoRow(label: 'البريد', value: 'dev@clinicsolutions.com'),
                    _InfoRow(label: 'الموقع', value: 'www.clinicsolutions.com', isLast: true),
                  ],
                ),
                20.verticalSpace,
                _buildRateCard(theme, cs),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
              : [_slate, _darkSlate],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(9.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18.sp),
                ),
              ),
              14.horizontalSpace,
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(Icons.info_rounded, color: Colors.white, size: 24.sp),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'حول التطبيق',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'معلومات وإصدار التطبيق',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppCard(ThemeData theme, ColorScheme cs) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF009688), Color(0xFF00695C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF009688).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 68.r,
            height: 68.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
            ),
            child: Icon(Icons.local_hospital_rounded, color: Colors.white, size: 36.sp),
          ),
          18.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clinic Manager',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                4.verticalSpace,
                Text(
                  'نظام إدارة العيادات الذكي',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                10.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'الإصدار 1.0.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRateCard(ThemeData theme, ColorScheme cs) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أعجبك التطبيق؟',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            4.verticalSpace,
            Text(
              'قيّمنا بخمس نجوم وساعدنا في التحسين!',
              style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<Widget> children;
  const _InfoSection({required this.icon, required this.iconColor, required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h, right: 4.w),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 16.sp),
              6.horizontalSpace,
              Text(title, style: theme.textTheme.labelLarge?.copyWith(color: iconColor, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
            boxShadow: [BoxShadow(color: cs.shadow.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  const _InfoRow({required this.label, required this.value, this.isLast = false});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
          child: Row(
            children: [
              Expanded(
                child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
              ),
              Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, thickness: 1, indent: 16.w, endIndent: 16.w,
              color: cs.outlineVariant.withValues(alpha: 0.15)),
      ],
    );
  }
}
