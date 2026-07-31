import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../data/models/clinic_appointment_model.dart';
import '../appointment_kind_style.dart';
import '../appointment_status_style.dart';
import '../cubit/appointments_cubit.dart';
import 'appointment_actions.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointment});

  final ClinicAppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final cubit = context.read<AppointmentsCubit>();
    final state = context.watch<AppointmentsCubit>().state;
    final status = appointment.statusValue;
    final kind = appointment.kindValue;
    final accent = status.accent(colors);
    final kindAccent = kind.accent(colors);
    final name = appointment.patientName ?? '-';
    final id = appointment.appointmentId;
    final isBusy = state.busyAppointmentId == id;
    final isAccepting =
        isBusy && state.busyAction == AppointmentsCubit.acceptAction;
    final isRejecting =
        isBusy && state.busyAction == AppointmentsCubit.rejectAction;
    final isFinishing =
        isBusy && state.busyAction == AppointmentsCubit.finishAction;
    final isUploading =
        isBusy && state.busyAction == AppointmentsCubit.uploadResultAction;
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
          border: BorderDirectional(start: BorderSide(color: accent, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                if (id != null) cubit.open(id);
              },
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
                        name.characters.isEmpty ? '-' : name.characters.first,
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
                                  name,
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
                              appointment.serviceName ?? '-',
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
                                appointment.formattedDateTime,
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
                                  appointment.patientPhone ?? '',
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
            if (appointment.status == 'pending')
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
                        isLoading: isAccepting,
                        onPressed: id == null || isBusy
                            ? null
                            : () => cubit.accept(id),
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: AppButton(
                        label: l10n.apptReject,
                        icon: Iconsax.close_circle,
                        variant: AppButtonVariant.danger,
                        isLoading: isRejecting,
                        onPressed: id == null || isBusy
                            ? null
                            : () => openRejectSheet(context, cubit, id),
                      ),
                    ),
                  ],
                ),
              ),
            if (appointment.status == 'accepted')
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: kind.requiresResult
                    ? Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              label: l10n.apptFinish,
                              icon: Iconsax.tick_square,
                              isLoading: isFinishing,
                              onPressed: id == null || isBusy
                                  ? null
                                  : () => openFinishSheet(
                                      context,
                                      cubit,
                                      appointment,
                                    ),
                            ),
                          ),
                          AppGaps.w12,
                          Expanded(
                            child: AppButton(
                              label: _uploadResultLabel(context),
                              icon: Iconsax.document_upload,
                              variant: AppButtonVariant.secondary,
                              isLoading: isUploading,
                              onPressed: id == null || isBusy
                                  ? null
                                  : () => openResultSheet(
                                      context,
                                      cubit,
                                      appointment,
                                    ),
                            ),
                          ),
                        ],
                      )
                    : AppButton(
                        label: l10n.apptFinish,
                        icon: Iconsax.tick_square,
                        isLoading: isFinishing,
                        onPressed: id == null || isBusy
                            ? null
                            : () =>
                                  openFinishSheet(context, cubit, appointment),
                      ),
              ),
            if (appointment.status == 'rejected' &&
                appointment.rejectionReason != null)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Text(
                  appointment.rejectionReason!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.dangerFg,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _uploadResultLabel(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'رفع النتيجة'
      : 'Upload result';
}
