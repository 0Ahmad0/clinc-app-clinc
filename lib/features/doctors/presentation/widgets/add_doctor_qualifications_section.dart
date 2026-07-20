import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_section_card.dart';

/// Qualifications card: a tap target to upload PDF certificates (picker wired
/// once the upload endpoint exists).
class AddDoctorQualificationsSection extends StatelessWidget {
  const AddDoctorQualificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return AppSectionCard(
      icon: Iconsax.document_upload,
      tint: colors.info,
      title: l10n.addDoctorQualSection,
      child: Material(
        color: colors.surface.withValues(alpha: 0),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: AppSizes.addDoctorUploadHeight,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // ponytail: solid border stands in for the design's dashed one;
              // a dashed stroke needs a CustomPainter — add if design insists.
              color: colors.primary500.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(AppRadius.button),
              border: Border.all(
                color: colors.primary500.withValues(alpha: 0.35),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.document_upload,
                  size: AppSizes.iconLg + AppSpacing.xs,
                  color: colors.primary600,
                ),
                AppGaps.h8,
                Text(
                  l10n.addDoctorUploadTitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.primary600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  l10n.addDoctorUploadHint,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
