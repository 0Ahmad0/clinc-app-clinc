import 'package:clinc_app_clinc/app/core/widgets/app_text_filed_widget.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/add_service_controller.dart';

class AddServiceView extends GetView<AddServiceController> {
  const AddServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleKey = controller.isEdit
        ? LocaleKeys.services_module_forms_edit_title
        : LocaleKeys.services_module_forms_add_title;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          tr(titleKey, args: [tr(LocaleKeys.services_module_tabs_services)]),
        ),
        // "إضافة خدمة"
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: ElevatedButton(
          onPressed: controller.save,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            tr(
              controller.isEdit
                  ? LocaleKeys.services_module_forms_save
                  : LocaleKeys.services_module_forms_create,
            ),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Name
              AppTextFormFieldWidget(
                controller: controller.nameController,

                hintText: tr(LocaleKeys.services_module_labels_name_hint),
                validator: (v) => v!.isEmpty
                    ? tr(LocaleKeys.services_module_forms_validation_required)
                    : null,
              ),
              24.verticalSpace,

              // 2. Specialty Dropdown
              Text(
                tr('forms.category_label'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.verticalSpace,
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedSpecialtyId.value.isEmpty
                      ? null
                      : controller.selectedSpecialtyId.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    filled: true,
                    fillColor: colorScheme.surface,
                  ),
                  items: controller.mainController.specialties.map((spec) {
                    return DropdownMenuItem(
                      value: spec.id,
                      child: Text(spec.name),
                    );
                  }).toList(),
                  onChanged: (val) =>
                      controller.selectedSpecialtyId.value = val!,
                ),
              ),
              24.verticalSpace,

              // 3. Price & Duration Row
              Row(
                children: [
                  Expanded(
                    child: AppTextFormFieldWidget(
                      controller: controller.priceController,
                      hintText: tr(
                        LocaleKeys.services_module_forms_price_label,
                      ),
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.attach_money,
                      validator: (v) =>
                          v!.isEmpty ? tr('forms.validation.required') : null,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: AppTextFormFieldWidget(
                      controller: controller.durationController,
                      hintText: tr(
                        LocaleKeys.services_module_forms_duration_label,
                      ),
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.timer_outlined,
                      validator: (v) =>
                          v!.isEmpty ? tr('forms.validation.required') : null,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,

              // 4. Active Switch
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: colorScheme.primary,
                    ),
                    12.horizontalSpace,
                    Text(
                      tr('forms.active_label'),
                      style: theme.textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Obx(
                      () => Switch.adaptive(
                        value: controller.isActive.value,
                        activeColor: colorScheme.primary,
                        onChanged: (val) => controller.isActive.value = val,
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
