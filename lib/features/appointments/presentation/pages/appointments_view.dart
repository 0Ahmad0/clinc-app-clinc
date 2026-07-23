import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/appointments_cubit.dart';
import '../cubit/appointments_state.dart';
import 'appointment_detail_view.dart';
import 'appointments_list_view.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.bg,
    body: BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        final selected = state.selected;
        return PopScope(
          canPop: selected == null,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) context.read<AppointmentsCubit>().closeDetail();
          },
          child: selected == null
              ? const AppointmentsListView()
              : AppointmentDetailView(appointment: selected),
        );
      },
    ),
  );
}
