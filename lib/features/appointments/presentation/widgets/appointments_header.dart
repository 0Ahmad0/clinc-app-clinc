import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/appointment.dart';
import '../../domain/appointment_status.dart';
import '../cubit/appointments_cubit.dart';
import '../cubit/appointments_state.dart';

/// Blue gradient header for the list view: calendar icon, title, a summary line
/// and confirmed / done stat pills.
class AppointmentsHeader extends StatelessWidget {
  const AppointmentsHeader({super.key, required this.appointments});

  final List<Appointment> appointments;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        final cubit = context.read<AppointmentsCubit>();
        final pending = cubit.countOf(appointments, AppointmentStatus.pending);
        final confirmed = cubit.countOf(
          appointments,
          AppointmentStatus.confirmed,
        );
        final done = cubit.countOf(appointments, AppointmentStatus.done);
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
                  MediaQuery.paddingOf(context).top + AppSpacing.md,
                  AppSpacing.screen,
                  AppSpacing.lg,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSizes.doctorsHeaderIcon,
                      height: AppSizes.doctorsHeaderIcon,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(AppRadius.field),
                      ),
                      child: Icon(
                        Iconsax.calendar,
                        color: colors.onBrand,
                        size: AppSizes.iconLg,
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.apptTitle,
                            style: context.textTheme.titleLarge?.copyWith(
                              color: colors.onBrand,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            l10n.apptHeaderLine(
                              format.format(appointments.length),
                              format.format(pending),
                            ),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.onBrand.withValues(alpha: 0.72),
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (final pill in [
                      (format.format(confirmed), l10n.apptStatConfirmed),
                      (format.format(done), l10n.apptStatDone),
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
                          color: colors.onBrand.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppRadius.field),
                        ),
                        child: Column(
                          children: [
                            Text(
                              pill.$1,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: colors.onBrand,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              pill.$2,
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
