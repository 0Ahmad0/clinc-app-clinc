import 'package:clinc_app_clinc/app/core/widgets/app_text_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/complete_profile_controller.dart';

class CPInfoWidget extends GetView<CompleteProfileController> {
  const CPInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: tr(LocaleKeys.complete_profile_fields_specialty),
            labelStyle: theme.textTheme.bodyMedium,
            prefixIcon: Icon(
                Icons.medical_services_outlined,
                color: theme.colorScheme.primary
            ),
            // نعتمد على الـ InputDecorationTheme المعرف في main.dart
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
          ),
          dropdownColor: theme.colorScheme.surface,
          style: theme.textTheme.bodyLarge, // لون النص المختار
          items: controller.specialties.map((String val) {
            return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                  style: theme.textTheme.bodyMedium, // لون نصوص القائمة
                )
            );
          }).toList(),
          onChanged: (val) => controller.selectedSpecialty.value = val ?? '',
        ),
        16.verticalSpace,

        AppTextFormFieldWidget(
          controller: controller.phoneController,
          hintText: tr(LocaleKeys.complete_profile_fields_phone_hint),
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          // الويدجت الأساسية لديك يجب أن تدعم الثيم تلقائياً
        ),
      ],
    );
  }
}