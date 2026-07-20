import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../domain/report_breakdown.dart';
import '../../domain/report_outcome.dart';
import 'report_stat_card.dart';

/// The done / pending / cancelled totals as a three-across stat row.
class ReportsStatCards extends StatelessWidget {
  const ReportsStatCards({super.key, required this.totals});

  final ReportBreakdown totals;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.screen,
      AppSpacing.md,
      AppSpacing.screen,
      0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final outcome in ReportOutcome.values)
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: outcome == ReportOutcome.values.last
                    ? 0
                    : AppSpacing.xs,
              ),
              child: ReportStatCard(
                outcome: outcome,
                value: totals.count(outcome),
              ),
            ),
          ),
      ],
    ),
  );
}
