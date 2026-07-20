import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/extensions/context_extensions.dart';
import '../appointments_catalog.dart';
import '../cubit/appointments_cubit.dart';
import '../cubit/appointments_state.dart';
import 'appointment_detail_view.dart';
import 'appointments_list_view.dart';

/// Switches between the appointments list and a selected appointment's detail;
/// system-back closes the detail before leaving the screen.
class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.bg,
    body: BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        final cubit = context.read<AppointmentsCubit>();
        final selected = cubit.selected(localizedAppointments(context.l10n));
        return PopScope(
          canPop: selected == null,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) cubit.closeDetail();
          },
          child: selected == null
              ? const AppointmentsListView()
              : AppointmentDetailView(
                  appointment: selected,
                  status: cubit.statusOf(selected),
                  reason: cubit.reasonOf(selected),
                ),
        );
      },
    ),
  );
}
