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
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            tr('complete_profile.fields.insurances'),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        8.verticalSpace,
        Obx(() {
          if (controller.isLoadingInsurances.value) {
            return const LinearProgressIndicator();
          }
          return Align(
            alignment: AlignmentDirectional.centerStart,
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: controller.insurances.map((insurance) {
                final selected = controller.selectedInsuranceIds.contains(
                  insurance.id,
                );
                return FilterChip(
                  label: Text(insurance.name),
                  selected: selected,
                  onSelected: (value) =>
                      controller.toggleInsurance(insurance.id, value),
                );
              }).toList(),
            ),
          );
        }),
        16.verticalSpace,

        AppTextFormFieldWidget(
          controller: controller.phoneController,
          hintText: tr(LocaleKeys.complete_profile_fields_phone_hint),
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: controller.validatePhone,
        ),
      ],
    );
  }
}
