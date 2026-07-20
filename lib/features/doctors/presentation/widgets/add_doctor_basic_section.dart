import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_section_card.dart';
import 'add_doctor_specialty_picker.dart';
import 'add_doctor_text_field.dart';

/// Basic-info card: names, specialty, fee and contact details.
class AddDoctorBasicSection extends StatelessWidget {
  const AddDoctorBasicSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSectionCard(
      icon: Iconsax.user,
      tint: context.colors.primary600,
      title: l10n.addDoctorBasicSection,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AddDoctorTextField(
                  icon: Iconsax.user,
                  hint: l10n.addDoctorNameAr,
                ),
              ),
              AppGaps.w12,
              Expanded(
                child: AddDoctorTextField(
                  icon: Iconsax.user,
                  hint: l10n.addDoctorNameEn,
                ),
              ),
            ],
          ),
          AppGaps.h12,
          const AddDoctorSpecialtyPicker(),
          AppGaps.h12,
          AddDoctorTextField(
            icon: Iconsax.money_2,
            hint: l10n.addDoctorFee,
            keyboardType: TextInputType.number,
          ),
          AppGaps.h12,
          Row(
            children: [
              Expanded(
                child: AddDoctorTextField(
                  icon: Iconsax.call,
                  hint: l10n.addDoctorPhone,
                  keyboardType: TextInputType.phone,
                ),
              ),
              AppGaps.w12,
              Expanded(
                child: AddDoctorTextField(
                  icon: Iconsax.sms,
                  hint: l10n.addDoctorEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
