import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../data/models/clinic_report_model.dart';
import '../reports_l10n.dart';

class ReportEntryCard extends StatelessWidget {
  const ReportEntryCard({super.key, required this.report});

  final ClinicGeneratedReportModel report;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final format = report.format?.toUpperCase() ?? '-';
    final status = report.status ?? '-';
    final fileUri = report.downloadableUri;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        onTap: fileUri == null ? null : () => _openReport(context, fileUri),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
            border: Border.all(color: colors.line),
            boxShadow: AppShadows.homeCard,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
            child: Stack(
              children: [
                PositionedDirectional(
                  top: 0,
                  bottom: 0,
                  start: 0,
                  width: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primary600,
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(AppRadius.homeQuickAction),
                        bottomStart: Radius.circular(AppRadius.homeQuickAction),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.md + 4,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: AppSizes.reportsEntryIcon,
                        height: AppSizes.reportsEntryIcon,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colors.primary500.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.field),
                        ),
                        child: Icon(
                          report.typeValue.icon,
                          color: colors.primary600,
                          size: AppSizes.iconMd,
                        ),
                      ),
                      AppGaps.w12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.typeValue.label(context.l10n),
                              style: context.textTheme.titleSmall?.copyWith(
                                color: colors.ink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xxs),
                            Text(
                              report.formattedGeneratedAt,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppGaps.w8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _Badge(text: format),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            status,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.gray,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (fileUri != null) ...[
                            const SizedBox(height: AppSpacing.xxs),
                            Icon(
                              Icons.open_in_new_rounded,
                              size: AppSizes.iconSm,
                              color: colors.primary600,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openReport(BuildContext context, Uri uri) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (opened) return;
    if (!context.mounted) return;
    AppToast.show(
      context,
      title: context.l10n.toastFailure,
      message: uri.toString(),
      type: AppFeedbackType.danger,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xxs,
    ),
    decoration: BoxDecoration(
      color: context.colors.primary500.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Text(
      text,
      style: context.textTheme.labelSmall?.copyWith(
        color: context.colors.primary600,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
