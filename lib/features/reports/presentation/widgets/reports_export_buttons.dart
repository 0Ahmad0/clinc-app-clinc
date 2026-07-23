import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../cubit/reports_cubit.dart';

class ReportsExportButtons extends StatelessWidget {
  const ReportsExportButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ReportsCubit, ReportsState>(
      buildWhen: (previous, current) =>
          previous.isExportingPdf != current.isExportingPdf ||
          previous.isExportingXlsx != current.isExportingXlsx,
      builder: (context, state) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.screen,
          AppSpacing.md,
          AppSpacing.screen,
          0,
        ),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                label: state.isExportingPdf ? '...' : l10n.reportsExportPdf,
                icon: Iconsax.document_text,
                onPressed: state.isExportingPdf
                    ? null
                    : context.read<ReportsCubit>().exportPdf,
              ),
            ),
            AppGaps.w12,
            Expanded(
              child: AppButton(
                label: state.isExportingXlsx ? '...' : 'XLSX',
                icon: Iconsax.grid_1,
                variant: AppButtonVariant.secondary,
                onPressed: state.isExportingXlsx
                    ? null
                    : context.read<ReportsCubit>().exportXlsx,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
