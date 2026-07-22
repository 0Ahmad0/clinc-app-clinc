import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Bottom action bar over a fade: the primary "appointments" button and a
/// secondary call button.
class DoctorProfileCta extends StatelessWidget {
  const DoctorProfileCta({super.key, required this.onBook});

  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.sm,
        AppSpacing.screen,
        MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [colors.bg, colors.bg.withValues(alpha: 0)],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(AppRadius.field),
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: colors.ctaGradient,
                  borderRadius: BorderRadius.circular(AppRadius.field),
                  boxShadow: AppShadows.primaryButton,
                ),
                child: InkWell(
                  onTap: onBook,
                  borderRadius: BorderRadius.circular(AppRadius.field),
                  child: SizedBox(
                    height: AppSizes.buttonHeightSm,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.calendar,
                          color: colors.onBrand,
                          size: AppSizes.iconMd,
                        ),
                        AppGaps.w8,
                        Text(
                          context.l10n.doctorProfileBook,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: colors.onBrand,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppGaps.w12,
          Container(
            width: AppSizes.buttonHeightSm,
            height: AppSizes.buttonHeightSm,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary500.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.field),
              border: Border.all(
                color: colors.primary500.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Icon(
              Iconsax.call,
              color: colors.primary600,
              size: AppSizes.iconMd,
            ),
          ),
        ],
      ),
    );
  }
}
