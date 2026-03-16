import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/app_form_field.dart';
import '../../../../app/core/widgets/app_styled_dropdown.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class BasicInfoSection extends StatelessWidget {
  final AddDoctorController controller;
  const BasicInfoSection({super.key, required this.controller});

  static const _color = Color(0xFF3949AB);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppFormField(
                controller: controller.nameArController,
                label: tr(LocaleKeys.add_doctor_labels_name_ar),
                icon: Icons.person_outline_rounded,
                accentColor: _color,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: AppFormField(
                controller: controller.nameEnController,
                label: tr(LocaleKeys.add_doctor_labels_name_en),
                icon: Icons.person_outline_rounded,
                accentColor: _color,
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Obx(() => AppStyledDropdown<String>(
          value: controller.selectedSpecialty.value.isEmpty
              ? null
              : controller.selectedSpecialty.value,
          label: tr(LocaleKeys.add_doctor_labels_specialty),
          icon: Icons.local_hospital_rounded,
          accentColor: _color,
          items: controller.specialties,
          onChanged: (v) => controller.selectedSpecialty.value = v!,
        )),
        16.verticalSpace,
        AppFormField(
          controller: controller.feeController,
          label: tr(LocaleKeys.add_doctor_labels_fee),
          icon: Icons.attach_money_rounded,
          accentColor: _color,
          isNumber: true,
        ),
        16.verticalSpace,
        Row(
          children: [
            Expanded(
              child: AppFormField(
                controller: controller.phoneController,
                label: tr(LocaleKeys.add_doctor_labels_phone),
                icon: Icons.phone_rounded,
                accentColor: _color,
                isNumber: true,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: AppFormField(
                controller: controller.emailController,
                label: tr(LocaleKeys.add_doctor_labels_email),
                icon: Icons.email_outlined,
                accentColor: _color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
