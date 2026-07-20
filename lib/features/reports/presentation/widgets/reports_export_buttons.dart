import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_toast.dart';

/// PDF / CSV export actions. Real export needs a backend endpoint, so these
/// honestly signal "coming soon" rather than faking a download.
class ReportsExportButtons extends StatelessWidget {
  const ReportsExportButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
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
              label: l10n.reportsExportPdf,
              icon: Iconsax.document_text,
              onPressed: () => _soon(context),
            ),
          ),
          AppGaps.w12,
          Expanded(
            child: AppButton(
              label: l10n.reportsExportCsv,
              icon: Iconsax.grid_1,
              variant: AppButtonVariant.secondary,
              onPressed: () => _soon(context),
            ),
          ),
        ],
      ),
    );
  }

  void _soon(BuildContext context) => AppToast.show(
    context,
    title: context.l10n.reportsExportSoonTitle,
    message: context.l10n.reportsExportSoonMessage,
    type: AppFeedbackType.info,
  );
}
