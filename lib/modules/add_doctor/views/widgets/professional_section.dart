import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/app_form_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class ProfessionalSection extends StatelessWidget {
  final AddDoctorController controller;
  const ProfessionalSection({super.key, required this.controller});

  static const _color = Color(0xFF1565C0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFormField(
          controller: controller.licenseController,
          label: tr(LocaleKeys.add_doctor_labels_license),
          icon: Icons.badge_rounded,
          accentColor: _color,
        ),
        16.verticalSpace,
        AppFormField(
          controller: controller.experienceController,
          label: tr(LocaleKeys.add_doctor_labels_experience),
          icon: Icons.star_rate_rounded,
          accentColor: _color,
          isNumber: true,
        ),
        16.verticalSpace,
        AppFormField(
          controller: controller.aboutController,
          label: tr(LocaleKeys.add_doctor_labels_about),
          icon: Icons.notes_rounded,
          accentColor: _color,
          maxLines: 3,
          isRequired: false,
        ),
      ],
    );
  }
}
