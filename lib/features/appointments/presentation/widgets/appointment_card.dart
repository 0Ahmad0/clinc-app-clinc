import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/appointment.dart';
import '../../domain/appointment_status.dart';
import '../appointment_kind_style.dart';
import '../appointment_status_style.dart';
import '../cubit/appointments_cubit.dart';
import 'appointment_actions.dart';

/// A single appointment in the list: patient summary plus the status-specific
/// action row (accept/reject while pending, finish while confirmed) and the
/// rejection reason when rejected.
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.status,
    required this.reason,
  });

  final Appointment appointment;
  final AppointmentStatus status;
  final String? reason;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final cubit = context.read<AppointmentsCubit>();
    final accent = status.accent(colors);
    final kindAccent = appointment.kind.accent(colors);
    return Material(
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: colors.line),
      ),
      clipBehavior: Clip.antiAlias,
      shadowColor: AppShadows.homeCard.first.color,
      elevation: 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: BorderDirectional(
            start: BorderSide(color: accent, width: 4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => cubit.open(appointment.id),
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: AppSizes.appointmentAvatar,
                      height: AppSizes.appointmentAvatar,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.13),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        appointment.initial,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  appointment.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: colors.ink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              AppGaps.w8,
                              Container(
                                padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: AppSpacing.xs + 2,
                                  vertical: AppSpacing.xxs,
                                ),
                                decoration: BoxDecoration(
                                  color: accent.withValues(alpha: 0.13),
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.pill,
                                  ),
                                ),
                                child: Text(
                                  status.label(l10n),
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: accent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppGaps.h8,
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: BoxDecoration(
                              color: kindAccent.withValues(alpha: 0.11),
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              appointment.service,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: kindAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          AppGaps.h8,
                          Row(
                            children: [
                              Icon(
                                Iconsax.clock,
                                size: AppSizes.iconXs,
                                color: colors.muted,
                              ),
                              const SizedBox(width: AppSpacing.xxs + 1),
                              Text(
                                appointment.time,
                                textDirection: TextDirection.ltr,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: colors.gray,
                                ),
                              ),
                              AppGaps.w12,
                              Icon(
                                Iconsax.call,
                                size: AppSizes.iconXs,
                                color: colors.muted,
                              ),
                              const SizedBox(width: AppSpacing.xxs + 1),
                              Flexible(
                                child: Text(
                                  appointment.phone,
                                  textDirection: TextDirection.ltr,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: colors.gray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppGaps.w8,
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Iconsax.arrow_left_2
                          : Iconsax.arrow_right_3,
                      size: AppSizes.iconSm,
                      color: colors.muted.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ),
            ),
            if (status == AppointmentStatus.pending)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: l10n.apptAccept,
                        icon: Iconsax.tick_circle,
                        variant: AppButtonVariant.success,
                        onPressed: () => cubit.accept(appointment.id),
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: AppButton(
                        label: l10n.apptReject,
                        icon: Iconsax.close_circle,
                        variant: AppButtonVariant.danger,
                        onPressed: () =>
                            openRejectSheet(context, cubit, appointment.id),
                      ),
                    ),
                  ],
                ),
              ),
            if (status == AppointmentStatus.confirmed)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: AppButton(
                  label: appointment.kind.finishLabel(l10n),
                  icon: Iconsax.tick_square,
                  onPressed: () =>
                      openFinishSheet(context, cubit, appointment),
                ),
              ),
            if (status == AppointmentStatus.rejected && reason != null)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Container(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: colors.danger.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: colors.danger.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Iconsax.info_circle,
                        size: AppSizes.iconXs,
                        color: colors.dangerFg,
                      ),
                      AppGaps.w8,
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${l10n.apptRejectReasonPrefix}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: reason),
                            ],
                          ),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.dangerFg,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
