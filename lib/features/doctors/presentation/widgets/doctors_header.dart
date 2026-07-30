import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/doctors_cubit.dart';
import '../cubit/doctors_state.dart';

class DoctorsHeader extends StatelessWidget {
  const DoctorsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        final total = state.totalCount;
        final available = state.availableCount;
        final unavailable = state.unavailableCount;
        final format = NumberFormat.decimalPattern(
          Localizations.localeOf(context).toLanguageTag(),
        );
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: colors.headerGradient,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppRadius.sheet),
            ),
          ),
          child: Stack(
            children: [
              PositionedDirectional(
                top: -AppSizes.doctorsHeaderCircleTop,
                end: -AppSizes.doctorsHeaderCircleEnd,
                child: Container(
                  width: AppSizes.doctorsHeaderCircle,
                  height: AppSizes.doctorsHeaderCircle,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.onBrand.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.screen,
                  MediaQuery.paddingOf(context).top + AppSpacing.lg,
                  AppSpacing.screen,
                  AppSpacing.lg,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSizes.doctorsHeaderIcon,
                      height: AppSizes.doctorsHeaderIcon,
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(AppRadius.field),
                      ),
                      child: Icon(
                        Iconsax.profile_2user,
                        color: colors.onBrand,
                        size: AppSizes.iconLg,
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.doctorsTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleLarge?.copyWith(
                              color: colors.onBrand,
                              fontWeight: FontWeight.w700,
                              height: 1.05,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            context.l10n.doctorsHeaderLine(
                              format.format(total),
                              format.format(available),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.onBrand.withValues(alpha: 0.72),
                              height: 1.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (final item in [
                      (format.format(total), context.l10n.doctorsTotal),
                      (
                        format.format(unavailable),
                        context.l10n.doctorsUnavailable,
                      ),
                    ])
                      Container(
                        margin: const EdgeInsetsDirectional.only(
                          start: AppSpacing.xs,
                        ),
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: colors.onBrand.withValues(alpha: 0.13),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              item.$1,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: colors.onBrand,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              item.$2,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.onBrand.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
