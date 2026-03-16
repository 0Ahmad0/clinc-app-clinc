import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  static const _blue = Color(0xFF2563EB);
  static const _darkBlue = Color(0xFF1E3A8A);

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
                _SectionCard(
                  icon: Icons.help_outline_rounded,
                  iconColor: _blue,
                  title: 'الأسئلة الشائعة',
                  children: const [
                    _FaqItem(
                      question: 'كيف أضيف موعداً جديداً؟',
                      answer: 'من الشاشة الرئيسية، اضغط على "المواعيد" ثم زر الإضافة (+) لإنشاء موعد جديد وتعبئة بيانات المريض والطبيب والوقت.',
                    ),
                    _FaqItem(
                      question: 'كيف أعدّل بيانات طبيب؟',
                      answer: 'انتقل إلى قسم "الأطباء"، اضغط على بطاقة الطبيب المراد تعديله، ثم اختر "تعديل" من القائمة.',
                    ),
                    _FaqItem(
                      question: 'كيف أصدّر تقرير؟',
                      answer: 'ادخل قسم "التقارير"، حدد نوع التقرير والفترة الزمنية، ثم اضغط على "تصدير PDF" أو "تصدير CSV".',
                    ),
                    _FaqItem(
                      question: 'هل يمكنني استخدام التطبيق بدون إنترنت؟',
                      answer: 'يعمل التطبيق بشكل جزئي بدون إنترنت، لكن بعض الميزات مثل المزامنة والإشعارات تتطلب اتصالاً بالشبكة.',
                    ),
                  ],
                ),
                20.verticalSpace,
                _SectionCard(
                  icon: Icons.contact_support_rounded,
                  iconColor: const Color(0xFF009688),
                  title: 'تواصل مع الدعم',
                  children: [
                    _ContactTile(
                      icon: Icons.email_rounded,
                      iconColor: _blue,
                      label: 'البريد الإلكتروني',
                      value: 'support@clinicapp.com',
                      onTap: () {},
                    ),
                    const _HorizDivider(),
                    _ContactTile(
                      icon: Icons.phone_rounded,
                      iconColor: const Color(0xFF10B981),
                      label: 'الهاتف',
                      value: '+966 50 000 0000',
                      onTap: () {},
                    ),
                    const _HorizDivider(),
                    _ContactTile(
                      icon: Icons.chat_rounded,
                      iconColor: const Color(0xFF25D366),
                      label: 'واتساب',
                      value: 'تحدث معنا الآن',
                      onTap: () {},
                    ),
                  ],
                ),
                20.verticalSpace,
                _SectionCard(
                  icon: Icons.bug_report_rounded,
                  iconColor: const Color(0xFFEF4444),
                  title: 'الإبلاغ عن مشكلة',
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'صادفت مشكلة في التطبيق؟ أخبرنا وسنعمل على إصلاحها في أقرب وقت.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                          14.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.bug_report_rounded, size: 18.sp),
                              label: const Text('إرسال تقرير المشكلة'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEF4444),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 13.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
              ? [const Color(0xFF1E3A8A), const Color(0xFF1E1B4B)]
              : [_blue, _darkBlue],
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
                child: Icon(Icons.support_agent_rounded, color: Colors.white, size: 24.sp),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المساعدة والدعم',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'نحن هنا لمساعدتك دائماً',
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

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<Widget> children;
  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.children,
  });
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
              Text(
                title,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.25)),
            boxShadow: [
              BoxShadow(
                color: cs.shadow.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});
  @override
  State<_FaqItem> createState() => _FaqItemState();
}
class _FaqItemState extends State<_FaqItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(18.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.quiz_rounded, color: const Color(0xFF2563EB), size: 16.sp),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    widget.question,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: _expanded ? 0.5 : 0,
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      color: cs.onSurfaceVariant, size: 20.sp),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget.answer,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.55,
                ),
              ),
            ),
          ),
          crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        Divider(height: 1, thickness: 1, indent: 60.w, color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.15)),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback onTap;
  const _ContactTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: Row(
          children: [
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Icon(icon, color: iconColor, size: 18.sp),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                  Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: cs.onSurfaceVariant.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}

class _HorizDivider extends StatelessWidget {
  const _HorizDivider();
  @override
  Widget build(BuildContext context) => Divider(
    height: 1, thickness: 1, indent: 66.w,
    color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.15),
  );
}
