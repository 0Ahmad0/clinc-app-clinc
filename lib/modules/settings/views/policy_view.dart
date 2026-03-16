import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyView extends StatelessWidget {
  const PolicyView({super.key});

  static const _purple = Color(0xFF8B5CF6);
  static const _darkPurple = Color(0xFF5B21B6);

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
                _PolicySection(
                  number: '1',
                  title: 'جمع البيانات واستخدامها',
                  content:
                      'نقوم بجمع المعلومات الضرورية لتشغيل التطبيق وتقديم الخدمات، بما في ذلك بيانات الحساب وبيانات العيادة والمواعيد. لا نبيع أو نتاجر بمعلوماتك الشخصية لأطراف ثالثة تحت أي ظرف كان.',
                  icon: Icons.data_usage_rounded,
                ),
                14.verticalSpace,
                _PolicySection(
                  number: '2',
                  title: 'أمان البيانات',
                  content:
                      'نستخدم بروتوكولات تشفير متقدمة لحماية بياناتك. يتم نقل البيانات عبر اتصالات HTTPS مؤمّنة، وتُخزّن على خوادم مشفّرة وفق أعلى معايير الأمان.',
                  icon: Icons.security_rounded,
                ),
                14.verticalSpace,
                _PolicySection(
                  number: '3',
                  title: 'مشاركة المعلومات',
                  content:
                      'قد نشارك المعلومات مع مزودي الخدمات الموثوقين الذين يساعدوننا في تشغيل التطبيق، شريطة التزامهم بسياسة الخصوصية ذاتها. لن نكشف عن بياناتك إلا إذا أوجب ذلك القانون.',
                  icon: Icons.share_rounded,
                ),
                14.verticalSpace,
                _PolicySection(
                  number: '4',
                  title: 'حقوقك',
                  content:
                      'لديك الحق في الوصول إلى بياناتك الشخصية وتعديلها وحذفها في أي وقت. يمكنك التواصل معنا عبر قسم الدعم لممارسة هذه الحقوق أو لمزيد من الاستفسارات.',
                  icon: Icons.person_outline_rounded,
                ),
                14.verticalSpace,
                _PolicySection(
                  number: '5',
                  title: 'ملفات تعريف الارتباط',
                  content:
                      'يستخدم التطبيق ملفات تخزين محلية للحفاظ على جلسة المستخدم وتحسين تجربة الاستخدام. لا يتم استخدام هذه الملفات لأغراض تتبع أو إعلانية.',
                  icon: Icons.cookie_outlined,
                ),
                14.verticalSpace,
                _PolicySection(
                  number: '6',
                  title: 'تحديثات السياسة',
                  content:
                      'قد نحدّث سياسة الخصوصية من وقت لآخر. سيتم إخطارك بأي تغييرات جوهرية عبر إشعار داخل التطبيق أو بريد إلكتروني على الحساب المسجّل.',
                  icon: Icons.update_rounded,
                ),
                20.verticalSpace,
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: _purple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: _purple.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, color: _purple, size: 20.sp),
                      12.horizontalSpace,
                      Expanded(
                        child: Text(
                          'آخر تحديث: يناير 2025 • للاستفسار تواصل معنا عبر قسم الدعم',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _purple,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
              ? [const Color(0xFF4C1D95), const Color(0xFF2E1065)]
              : [_purple, _darkPurple],
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
                child: Icon(Icons.privacy_tip_rounded, color: Colors.white, size: 24.sp),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سياسة الخصوصية',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'كيف نحافظ على بياناتك',
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
}

class _PolicySection extends StatelessWidget {
  final String number;
  final String title;
  final String content;
  final IconData icon;
  const _PolicySection({
    required this.number,
    required this.title,
    required this.content,
    required this.icon,
  });

  static const _purple = Color(0xFF8B5CF6);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: _purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: _purple, size: 20.sp),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: _purple,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        number,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Text(
                  content,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
