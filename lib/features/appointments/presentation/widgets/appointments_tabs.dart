import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_tab_chip.dart';
import '../../domain/appointment_tab.dart';
import '../appointment_status_style.dart';
import '../cubit/appointments_cubit.dart';
import '../cubit/appointments_state.dart';

class AppointmentsTabs extends StatelessWidget {
  const AppointmentsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        final counts = {
          AppointmentTab.all: state.totalCount,
          AppointmentTab.pending: state.pendingCount,
          AppointmentTab.confirmed: state.confirmedCount,
          AppointmentTab.done: state.doneCount,
          AppointmentTab.rejected: state.rejectedCount,
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
                    count: format.format(counts[tab] ?? 0),
                    selected: state.tab == tab,
                    onTap: () =>
                        context.read<AppointmentsCubit>().selectTab(tab),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
