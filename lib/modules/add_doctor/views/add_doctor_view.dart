import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/core/widgets/app_text_filed_widget.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/add_doctor_controller.dart';
import 'widgets/form_label_widget.dart';
import 'widgets/gender_selector_widget.dart';
import 'widgets/image_upload_widget.dart';
import 'widgets/work_hours_list_item.dart';
import 'widgets/qualification_chip.dart';

class AddDoctorView extends GetView<AddDoctorController> {
  const AddDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      bottomNavigationBar: _buildBottomButtons(cs, theme),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. AppBar
          _buildAppBar(cs, theme),

          // 2. محتوى الفورم
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // الصورة الشخصية
                const Center(child: ImageUploadWidget()),
                30.verticalSpace,

                // الاسم الكامل
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_full_name),
                AppTextFormFieldWidget(
                  controller: controller.nameController,
                  hintText: tr(LocaleKeys.add_doctor_labels_name_hint),
                ),
                20.verticalSpace,

                // التخصص
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_specialty),
                _buildSpecialtyDropdown(cs, theme),
                20.verticalSpace,

                // الجنس
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_gender),
                const GenderSelectorWidget(),
                20.verticalSpace,

                // رقم الترخيص
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_license),
                AppTextFormFieldWidget(
                  controller: controller.licenseController,
                  hintText: tr(LocaleKeys.add_doctor_labels_license_hint),
                ),
                20.verticalSpace,

                // المستشفى
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_hospital),
                AppTextFormFieldWidget(
                  controller: controller.hospitalController,
                  hintText: tr(LocaleKeys.add_doctor_labels_hospital_hint),
                ),
                20.verticalSpace,

                // رقم الهاتف
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_phone),
                AppTextFormFieldWidget(
                  controller: controller.phoneController,
                  hintText: tr(LocaleKeys.add_doctor_labels_phone_hint),
                  keyboardType: TextInputType.phone,
                ),
                20.verticalSpace,

                // البريد الإلكتروني
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_email),
                AppTextFormFieldWidget(
                  controller: controller.emailController,
                  hintText: tr(LocaleKeys.add_doctor_labels_email_hint),
                  keyboardType: TextInputType.emailAddress,
                ),
                20.verticalSpace,

                // سنوات الخبرة
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_experience),
                AppTextFormFieldWidget(
                  controller: controller.experienceController,
                  hintText: tr(LocaleKeys.add_doctor_labels_experience_hint),
                  keyboardType: TextInputType.number,
                ),
                20.verticalSpace,

                // المؤهلات العلمية
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_qualifications),
                _buildQualificationsSection(cs, theme),
                20.verticalSpace,

                // نبذة عن الطبيب
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_about),
                AppTextFormFieldWidget(
                  controller: controller.aboutController,
                  hintText: tr(LocaleKeys.add_doctor_labels_about_hint),
                  maxLines: 4,
                ),
                20.verticalSpace,

                // حالة الطبيب (نشط/غير نشط)
                _buildActiveToggle(cs, theme),
                30.verticalSpace,

                // عنوان ساعات العمل
                _buildWorkHoursTitle(theme, cs),
              ]),
            ),
          ),

          // 3. قائمة ساعات العمل
          _buildWorkHoursList(),
        ],
      ),
    );
  }

  Widget _buildAppBar(ColorScheme cs, ThemeData theme) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: cs.surface,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: cs.onSurface, size: 20.sp),
        onPressed: () => Get.back(),
      ),
      title: Text(
        tr(LocaleKeys.add_doctor_title),
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: cs.onSurface,
        ),
      ),
    );
  }

  Widget _buildBottomButtons(ColorScheme cs, ThemeData theme) {
    return Obx(() => Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: controller.cancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.surfaceVariant,
                foregroundColor: cs.onSurface,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(tr(LocaleKeys.add_doctor_buttons_cancel)),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.saveDoctor,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: controller.isLoading.value
                  ? SizedBox(
                width: 20.r,
                height: 20.r,
                child: CircularProgressIndicator(
                  color: cs.onPrimary,
                  strokeWidth: 2,
                ),
              )
                  : Text(
                tr(LocaleKeys.add_doctor_buttons_save),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildSpecialtyDropdown(ColorScheme cs, ThemeData theme) {
    return DropdownButtonFormField<String>(
      value: controller.specialtyController.text.isEmpty
          ? null
          : controller.specialtyController.text,
      decoration: InputDecoration(
        hintText: tr(LocaleKeys.add_doctor_labels_specialty_hint),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.outline.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.outline.withOpacity(0.3)),
        ),
      ),
      items: controller.specialties
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) => controller.specialtyController.text = val!,
    );
  }

  Widget _buildQualificationsSection(ColorScheme cs, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextFormFieldWidget(
                controller: controller.qualificationController,
                hintText: tr(LocaleKeys.add_doctor_labels_qualification_hint),
              ),
            ),
            8.horizontalSpace,
            IconButton(
              onPressed: controller.addQualification,
              icon: Icon(Icons.add_circle_outline, color: cs.primary),
              tooltip: tr(LocaleKeys.add_doctor_labels_add_qualification),
            ),
          ],
        ),
        12.verticalSpace,
        Obx(() => Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: List.generate(
            controller.qualifications.length,
                (index) => QualificationChip(
              label: controller.qualifications[index],
              onDeleted: () => controller.removeQualification(index),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildActiveToggle(ColorScheme cs, ThemeData theme) {
    return Obx(() => Row(
      children: [
        Text(
          tr(LocaleKeys.add_doctor_labels_active),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: cs.onSurface.withOpacity(0.8),
          ),
        ),
        const Spacer(),
        Switch(
          value: controller.isActive.value,
          onChanged: (value) => controller.isActive.value = value,
          activeColor: cs.primary,
          activeTrackColor: cs.primary.withOpacity(0.3),
          inactiveThumbColor: cs.outline,
          inactiveTrackColor: cs.outlineVariant,
        ),
      ],
    ));
  }

  Widget _buildWorkHoursTitle(ThemeData theme, ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(LocaleKeys.add_doctor_labels_work_hours),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        10.verticalSpace,
        Divider(color: cs.outlineVariant),
      ],
    );
  }

  Widget _buildWorkHoursList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return WorkHoursListItem(
            item: controller.workingHours[index],
            onToggle: () => controller.toggleDayOff(index),
            onTimeChanged: (newTime) => controller.changeWorkTime(index, newTime),
          );
        },
        childCount: controller.workingHours.length,
      ),
    );
  }
}