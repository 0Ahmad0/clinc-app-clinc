import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../../domain/report_breakdown.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';
import '../reports_catalog.dart';
import '../widgets/reports_chart_card.dart';
import '../widgets/reports_export_buttons.dart';
import '../widgets/reports_header.dart';
import '../widgets/reports_list.dart';
import '../widgets/reports_period_toggle.dart';
import '../widgets/reports_stat_cards.dart';
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
          BlocBuilder<ReportsCubit, ReportsState>(
            builder: (context, state) {
              final chart = reportChart(l10n, state.period);
              final totals = chart.fold(
                ReportBreakdown.zero,
                (sum, bar) => sum + bar.$2,
              );
              return SingleChildScrollView(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSizes.homeBottomClearance,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ReportsHeader(totals: totals),
                    const ReportsPeriodToggle(),
                    const ReportsTypeChips(),
                    ReportsStatCards(totals: totals),
                    ReportsChartCard(period: state.period, chart: chart),
                    const ReportsExportButtons(),
                    ReportsList(
                      type: state.type,
                      entries: reportEntries(l10n),
                    ),
                  ],
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
