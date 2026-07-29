import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../../../../shared/widgets/app_section_shimmers.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/widgets/shared_empty_widget.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_appointments_section.dart';
import '../widgets/home_stats_section.dart';
import '../widgets/home_top_section.dart';

/// Main dashboard layout matching the supplied 390 × 844 reference.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) => previous.failure != current.failure,
        listener: (context, state) {
          final failure = state.failure;
          if (failure == null) return;
          AppToast.show(
            context,
            title: context.l10n.toastFailure,
            message: NetworkExceptions.getErrorMessage(failure),
            type: AppFeedbackType.danger,
          );
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final dashboard = state.dashboard;
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () => context.read<HomeCubit>().loadDashboard(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSizes.homeBottomClearance,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HomeTopSection(dashboard: dashboard),
                        if (state.isLoading && dashboard == null)
                          const HomeDashboardShimmer()
                        else if (dashboard == null)
                          SharedEmptyWidget(
                            icon: Icons.dashboard_outlined,
                            title: context.l10n.noDataYet,
                            subtitle: context.l10n.homeStatsTitle,
                          )
                        else ...[
                          HomeStatsSection(stats: dashboard.stats),
                          HomeAppointmentsSection(
                            appointments: dashboard.appointments,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: AppBottomNavigation(activeRoute: AppRoutes.home),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
