import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../../../../shared/widgets/app_section_shimmers.dart';
import '../../../../shared/widgets/app_shimmer_placeholder.dart';
import '../cubit/appointments_cubit.dart';
import '../cubit/appointments_state.dart';
import '../widgets/appointment_card.dart';
import '../widgets/appointments_empty.dart';
import '../widgets/appointments_header.dart';
import '../widgets/appointments_tabs.dart';

class AppointmentsListView extends StatelessWidget {
  const AppointmentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const AppointmentsHeader(),
            const AppointmentsTabs(),
            Expanded(
              child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
                builder: (context, state) => RefreshIndicator(
                  onRefresh: context.read<AppointmentsCubit>().refresh,
                  child: AnimatedBuilder(
                    animation: state.pagination.items,
                    builder: (context, _) {
                      final appointments = state.pagination.items.value;
                      if (state.pagination.isInitialLoading.value &&
                          appointments.isEmpty) {
                        return const ListShimmer(itemHeight: 116);
                      }
                      if (appointments.isEmpty)
                        return const AppointmentsEmpty();
                      return ListView.separated(
                        controller: context
                            .read<AppointmentsCubit>()
                            .scrollController,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.screen,
                          AppSpacing.sm,
                          AppSpacing.screen,
                          AppSizes.homeBottomClearance,
                        ),
                        itemCount:
                            appointments.length +
                            (state.pagination.hasMore ? 1 : 0),
                        separatorBuilder: (_, __) => AppGaps.h12,
                        itemBuilder: (context, index) {
                          if (index >= appointments.length) {
                            return const AppShimmerPlaceholder(
                              height: 116,
                              borderRadius: AppRadius.card,
                            );
                          }
                          return AppointmentCard(
                            appointment: appointments[index],
                          );
                        },
                      );
                    },
                  ),
                ),
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
