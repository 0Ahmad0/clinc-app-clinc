import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import '../../../generated/locale_keys.g.dart';
import '../controllers/add_doctor_controller.dart';

class AddDoctorView extends GetView<AddDoctorController> {
  const AddDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Form(
        key: controller.formKey,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildHeroHeader(theme, isDark),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 120.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  24.verticalSpace,
                  _SectionCard(
                    icon: Icons.person_rounded,
                    title: 'المعلومات الأساسية',
                    color: const Color(0xFF3949AB),
                    child: _BasicInfoSection(controller: controller),
                  ),
                  20.verticalSpace,
                  _SectionCard(
                    icon: Icons.work_rounded,
                    title: 'المعلومات المهنية',
                    color: const Color(0xFF1565C0),
                    child: _ProfessionalSection(controller: controller),
                  ),
                  20.verticalSpace,
                  _SectionCard(
                    icon: Icons.attach_file_rounded,
                    title: tr(LocaleKeys.add_doctor_labels_qualification_files),
                    color: const Color(0xFF6A1B9A),
                    child: _FilesSection(controller: controller),
                  ),
                  20.verticalSpace,
                  _SectionCard(
                    icon: Icons.schedule_rounded,
                    title: tr(LocaleKeys.working_hours_title),
                    color: const Color(0xFF00695C),
                    child: _WorkingHoursSection(controller: controller),
                  ),
                  20.verticalSpace,
                  _AvailabilitySection(controller: controller),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _SubmitButton(controller: controller),
    );
  }

  Widget _buildHeroHeader(ThemeData theme, bool isDark) {
    return SliverAppBar(
      expandedHeight: 220.h,
      pinned: true,
      backgroundColor: const Color(0xFF3949AB),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF1A237E), const Color(0xFF283593)]
                  : [const Color(0xFF3949AB), const Color(0xFF1A237E)],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                40.verticalSpace,
                Obx(() => GestureDetector(
                  onTap: controller.pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 90.r,
                        height: 90.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                            width: 2.5,
                          ),
                          image: controller.selectedImage.value.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(
                                      File(controller.selectedImage.value)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.selectedImage.value.isEmpty
                            ? Icon(Icons.person_rounded,
                                color: Colors.white.withValues(alpha: 0.8),
                                size: 42.sp)
                            : null,
                      ),
                      Container(
                        width: 28.r,
                        height: 28.r,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7C4DFF), Color(0xFF3949AB)],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.camera_alt_rounded,
                            color: Colors.white, size: 14.sp),
                      ),
                    ],
                  ),
                )),
                12.verticalSpace,
                Obx(() => Text(
                  controller.isEditMode.value
                      ? tr(LocaleKeys.add_doctor_edit_title)
                      : tr(LocaleKeys.add_doctor_title),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                )),
                4.verticalSpace,
                Text(
                  'أدخل بيانات الطبيب بشكل كامل',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: Obx(() => Text(
        controller.isEditMode.value
            ? tr(LocaleKeys.add_doctor_edit_title)
            : tr(LocaleKeys.add_doctor_title),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w800),
      )),
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
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.12),
                  color.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: 0.7)],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, color: Colors.white, size: 16.sp),
                ),
                12.horizontalSpace,
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.w),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _BasicInfoSection extends StatelessWidget {
  final AddDoctorController controller;
  const _BasicInfoSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _Field(
                ctrl: controller.nameArController,
                label: tr(LocaleKeys.add_doctor_labels_name_ar),
                icon: Icons.person_outline_rounded,
                color: const Color(0xFF3949AB),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: _Field(
                ctrl: controller.nameEnController,
                label: tr(LocaleKeys.add_doctor_labels_name_en),
                icon: Icons.person_outline_rounded,
                color: const Color(0xFF3949AB),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Obx(() => _StyledDropdown(
          value: controller.selectedSpecialty.value.isEmpty
              ? null
              : controller.selectedSpecialty.value,
          label: tr(LocaleKeys.add_doctor_labels_specialty),
          icon: Icons.local_hospital_rounded,
          color: const Color(0xFF3949AB),
          items: controller.specialties,
          onChanged: (v) => controller.selectedSpecialty.value = v!,
        )),
        16.verticalSpace,
        _Field(
          ctrl: controller.feeController,
          label: tr(LocaleKeys.add_doctor_labels_fee),
          icon: Icons.attach_money_rounded,
          color: const Color(0xFF3949AB),
          isNumber: true,
        ),
        16.verticalSpace,
        Row(
          children: [
            Expanded(
              child: _Field(
                ctrl: controller.phoneController,
                label: tr(LocaleKeys.add_doctor_labels_phone),
                icon: Icons.phone_rounded,
                color: const Color(0xFF3949AB),
                isNumber: true,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: _Field(
                ctrl: controller.emailController,
                label: tr(LocaleKeys.add_doctor_labels_email),
                icon: Icons.email_outlined,
                color: const Color(0xFF3949AB),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfessionalSection extends StatelessWidget {
  final AddDoctorController controller;
  const _ProfessionalSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Field(
          ctrl: controller.licenseController,
          label: tr(LocaleKeys.add_doctor_labels_license),
          icon: Icons.badge_rounded,
          color: const Color(0xFF1565C0),
        ),
        16.verticalSpace,
        _Field(
          ctrl: controller.experienceController,
          label: tr(LocaleKeys.add_doctor_labels_experience),
          icon: Icons.star_rate_rounded,
          color: const Color(0xFF1565C0),
          isNumber: true,
        ),
        16.verticalSpace,
        _Field(
          ctrl: controller.aboutController,
          label: tr(LocaleKeys.add_doctor_labels_about),
          icon: Icons.notes_rounded,
          color: const Color(0xFF1565C0),
          maxLines: 3,
          isRequired: false,
        ),
      ],
    );
  }
}

class _FilesSection extends StatelessWidget {
  final AddDoctorController controller;
  const _FilesSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      children: [
        GestureDetector(
          onTap: controller.pickPDFs,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF6A1B9A).withValues(alpha: 0.4),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(14.r),
              color: const Color(0xFF6A1B9A).withValues(alpha: 0.05),
            ),
            child: Column(
              children: [
                Icon(Icons.upload_file_rounded,
                    color: const Color(0xFF6A1B9A), size: 32.sp),
                8.verticalSpace,
                Text(
                  tr(LocaleKeys.add_doctor_buttons_upload_files),
                  style: TextStyle(
                    color: const Color(0xFF6A1B9A),
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
                4.verticalSpace,
                Text(
                  'PDF فقط',
                  style: TextStyle(
                    color: cs.onSurfaceVariant,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (controller.qualificationFiles.isEmpty) return const SizedBox.shrink();
          return Column(
            children: [
              12.verticalSpace,
              ...controller.qualificationFiles.asMap().entries.map((e) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.picture_as_pdf_rounded,
                          color: Colors.red.shade400, size: 20.sp),
                      10.horizontalSpace,
                      Expanded(
                        child: Text(
                          e.value.split('/').last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.removeFile(e.key),
                        icon: Icon(Icons.close_rounded,
                            color: Colors.red.shade400, size: 18.sp),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        }),
      ],
    );
  }
}

class _WorkingHoursSection extends StatelessWidget {
  final AddDoctorController controller;
  const _WorkingHoursSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Obx(() => Column(
      children: List.generate(controller.workingHoursList.length, (i) {
        final day = controller.workingHoursList[i];
        final keyStr = 'working_hours.days.${day.day}';
        final dayName = tr(keyStr) == keyStr ? day.day : tr(keyStr);
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: day.isDayOff
                ? cs.surfaceContainerHighest
                : const Color(0xFF00695C).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: day.isDayOff
                  ? cs.outlineVariant.withValues(alpha: 0.3)
                  : const Color(0xFF00695C).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: day.isDayOff
                            ? cs.surfaceContainerHighest
                            : const Color(0xFF00695C).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        day.isDayOff
                            ? Icons.event_busy_rounded
                            : Icons.event_available_rounded,
                        color: day.isDayOff
                            ? cs.onSurfaceVariant
                            : const Color(0xFF00695C),
                        size: 18.sp,
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dayName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (!day.isDayOff &&
                              day.startTime != null &&
                              day.endTime != null)
                            Text(
                              '${day.startTime} - ${day.endTime}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF00695C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Switch(
                      value: !day.isDayOff,
                      activeColor: const Color(0xFF00695C),
                      onChanged: (v) => controller.toggleDayOff(i, v),
                    ),
                  ],
                ),
              ),
              if (!day.isDayOff) ...[
                Divider(
                    height: 1,
                    color: const Color(0xFF00695C).withValues(alpha: 0.15)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: _TimePicker(
                          context: context,
                          label: tr(LocaleKeys.working_hours_from),
                          time: day.startTime ?? '--:--',
                          onTap: () =>
                              controller.selectTime(context, i, true),
                          color: const Color(0xFF00695C),
                        ),
                      ),
                      12.horizontalSpace,
                      Icon(Icons.arrow_back_rounded,
                          size: 16.sp,
                          color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
                      12.horizontalSpace,
                      Expanded(
                        child: _TimePicker(
                          context: context,
                          label: tr(LocaleKeys.working_hours_to),
                          time: day.endTime ?? '--:--',
                          onTap: () =>
                              controller.selectTime(context, i, false),
                          color: const Color(0xFF00695C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    ));
  }
}

class _TimePicker extends StatelessWidget {
  final BuildContext context;
  final String label;
  final String time;
  final VoidCallback onTap;
  final Color color;

  const _TimePicker({
    required this.context,
    required this.label,
    required this.time,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 10.sp,
                    color: color,
                    fontWeight: FontWeight.w600)),
            4.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w800)),
                Icon(Icons.access_time_rounded, size: 14.sp, color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailabilitySection extends StatelessWidget {
  final AddDoctorController controller;
  const _AvailabilitySection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Obx(() {
      final isAvailable = controller.isAvailable.value;
      return GestureDetector(
        onTap: () => controller.isAvailable.value = !isAvailable,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isAvailable
                  ? [
                      const Color(0xFF00695C).withValues(alpha: 0.1),
                      const Color(0xFF00695C).withValues(alpha: 0.04),
                    ]
                  : [
                      cs.surfaceContainerHighest,
                      cs.surfaceContainerHighest,
                    ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isAvailable
                  ? const Color(0xFF00695C).withValues(alpha: 0.3)
                  : cs.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? const Color(0xFF00695C).withValues(alpha: 0.15)
                      : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  isAvailable
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded,
                  color: isAvailable
                      ? const Color(0xFF00695C)
                      : cs.onSurfaceVariant,
                  size: 22.sp,
                ),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(LocaleKeys.add_doctor_labels_availability),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      isAvailable ? 'الطبيب متاح للمواعيد' : 'الطبيب غير متاح حالياً',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isAvailable
                            ? const Color(0xFF00695C)
                            : cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isAvailable,
                activeColor: const Color(0xFF00695C),
                onChanged: (v) => controller.isAvailable.value = v,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SubmitButton extends StatelessWidget {
  final AddDoctorController controller;
  const _SubmitButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3949AB), Color(0xFF1A237E)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3949AB).withValues(alpha: 0.45),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: controller.saveDoctor,
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_rounded, color: Colors.white, size: 20.sp),
                  10.horizontalSpace,
                  Obx(() => Text(
                    controller.isEditMode.value
                        ? tr(LocaleKeys.add_doctor_buttons_update)
                        : tr(LocaleKeys.add_doctor_buttons_save),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final IconData icon;
  final Color color;
  final bool isNumber;
  final int maxLines;
  final bool isRequired;

  const _Field({
    required this.ctrl,
    required this.label,
    required this.icon,
    required this.color,
    this.isNumber = false,
    this.maxLines = 1,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return TextFormField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      validator: isRequired
          ? (v) => v!.isEmpty
              ? tr(LocaleKeys.add_doctor_validations_required)
              : null
          : null,
      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: color, size: 18.sp),
        labelStyle: TextStyle(
          color: cs.onSurfaceVariant,
          fontSize: 13.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: color, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.error, width: 1.5),
        ),
        filled: true,
        fillColor: cs.surfaceContainerLowest,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
    );
  }
}

class _StyledDropdown extends StatelessWidget {
  final String? value;
  final String label;
  final IconData icon;
  final Color color;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _StyledDropdown({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return DropdownButtonFormField<String>(
      value: value,
      validator: (v) => v == null
          ? tr(LocaleKeys.add_doctor_validations_required)
          : null,
      onChanged: onChanged,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: color),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: color, size: 18.sp),
        labelStyle:
            TextStyle(color: cs.onSurfaceVariant, fontSize: 13.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: color, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.error, width: 1.5),
        ),
        filled: true,
        fillColor: cs.surfaceContainerLowest,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
      items: items
          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
          .toList(),
    );
  }
}
