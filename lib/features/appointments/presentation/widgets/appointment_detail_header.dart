import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/appointment.dart';
import '../../domain/appointment_status.dart';
import '../appointment_status_style.dart';
import '../cubit/appointments_cubit.dart';

/// Gradient hero for the appointment detail: back button, avatar, name, service
/// and status chips.
class AppointmentDetailHeader extends StatelessWidget {
  const AppointmentDetailHeader({
    super.key,
    required this.appointment,
    required this.status,
  });

  final Appointment appointment;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: colors.headerGradient,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.homeHeader),
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -AppSizes.homeHeaderCircleTop,
            start: -AppSizes.homeHeaderCircleStart,
            child: Container(
              width: AppSizes.homeHeaderCircleSmall,
              height: AppSizes.homeHeaderCircleSmall,
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
              MediaQuery.paddingOf(context).top + AppSpacing.xs,
              AppSpacing.screen,
              AppSpacing.lg,
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox.square(
                    dimension: AppSizes.hitTarget,
                    child: Material(
                      color: colors.onBrand.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(AppRadius.field),
                      child: InkWell(
                        onTap: () =>
                            context.read<AppointmentsCubit>().closeDetail(),
                        borderRadius: BorderRadius.circular(AppRadius.field),
                        child: Icon(
                          rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                          color: colors.onBrand,
                          size: AppSizes.iconMd,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: AppSizes.appointmentDetailAvatar,
                  height: AppSizes.appointmentDetailAvatar,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.onBrand.withValues(alpha: 0.16),
                    border: Border.all(
                      color: colors.onBrand.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    appointment.initial,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: colors.onBrand,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppGaps.h12,
                Text(
                  appointment.name,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: colors.onBrand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppGaps.h12,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        appointment.service,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.onBrand,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AppGaps.w8,
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        status.label(context.l10n),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: status.accent(colors),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
