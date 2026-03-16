import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/app_auth_field.dart';
import '../../../../app/core/widgets/app_form_section_label.dart';
import '../../../../app/core/widgets/app_styled_dropdown.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/complete_profile_controller.dart';

class CPInfoCard extends GetView<CompleteProfileController> {
  const CPInfoCard({super.key});

  static const _purple = Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppFormSectionLabel(
            label: 'معلومات الممارسة',
            icon: Icons.medical_services_rounded,
            color: _purple,
          ),
          16.verticalSpace,
          Obx(() => AppStyledDropdown<String>(
            value: controller.selectedSpecialty.value.isEmpty
                ? null
                : controller.selectedSpecialty.value,
            label: tr(LocaleKeys.complete_profile_fields_specialty),
            icon: Icons.medical_services_outlined,
            accentColor: _purple,
            items: controller.specialties,
            onChanged: (val) => controller.selectedSpecialty.value = val ?? '',
            itemLabel: (item) => item,
          )),
          16.verticalSpace,
          AppAuthField(
            controller: controller.phoneController,
            label: tr(LocaleKeys.complete_profile_fields_phone_hint),
            icon: Icons.phone_outlined,
            accentColor: _purple,
            keyboardType: TextInputType.phone,
            inputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
