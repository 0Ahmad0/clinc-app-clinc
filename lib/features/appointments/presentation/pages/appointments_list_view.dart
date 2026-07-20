import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../appointments_catalog.dart';
import '../cubit/appointments_cubit.dart';
import '../cubit/appointments_state.dart';
import '../widgets/appointment_card.dart';
import '../widgets/appointments_empty.dart';
import '../widgets/appointments_header.dart';
import '../widgets/appointments_tabs.dart';

/// The appointments list: header, status tabs, the filtered list and the
/// floating bottom navigation.
class AppointmentsListView extends StatelessWidget {
  const AppointmentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final all = localizedAppointments(context.l10n);
    return Stack(
      children: [
        Column(
          children: [
            AppointmentsHeader(appointments: all),
            AppointmentsTabs(appointments: all),
            Expanded(
              child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
                builder: (context, state) {
                  final cubit = context.read<AppointmentsCubit>();
                  final visible = cubit.visible(all);
                  if (visible.isEmpty) return const AppointmentsEmpty();
                  return ListView.separated(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.screen,
                      AppSpacing.sm,
                      AppSpacing.screen,
                      AppSizes.homeBottomClearance,
                    ),
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => AppGaps.h12,
                    itemBuilder: (context, index) {
                      final appointment = visible[index];
                      return AppointmentCard(
                        appointment: appointment,
                        status: cubit.statusOf(appointment),
                        reason: cubit.reasonOf(appointment),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: AppBottomNavigation(activeRoute: AppRoutes.appointments),
        ),
      ],
    );
  }
}
