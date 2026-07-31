import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../data/models/clinic_report_model.dart';
import '../../domain/report_breakdown.dart';
import '../cubit/reports_cubit.dart';
import '../reports_catalog.dart';
import '../widgets/reports_chart_card.dart';
import '../widgets/reports_export_buttons.dart';
import '../widgets/reports_header.dart';
import '../widgets/reports_list.dart';
import '../widgets/reports_period_toggle.dart';
import '../widgets/reports_stat_cards.dart';
import '../widgets/reports_summary_shimmer.dart';
import '../widgets/reports_type_chips.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: Stack(
        children: [
          BlocConsumer<ReportsCubit, ReportsState>(
            listenWhen: (previous, current) =>
                previous.exportedReport != current.exportedReport ||
                previous.failure != current.failure,
            listener: (context, state) {
              if (state.exportedReport != null) {
                AppToast.show(
                  context,
                  title: context.l10n.reportsExportSoonTitle,
                  message:
                      state.exportMessage ??
                      context.l10n.reportsExportSoonMessage,
                  type: AppFeedbackType.success,
                );
              }
              if (state.failure != null) {
                AppToast.show(
                  context,
                  title: context.l10n.reportsExportSoonTitle,
                  message: state.failure.toString(),
                  type: AppFeedbackType.danger,
                );
              }
            },
            builder: (context, state) {
              final List<(String, ReportBreakdown)> chart =
                  state.summary?.chartBars ?? reportChart(l10n, state.period);
              final ReportBreakdown totals =
                  state.summary?.breakdown ??
                  chart.fold(ReportBreakdown.zero, (sum, bar) => sum + bar.$2);
              return RefreshIndicator(
                onRefresh: context.read<ReportsCubit>().refresh,
                child: SingleChildScrollView(
                  controller: context.read<ReportsCubit>().scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsetsDirectional.only(
                    bottom: AppSizes.homeBottomClearance,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ReportsHeader(totals: totals),
                      const ReportsPeriodToggle(),
                      const ReportsTypeChips(),
                      if (state.isSummaryLoading)
                        const ReportsSummaryShimmer()
                      else ...[
                        ReportsStatCards(totals: totals),
                        ReportsChartCard(period: state.period, chart: chart),
                      ],
                      const ReportsExportButtons(),
                      const ReportsList(),
                    ],
                  ),
                ),
              );
            },
          ),
          const Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: AppBottomNavigation(activeRoute: AppRoutes.reports),
          ),
        ],
      ),
    );
  }
}
