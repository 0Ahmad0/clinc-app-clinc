import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_section_card.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../domain/appointment.dart';
import '../../domain/appointment_status.dart';
import '../appointment_kind_style.dart';
import '../cubit/appointments_cubit.dart';
import '../widgets/appointment_actions.dart';
import '../widgets/appointment_detail_header.dart';
import '../widgets/appointment_info_row.dart';

/// Full-screen appointment detail: patient info, appointment details and the
/// status-specific action card.
class AppointmentDetailView extends StatelessWidget {
  const AppointmentDetailView({
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
    final hasActions =
        status == AppointmentStatus.pending ||
        status == AppointmentStatus.confirmed;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AppointmentDetailHeader(appointment: appointment, status: status),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.md + 2,
            AppSpacing.screen,
            AppSpacing.xl,
          ),
          child: Column(
            children: [
              AppSectionCard(
                icon: Iconsax.user,
                tint: colors.primary600,
                title: l10n.apptPatientSection,
                child: Column(
                  children: [
                    AppointmentInfoRow(
                      icon: Iconsax.user,
                      label: l10n.apptRowName,
                      value: appointment.name,
                    ),
                    AppGaps.h12,
                    AppointmentInfoRow(
                      icon: Iconsax.call,
                      label: l10n.apptRowPhone,
                      value: appointment.phone,
                    ),
                  ],
                ),
              ),
              AppGaps.h16,
              AppSectionCard(
                icon: Iconsax.calendar,
                tint: colors.purple,
                title: l10n.apptDetailsSection,
                child: Column(
                  children: [
                    AppointmentInfoRow(
                      icon: Iconsax.briefcase,
                      label: l10n.apptRowService,
                      value: appointment.service,
                    ),
                    AppGaps.h12,
                    AppointmentInfoRow(
                      icon: Iconsax.calendar,
                      label: l10n.apptRowDate,
                      value: l10n.apptSampleDate,
                    ),
                    AppGaps.h12,
                    AppointmentInfoRow(
                      icon: Iconsax.clock,
                      label: l10n.apptRowTime,
                      value: appointment.time,
                    ),
                    if (reason != null) ...[
                      AppGaps.h12,
                      AppointmentInfoRow(
                        icon: Iconsax.info_circle,
                        label: l10n.apptRejectReasonPrefix,
                        value: reason!,
                      ),
                    ],
                  ],
                ),
              ),
              if (hasActions) ...[
                AppGaps.h16,
                AppSectionCard(
                  icon: Iconsax.flash_1,
                  tint: colors.successFg,
                  title: l10n.apptActionsSection,
                  child: status == AppointmentStatus.pending
                      ? Row(
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
                                onPressed: () => openRejectSheet(
                                  context,
                                  cubit,
                                  appointment.id,
                                ),
                              ),
                            ),
                          ],
                        )
                      : AppButton(
                          label: appointment.kind.finishLabel(l10n),
                          icon: Iconsax.tick_square,
                          onPressed: () =>
                              openFinishSheet(context, cubit, appointment),
                        ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
