import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';

/// Flat gradient top bar for the profile editor (the cover image sits directly
/// below it).
class SettingsProfileHeader extends StatelessWidget {
  const SettingsProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      decoration: BoxDecoration(gradient: colors.headerGradient),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppSpacing.screen,
          MediaQuery.paddingOf(context).top + AppSpacing.md,
          AppSpacing.screen,
          AppSpacing.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.square(
              dimension: AppSizes.hitTarget,
              child: Material(
                color: colors.onBrand.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(AppRadius.field),
                child: InkWell(
                  onTap: () =>
                      context.read<SettingsCubit>().show(SettingsSection.main),
                  borderRadius: BorderRadius.circular(AppRadius.field),
                  child: Icon(
                    rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                    color: colors.onBrand,
                    size: AppSizes.iconMd,
                  ),
                ),
              ),
            ),
            Text(
              context.l10n.settingsProfileTitle,
              style: context.textTheme.titleMedium?.copyWith(
                color: colors.onBrand,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: AppSizes.hitTarget),
          ],
        ),
      ),
    );
  }
}
