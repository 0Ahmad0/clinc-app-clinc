import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// PDF upload target for lab results — the empty prompt, or the picked file's
/// name once [fileName] is set.
class AppointmentUploadBox extends StatelessWidget {
  const AppointmentUploadBox({super.key, this.fileName, required this.onTap});

  final String? fileName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final attached = fileName != null;
    return Material(
      color: colors.surface.withValues(alpha: 0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            // ponytail: solid border stands in for the design's dashed prompt.
            color: attached
                ? colors.success.withValues(alpha: 0.05)
                : colors.primary500.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(
              color: attached
                  ? colors.success.withValues(alpha: 0.4)
                  : colors.primary500.withValues(alpha: 0.4),
              width: attached ? 1.5 : 2,
            ),
          ),
          child: attached
              ? Row(
                  children: [
                    Container(
                      width: AppSizes.hitTarget - 2,
                      height: AppSizes.hitTarget - 2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.danger.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(
                        Iconsax.document_text,
                        color: colors.dangerFg,
                        size: AppSizes.iconMd,
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fileName ?? l10n.apptFileName,
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: colors.ink,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            l10n.apptFileAttached,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.successFg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Icon(
                      Iconsax.document_upload,
                      size: AppSizes.iconLg,
                      color: colors.primary600,
                    ),
                    AppGaps.h8,
                    Text(
                      l10n.apptUploadTitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.primary600,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      l10n.apptUploadHint,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
