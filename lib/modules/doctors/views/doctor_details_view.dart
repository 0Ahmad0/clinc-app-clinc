import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import '../../../app/data/doctor_model.dart';
import '../../../app/routes/app_routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/doctors_controller.dart';

class DoctorDetailsView extends GetView<DoctorsController> {
  const DoctorDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // استخدام Get.arguments من الكود الجديد
    final DoctorModel doctor = Get.arguments as DoctorModel;
    final specColor = DoctorsController.specialtyColor(doctor.specialty);
    final initials = _getInitials(doctor.nameAr);
    final isAr = context.locale.languageCode == 'ar';
    final name = isAr ? doctor.nameAr : doctor.nameEn;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // الهيدر الجديد مع Hero من القديم
          _HeroAppBar(doctor: doctor, specColor: specColor, initials: initials),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // بطاقة الإحصائيات (جديد)
                _StatsRow(doctor: doctor, specColor: specColor),
                20.verticalSpace,

                // أزرار الاتصال (جديد)
                _ContactButtons(doctor: doctor),
                20.verticalSpace,

                // النبذة (مدمج)
                _SectionCard(
                  icon: Icons.info_outline_rounded,
                  title: tr(LocaleKeys.add_doctor_labels_about),
                  color: specColor,
                  child: Text(
                    doctor.about,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.7,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                20.verticalSpace,

                // جدول المواعيد (مدمج)
                _SectionCard(
                  icon: Icons.calendar_month_rounded,
                  title: tr(LocaleKeys.working_hours_title),
                  color: specColor,
                  child: _WeeklySchedule(
                    workingHours: doctor.workingHours,
                    specColor: specColor,
                  ),
                ),
                20.verticalSpace,

                // الملفات المرفقة (من الكود القديم)
                if (doctor.qualificationFiles.isNotEmpty) ...[
                  _SectionCard(
                    icon: Icons.file_present_rounded,
                    title: tr(LocaleKeys.add_doctor_labels_qualification_files),
                    color: specColor,
                    child: _DocumentsList(
                      qualificationFiles: doctor.qualificationFiles,
                      specColor: specColor,
                    ),
                  ),
                  20.verticalSpace,
                ],
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

// ===== الهيدر مع Hero (مدمج من القديم والجديد) =====
class _HeroAppBar extends StatelessWidget {
  final DoctorModel doctor;
  final Color specColor;
  final String initials;

  const _HeroAppBar({
    required this.doctor,
    required this.specColor,
    required this.initials,
  });

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
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      actions: [
        // زر التعديل (من الكود القديم)
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () => _goToEditDoctor(context),
            ),
          ),
        ),
        // زر الحذف (من الكود القديم)
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () => _showDeleteDialog(context),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Hero(
          tag: 'doctor_img_${doctor.id}',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [specColor, specColor.withValues(alpha: 0.7)],
              ),
            ),
            child: Stack(
              children: [
                // صورة الطبيب (من القديم)
                if (doctor.imagePath.isNotEmpty)
                  Positioned.fill(
                    child: doctor.imagePath.startsWith('http')
                        ? Image.network(doctor.imagePath, fit: BoxFit.cover)
                        : Image.file(File(doctor.imagePath), fit: BoxFit.cover),
                  ),
                // دوائر زخرفية (من الجديد)
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
                // تدرج شفاف (من القديم)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
                // المحتوى (من الجديد)
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
                              width: 3,
                            ),
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
                            horizontal: 16.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
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
      ),
    );
  }

  void _goToEditDoctor(BuildContext context) {
    final controller = Get.find<DoctorsController>();
    controller.goToEditDoctor(doctor);
  }

  void _showDeleteDialog(BuildContext context) {
    final controller = Get.find<DoctorsController>();
    final isAr = context.locale.languageCode == 'ar';
    final name = isAr ? doctor.nameAr : doctor.nameEn;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red, size: 24.sp),
            8.horizontalSpace,
            Text(tr(LocaleKeys.doctor_details_dialogs_delete_title)),
          ],
        ),
        content: Text(
          tr(LocaleKeys.doctor_details_dialogs_delete_msg, args: [name]),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(tr(LocaleKeys.doctor_details_dialogs_cancel)),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteDoctor(doctor.id!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              tr(LocaleKeys.doctor_details_dialogs_confirm),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== صف الإحصائيات (من الجديد) =====
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
            label: tr(LocaleKeys.add_doctor_labels_experience),
            icon: Icons.workspace_premium_rounded,
            color: const Color(0xFFF59E0B),
            theme: theme,
            cs: cs,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _StatCard(
            value: '${doctor.fee.toInt()} ${tr('dashboard.currency.sar')}',
            label: tr(LocaleKeys.add_doctor_labels_fee),
            icon: Icons.payments_rounded,
            color: const Color(0xFF16B364),
            theme: theme,
            cs: cs,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: _StatCard(
            value: doctor.isAvailable
                ? tr(LocaleKeys.doctors_page_status_active)
                : tr(LocaleKeys.doctors_page_status_inactive),
            label: tr(LocaleKeys.add_doctor_labels_availability),
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

// ===== أزرار الاتصال (من الجديد) =====
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
            label: tr('doctor_details.contact.call'),
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
            label: tr('doctor_details.contact.email'),
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
            label: tr('doctor_details.contact.license'),
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

// ===== بطاقة القسم (من الجديد) =====
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

// ===== جدول المواعيد الأسبوعي (من الجديد) =====
class _WeeklySchedule extends StatelessWidget {
  final List<WorkingHours> workingHours;
  final Color specColor;

  const _WeeklySchedule({required this.workingHours, required this.specColor});

  static const _dayNames = {
    'saturday': 'working_hours.days.saturday',
    'sunday': 'working_hours.days.sunday',
    'monday': 'working_hours.days.monday',
    'tuesday': 'working_hours.days.tuesday',
    'wednesday': 'working_hours.days.wednesday',
    'thursday': 'working_hours.days.thursday',
    'friday': 'working_hours.days.friday',
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
            Icon(
              Icons.info_outline_rounded,
              size: 18.sp,
              color: cs.onSurfaceVariant,
            ),
            8.horizontalSpace,
            Text(
              tr('working_hours.no_schedule'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: workingHours.map((wh) {
        final dayKey = _dayNames[wh.day] ?? wh.day;
        final dayName = tr(dayKey);
        final isOff = wh.isDayOff;
        final rowColor = isOff ? const Color(0xFFF04438) : specColor;

        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: rowColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: rowColor.withValues(alpha: 0.15)),
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
                    horizontal: 12.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: rowColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: rowColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    isOff
                        ? tr(LocaleKeys.working_hours_day_off)
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

// ===== قائمة الملفات المرفقة (من الكود القديم) =====
class _DocumentsList extends StatelessWidget {
  final List<String> qualificationFiles;
  final Color specColor;

  const _DocumentsList({
    required this.qualificationFiles,
    required this.specColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: qualificationFiles.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          String path = qualificationFiles[index];
          String fileName = path.split('/').last;

          return Container(
            width: 200.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: specColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.picture_as_pdf, color: specColor),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "PDF Document",
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
