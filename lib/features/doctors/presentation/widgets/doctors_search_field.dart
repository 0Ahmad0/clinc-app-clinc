import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/doctors_cubit.dart';

/// White rounded search bar with a muted leading icon and soft shadow.
class DoctorsSearchField extends StatelessWidget {
  const DoctorsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.md,
        AppSpacing.screen,
        0,
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSizes.searchBarHeight),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.field),
          border: Border.all(color: colors.line, width: 1.5),
          boxShadow: AppShadows.homeCard,
        ),
        child: Row(
          children: [
            Icon(Iconsax.search_normal_1, size: 19, color: colors.muted),
            AppGaps.w12,
            Expanded(
              child: TextField(
                onChanged: context.read<DoctorsCubit>().search,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.ink,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: context.l10n.doctorsSearchHint,
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: colors.muted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
