import 'package:clinc_app_clinc/app/extension/appointment_type_extensions.dart';
import 'package:clinc_app_clinc/modules/appointments/views/widgets/reject_appointment_bottom_sheet.dart';
import 'package:clinc_app_clinc/modules/appointments/views/widgets/upload_pdf_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/appointment_details_controller.dart';

class AppointmentDetailsView extends GetView<AppointmentDetailsController> {
  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Obx(() {
        final a = controller.appointment.value;
        final dt = DateFormat('EEE, MMM d • hh:mm a').format(a.dateTime);

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: cs.surface,
              elevation: 0,
              centerTitle: true,
              title: Text(
                tr(LocaleKeys.appointments_details_title),
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _InfoCard(
                    title: tr(LocaleKeys.appointments_details_patient_info),
                    children: [
                      _KVRow(label: tr(LocaleKeys.appointments_card_patient), value: a.patientName),
                      if ((a.patientPhone ?? '').isNotEmpty)
                        _KVRow(label: 'Phone', value: a.patientPhone!),
                    ],
                  ),
                  12.verticalSpace,

                  _InfoCard(
                    title: tr(LocaleKeys.appointments_details_appointment_info),
                    children: [
                      _KVRow(label: tr(LocaleKeys.appointments_card_service), value: a.title),
                      _KVRow(label: tr(LocaleKeys.appointments_card_type), value: tr(a.type.key())),
                      _KVRow(label: tr(LocaleKeys.appointments_card_time), value: dt),
                      _KVRow(label: 'Status', value: tr(a.status.key())),
                    ],
                  ),
                  12.verticalSpace,

                  if (a.status == AppointmentStatus.rejected) ...[
                    _InfoCard(
                      title: tr(LocaleKeys.appointments_reject_title),
                      children: [
                        _KVRow(
                          label: tr(LocaleKeys.appointments_reject_reason_label),
                          value: a.rejectReasonKey ?? '-',
                        ),
                        8.verticalSpace,
                        Text(
                          a.rejectNote ?? '-',
                          style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                  ],

                  if (a.type.isLab) ...[
                    _InfoCard(
                      title: tr(LocaleKeys.appointments_details_result),
                      children: [
                        Text(
                          a.hasResult
                              ? tr(LocaleKeys.appointments_details_result_uploaded)
                              : tr(LocaleKeys.appointments_details_result_missing),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: a.hasResult ? cs.primary : cs.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        12.verticalSpace,
                        if (a.hasResult)
                          OutlinedButton(
                            onPressed: () {
                              // لاحقاً: فتح PDF viewer
                            },
                            child: Text(tr(LocaleKeys.appointments_actions_view_result)),
                          ),
                      ],
                    ),
                    12.verticalSpace,
                  ],

                  _ActionsSection(),
                  20.verticalSpace,
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _ActionsSection extends GetView<AppointmentDetailsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Obx(() {
      final a = controller.appointment.value;

      final loading = controller.isLoading.value;

      // Buttons logic:
      final canApproveReject = a.status == AppointmentStatus.pending;
      final canComplete = a.status == AppointmentStatus.approved;
      final canUploadResult = a.type.isLab && a.status == AppointmentStatus.completed && !a.hasResult;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (loading)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: LinearProgressIndicator(color: cs.primary, backgroundColor: cs.surfaceVariant),
            ),

          if (canApproveReject) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: loading
                        ? null
                        : () {
                      Get.bottomSheet(
                        const RejectAppointmentBottomSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.error,
                      side: BorderSide(color: cs.error.withOpacity(0.4)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(tr(LocaleKeys.appointments_actions_reject),
                        style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : controller.approve,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(tr(LocaleKeys.appointments_actions_approve),
                        style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ],

          if (canComplete) ...[
            ElevatedButton(
              onPressed: loading ? null : controller.complete,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text(tr(LocaleKeys.appointments_actions_complete),
                  style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
            ),
          ],

          if (canUploadResult) ...[
            12.verticalSpace,
            ElevatedButton.icon(
              onPressed: loading
                  ? null
                  : () {
                Get.bottomSheet(
                  const UploadPdfBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: Text(tr(LocaleKeys.appointments_actions_upload_result),
                  style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.secondary,
                foregroundColor: cs.onSecondary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ],
        ],
      );
    });
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          12.verticalSpace,
          ...children,
        ],
      ),
    );
  }
}

class _KVRow extends StatelessWidget {
  final String label;
  final String value;
  const _KVRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
          ),
          12.horizontalSpace,
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}