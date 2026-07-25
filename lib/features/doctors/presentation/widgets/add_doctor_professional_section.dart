import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_section_card.dart';
import '../cubit/add_doctor_cubit.dart';
import 'add_doctor_text_field.dart';

/// Professional-info card: license, experience and bio.
class AddDoctorProfessionalSection extends StatelessWidget {
  const AddDoctorProfessionalSection({
    super.key,
    required this.licenseController,
    required this.experienceController,
    required this.bioController,
  });

  final TextEditingController licenseController;
  final TextEditingController experienceController;
  final TextEditingController bioController;

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
            controller: licenseController,
          ),
          AppGaps.h12,
          BlocBuilder<AddDoctorCubit, AddDoctorState>(
            builder: (context, state) => Row(
              children: [
                Expanded(
                  child: _GenderChip(
                    label: Localizations.localeOf(context).languageCode == 'ar'
                        ? 'ذكر'
                        : 'Male',
                    selected: state.gender == 'male',
                    onTap: () =>
                        context.read<AddDoctorCubit>().selectGender('male'),
                  ),
                ),
                AppGaps.w12,
                Expanded(
                  child: _GenderChip(
                    label: Localizations.localeOf(context).languageCode == 'ar'
                        ? 'أنثى'
                        : 'Female',
                    selected: state.gender == 'female',
                    onTap: () =>
                        context.read<AddDoctorCubit>().selectGender('female'),
                  ),
                ),
              ],
            ),
          ),
          AppGaps.h12,
          AddDoctorTextField(
            icon: Iconsax.medal_star,
            iconColor: purple,
            hint: l10n.addDoctorExperienceHint,
            keyboardType: TextInputType.number,
            controller: experienceController,
          ),
          AppGaps.h12,
          AddDoctorTextField(
            icon: Iconsax.note_text,
            iconColor: purple,
            hint: l10n.addDoctorBio,
            maxLines: 4,
            controller: bioController,
          ),
        ],
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.field),
      child: Container(
        height: AppSizes.addDoctorFieldHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? colors.primary500.withValues(alpha: 0.1)
              : colors.bg,
          borderRadius: BorderRadius.circular(AppRadius.field),
          border: Border.all(
            color: selected
                ? colors.primary500.withValues(alpha: 0.35)
                : colors.ink.withValues(alpha: 0.08),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: selected ? colors.primary600 : colors.muted,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
