import 'package:clinc_app_clinc/app/core/widgets/app_text_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/add_doctor_controller.dart';
import 'widgets/form_label_widget.dart';
import 'widgets/gender_selector_widget.dart';
import 'widgets/image_upload_widget.dart';
import 'widgets/work_hours_list_item.dart';

class AddDoctorView extends GetView<AddDoctorController> {
  const AddDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // خلفية بيضاء/فاتحة

      // الأزرار ثابتة بالأسفل (مثل الصورة)
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.cancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.surfaceVariant,
                  foregroundColor: colorScheme.onSurface,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(tr(LocaleKeys.add_doctor_buttons_cancel)),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: ElevatedButton(
                onPressed: controller.saveDoctor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary, // اللون الأزرق
                  foregroundColor: colorScheme.onPrimary,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  tr(LocaleKeys.add_doctor_buttons_save),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. AppBar
          SliverAppBar(
            pinned: true,
            backgroundColor: colorScheme.surface,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface, size: 20.sp),
              onPressed: () => Get.back(),
            ),
            title: Text(
              tr(LocaleKeys.add_doctor_title),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),

          // 2. محتوى الفورم
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // الاسم الكامل
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_full_name),
                AppTextFormFieldWidget(
                  controller: controller.nameController,
                  hintText: tr(LocaleKeys.add_doctor_labels_name_hint),
                  // إزالة البوردر الافتراضي واستخدام ستايل مشابه للصورة
                ),
                20.verticalSpace,

                // التخصص (Dropdown)
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_specialty),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.add_doctor_labels_specialty_hint),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                    ),
                  ),
                  items: controller.specialties.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => controller.selectedSpecialty.value = val!,
                ),
                20.verticalSpace,

                // الجنس (Custom Selection)
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_gender),
                const GenderSelectorWidget(),
                20.verticalSpace,

                // رقم الترخيص
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_license),
                AppTextFormFieldWidget(
                  controller: controller.licenseController,
                  hintText: tr(LocaleKeys.add_doctor_labels_license_hint),
                ),
                30.verticalSpace,

                // الصورة الشخصية (Upload Box)
                FormLabelWidget(label: LocaleKeys.add_doctor_labels_image_title),
                const ImageUploadWidget(),
                30.verticalSpace,

                // عنوان ساعات العمل
                Text(
                  tr(LocaleKeys.add_doctor_labels_work_hours),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                10.verticalSpace,
                Divider(color: colorScheme.outlineVariant),
              ]),
            ),
          ),

          // 3. قائمة ساعات العمل (SliverList)
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return WorkHoursListItem(
                  item: controller.workingHours[index],
                );
              },
              childCount: controller.workingHours.length,
            ),
          ),

          // مسافة أخيرة
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }
}