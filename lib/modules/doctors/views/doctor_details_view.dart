import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/data/doctor_model.dart';
import '../../../app/routes/app_routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/doctors_controller.dart';

class DoctorDetailsView extends GetView<DoctorsController> {
  const DoctorDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor = Get.arguments as DoctorModel;
    final specColor = DoctorsController.specialtyColor(doctor.specialty);
    final initials = _getInitials(doctor.nameAr);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _HeroAppBar(
              doctor: doctor, specColor: specColor, initials: initials),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _StatsRow(doctor: doctor, specColor: specColor),
                20.verticalSpace,
                _ContactButtons(doctor: doctor),
                20.verticalSpace,
                _SectionCard(
                  icon: Icons.info_outline_rounded,
                  title: 'نبذة عن الطبيب',
                  color: specColor,
                  child: Text(
                    doctor.about,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.7,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.8),
                    ),
                  ),
                ),
                20.verticalSpace,
                _SectionCard(
                  icon: Icons.calendar_month_rounded,
                  title: 'جدول الدوام الأسبوعي',
                  color: specColor,
                  child: _WeeklySchedule(
                      workingHours: doctor.workingHours,
                      specColor: specColor),
                ),
                20.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.replaceAll('د.', '').trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return parts[0].isNotEmpty ? parts[0][0] : '؟';
  }
}

class _HeroAppBar extends StatelessWidget {
  final DoctorModel doctor;
  final Color specColor;
  final String initials;

  const _HeroAppBar(
      {required this.doctor, required this.specColor, required this.initials});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 260.h,
      pinned: true,
      backgroundColor: specColor,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 18),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
              onPressed: () =>
                  Get.toNamed(AppRoutes.addDoctor, arguments: doctor),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.delete_rounded, color: Colors.white, size: 18),
              onPressed: () => _showDeleteDialog(context, doctor),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [specColor, specColor.withValues(alpha: 0.7)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -40,
                right: -40,
                child: Container(
                  width: 180.r,
                  height: 180.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 140.r,
                  height: 140.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      60.verticalSpace,
                      Container(
                        width: 80.r,
                        height: 80.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.25),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.5),
                              width: 3),
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      12.verticalSpace,
                      Text(
                        doctor.nameAr,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      6.verticalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          doctor.specialty,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, DoctorModel doctor) {
    final ctrl = Get.find<DoctorsController>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red, size: 24.sp),
            8.horizontalSpace,
            const Text('حذف الطبيب'),
          ],
        ),
        content: Text('هل أنت متأكد من حذف ${doctor.nameAr}؟'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => ctrl.deleteDoctor(doctor.id!),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            child: const Text('حذف', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final DoctorModel doctor;
  final Color specColor;
  const _StatsRow({required this.doctor, required this.specColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: '${doctor.yearsOfExperience}',
            label: 'سنة خبرة',
            icon: Icons.workspace_premium_rounded,
            color: const Color(0xFFF59E0B),
            theme: theme,
            cs: cs,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _StatCard(
            value: '\$${doctor.fee.toInt()}',
            label: 'رسوم الكشف',
            icon: Icons.payments_rounded,
            color: const Color(0xFF16B364),
            theme: theme,
            cs: cs,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _StatCard(
            value: doctor.isAvailable ? 'متاح' : 'مشغول',
            label: 'الحالة',
            icon: doctor.isAvailable
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: doctor.isAvailable
                ? const Color(0xFF16B364)
                : const Color(0xFFF04438),
            theme: theme,
            cs: cs,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final ThemeData theme;
  final ColorScheme cs;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          8.verticalSpace,
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: cs.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          4.verticalSpace,
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: cs.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ContactButtons extends StatelessWidget {
  final DoctorModel doctor;
  const _ContactButtons({required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: _ContactBtn(
            icon: Icons.call_rounded,
            label: 'اتصال',
            value: doctor.phone,
            color: const Color(0xFF16B364),
            theme: theme,
            cs: cs,
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: _ContactBtn(
            icon: Icons.email_rounded,
            label: 'إيميل',
            value: doctor.email,
            color: const Color(0xFF2E90FA),
            theme: theme,
            cs: cs,
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: _ContactBtn(
            icon: Icons.badge_rounded,
            label: 'الترخيص',
            value: doctor.licenseNumber,
            color: const Color(0xFFF59E0B),
            theme: theme,
            cs: cs,
          ),
        ),
      ],
    );
  }
}

class _ContactBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ThemeData theme;
  final ColorScheme cs;

  const _ContactBtn({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar(
        label,
        value,
        backgroundColor: color.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22.sp),
            6.verticalSpace,
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: color, size: 18.sp),
              ),
              10.horizontalSpace,
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          child,
        ],
      ),
    );
  }
}

class _WeeklySchedule extends StatelessWidget {
  final List<WorkingHours> workingHours;
  final Color specColor;

  const _WeeklySchedule(
      {required this.workingHours, required this.specColor});

  static const _dayNames = {
    'saturday': 'السبت',
    'sunday': 'الأحد',
    'monday': 'الاثنين',
    'tuesday': 'الثلاثاء',
    'wednesday': 'الأربعاء',
    'thursday': 'الخميس',
    'friday': 'الجمعة',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (workingHours.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline_rounded,
                size: 18.sp, color: cs.onSurfaceVariant),
            8.horizontalSpace,
            Text(
              'لا يوجد جدول دوام محدد',
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return Column(
      children: workingHours.map((wh) {
        final dayName = _dayNames[wh.day] ?? wh.day;
        final isOff = wh.isDayOff;
        final rowColor =
            isOff ? const Color(0xFFF04438) : specColor;

        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: rowColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: rowColor.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: rowColor,
                  ),
                ),
                10.horizontalSpace,
                SizedBox(
                  width: 70.w,
                  child: Text(
                    dayName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: rowColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                        color: rowColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    isOff
                        ? 'إجازة'
                        : '${wh.startTime} - ${wh.endTime}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: rowColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
