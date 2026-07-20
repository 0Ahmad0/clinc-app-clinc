import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_tab_chip.dart';
import '../../domain/appointment.dart';
import '../../domain/appointment_status.dart';
import '../../domain/appointment_tab.dart';
import '../appointment_status_style.dart';
import '../cubit/appointments_cubit.dart';
import '../cubit/appointments_state.dart';

/// Horizontally scrolling status filter row with per-tab counts.
class AppointmentsTabs extends StatelessWidget {
  const AppointmentsTabs({super.key, required this.appointments});

  final List<Appointment> appointments;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        final cubit = context.read<AppointmentsCubit>();
        int countFor(AppointmentTab tab) => switch (tab) {
          AppointmentTab.all => appointments.length,
          AppointmentTab.pending => cubit.countOf(
            appointments,
            AppointmentStatus.pending,
          ),
          AppointmentTab.confirmed => cubit.countOf(
            appointments,
            AppointmentStatus.confirmed,
          ),
          AppointmentTab.done => cubit.countOf(
            appointments,
            AppointmentStatus.done,
          ),
          AppointmentTab.rejected => cubit.countOf(
            appointments,
            AppointmentStatus.rejected,
          ),
        };
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.xxs,
          ),
          child: Row(
            children: [
              for (final tab in AppointmentTab.values)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                  child: AppTabChip(
                    label: tab.label(l10n),
                    count: format.format(countFor(tab)),
                    selected: state.tab == tab,
                    onTap: () => cubit.selectTab(tab),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
