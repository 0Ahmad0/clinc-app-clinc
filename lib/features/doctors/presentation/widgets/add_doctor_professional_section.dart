import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_section_card.dart';
import 'add_doctor_text_field.dart';

/// Professional-info card: license, experience and bio.
class AddDoctorProfessionalSection extends StatelessWidget {
  const AddDoctorProfessionalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final purple = context.colors.purple;
    return AppSectionCard(
      icon: Iconsax.briefcase,
      tint: purple,
      title: l10n.addDoctorProSection,
      child: Column(
        children: [
          AddDoctorTextField(
            icon: Iconsax.personalcard,
            iconColor: purple,
            hint: l10n.addDoctorLicense,
          ),
          AppGaps.h12,
          AddDoctorTextField(
            icon: Iconsax.medal_star,
            iconColor: purple,
            hint: l10n.addDoctorExperienceHint,
            keyboardType: TextInputType.number,
          ),
          AppGaps.h12,
          AddDoctorTextField(
            icon: Iconsax.note_text,
            iconColor: purple,
            hint: l10n.addDoctorBio,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
