import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/add_doctor_controller.dart';

class GenderSelectorWidget extends GetView<AddDoctorController> {
  const GenderSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildGenderOption(context, 'male', LocaleKeys.add_doctor_labels_gmale)),
        16.horizontalSpace,
        Expanded(child: _buildGenderOption(context, 'female', LocaleKeys.add_doctor_labels_gfemale)),
      ],
    );
  }

  Widget _buildGenderOption(BuildContext context, String value, String labelKey) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(() {
      final isSelected = controller.selectedGender.value == value;
      return InkWell(
        onTap: () => controller.setGender(value),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.primary.withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? colorScheme.primary : colorScheme.outline.withOpacity(0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              tr(labelKey),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
          ),
        ),
      );
    });
  }
}