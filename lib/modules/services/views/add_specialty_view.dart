import 'package:clinc_app_clinc/app/core/widgets/app_text_filed_widget.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/add_specialty_controller.dart';

class AddSpecialtyView extends GetView<AddSpecialtyController> {
  const AddSpecialtyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleKey = controller.isEdit ? 'forms.edit_title' : 'forms.add_title';
    final btnKey = controller.isEdit ? 'forms.save' : 'forms.create';

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          tr(titleKey, args: [tr('services_module.tabs.specialties')]),
        ),
        // "إضافة تخصص"
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
            tr(btnKey),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Icon & Color Preview Card
              Center(
                child: Obx(
                  () => InkWell(
                    onTap: () => Get.find<AddSpecialtyController>().setIcon(Icons.account_circle),
                    child: Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        color: controller.selectedColor.value.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: controller.selectedColor.value,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        controller.selectedIcon.value,
                        size: 40.sp,
                        color: controller.selectedColor.value,
                      ),
                    ),
                  ),
                ),
              ),
              30.verticalSpace,

              // 2. Name & Desc
              AppTextFormFieldWidget(
                controller: controller.nameController,
                hintText: tr(LocaleKeys.services_module_labels_name_hint),
                validator: (v) => v!.isEmpty
                    ? tr(LocaleKeys.services_module_forms_validation_required)
                    : null,
              ),
              20.verticalSpace,
              AppTextFormFieldWidget(
                controller: controller.descController,
                hintText: tr(LocaleKeys.services_module_forms_desc_label),
                maxLines: 3,
              ),
              24.verticalSpace,

              // 3. Icon Selector Button
              Text(
                tr(LocaleKeys.services_module_forms_icon_label),
                style: theme.textTheme.titleSmall,
              ),
              10.verticalSpace,
              InkWell(
                onTap: controller.pickIcon,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.outline),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.touch_app, color: Colors.grey),
                      10.horizontalSpace,
                      Text(tr(LocaleKeys.services_module_labels_select_icon)),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              24.verticalSpace,

              // 4. Color Picker (Horizontal List)
              Text(
                tr(LocaleKeys.services_module_forms_color_label),
                style: theme.textTheme.titleSmall,
              ),
              10.verticalSpace,
              SizedBox(
                height: 50.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.availableColors.length,
                  separatorBuilder: (_, __) => 10.horizontalSpace,
                  itemBuilder: (context, index) {
                    final color = controller.availableColors[index];
                    return Obx(
                      () => GestureDetector(
                        onTap: () => controller.setColor(color),
                        child: Container(
                          width: 50.h,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: controller.selectedColor.value == color
                                ? Border.all(
                                    color: colorScheme.onSurface,
                                    width: 3,
                                  )
                                : null,
                          ),
                          child: controller.selectedColor.value == color
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
