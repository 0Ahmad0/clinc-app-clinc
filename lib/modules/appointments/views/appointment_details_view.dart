import 'package:clinc_app_clinc/app/core/widgets/app_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:open_filex/open_filex.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/appointment_details_controller.dart';
import 'widgets/reject_appointment_bottom_sheet.dart';
import 'widgets/upload_pdf_bottom_sheet.dart';

class AppointmentDetailsView extends GetView<AppointmentDetailsController> {
  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      body: Obx(() {
        final a = controller.appointment.value;
        final dt = DateFormat('EEE, MMM d • hh:mm a').format(a.dateTime);
        final statusColor = _getStatusColor(context, a.status);

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Sliver App Bar with Patient Avatar
            SliverAppBar(
              pinned: true,
              expandedHeight: 260.h,
              title: Text(tr(LocaleKeys.appointments_details_title)),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [cs.primary.withOpacity(0.1), cs.surface],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'appointment_${a.id}',
                          child: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: cs.primaryContainer,
                            child: Text(
                              a.patientName.isNotEmpty
                                  ? a.patientName[0].toUpperCase()
                                  : '?',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          a.patientName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        4.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: statusColor.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            tr(a.status.key()),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 2. Appointment Details
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Patient Info Card
                  _InfoCard(
                    icon: Icons.person_outline,
                    title: tr(LocaleKeys.appointments_details_patient_info),
                    children: [
                      _KVRow(
                        icon: Icons.person,
                        label: tr(LocaleKeys.appointments_card_patient),
                        value: a.patientName,
                      ),
                      if ((a.patientPhone ?? '').isNotEmpty)
                        _KVRow(
                          icon: Icons.phone,
                          label: 'Phone',
                          value: a.patientPhone!,
                        ),
                    ],
                  ),
                  16.verticalSpace,

                  // Appointment Info Card
                  _InfoCard(
                    icon: Icons.event_note_outlined,
                    title: tr(LocaleKeys.appointments_details_appointment_info),
                    children: [
                      _KVRow(
                        icon: Icons.medical_services_outlined,
                        label: tr(LocaleKeys.appointments_card_service),
                        value: a.title,
                      ),
                      _KVRow(
                        icon: Icons.category_outlined,
                        label: tr(LocaleKeys.appointments_card_type),
                        value: tr(a.type.key()),
                      ),
                      _KVRow(
                        icon: Icons.schedule_outlined,
                        label: tr(LocaleKeys.appointments_card_time),
                        value: dt,
                      ),
                    ],
                  ),
                  16.verticalSpace,

                  // Rejection Info (if rejected)
                  if (a.status == AppointmentStatus.rejected) ...[
                    _InfoCard(
                      icon: Icons.cancel_outlined,
                      title: tr(LocaleKeys.appointments_reject_title),
                      color: cs.error.withOpacity(0.1),
                      children: [
                        _KVRow(
                          icon: Icons.info_outline,
                          label: tr(
                            LocaleKeys.appointments_reject_reason_label,
                          ),
                          value: a.rejectReasonKey ?? '-',
                        ),
                        8.verticalSpace,
                        Text(
                          a.rejectNote ?? '-',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                  ],

                  // Lab Result (if lab test)
                  if (a.type.isLab) ...[
                    _InfoCard(
                      icon: Icons.science_outlined,
                      title: tr(LocaleKeys.appointments_details_result),
                      color: cs.primary.withOpacity(0.1),
                      children: [
                        Row(
                          children: [
                            Icon(
                              a.hasResult
                                  ? Icons.check_circle_outline
                                  : Icons.error_outline,
                              color: a.hasResult ? Colors.green : cs.error,
                              size: 20.sp,
                            ),
                            8.horizontalSpace,
                            Text(
                              a.hasResult
                                  ? tr(
                                      LocaleKeys
                                          .appointments_details_result_uploaded,
                                    )
                                  : tr(
                                      LocaleKeys
                                          .appointments_details_result_missing,
                                    ),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        if (a.hasResult)
                          OutlinedButton.icon(
                            onPressed: () async {
                              await OpenFilex.open(a.resultPdfPathOrUrl!);
                            },
                            icon: Icon(Icons.picture_as_pdf, color: cs.error),
                            label: Text(
                              tr(LocaleKeys.appointments_actions_view_result),
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: cs.error,
                              ),
                            ),
                          ),
                      ],
                    ),
                    16.verticalSpace,
                  ],

                  // Notes Section
                  _InfoCard(
                    icon: Icons.notes_outlined,
                    title: tr(LocaleKeys.appointments_details_notes),
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: tr(
                            LocaleKeys.appointments_details_add_notes,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                  16.verticalSpace,

                  // Actions Section
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

  Color _getStatusColor(BuildContext context, AppointmentStatus status) {
    final cs = Theme.of(context).colorScheme;
    switch (status) {
      case AppointmentStatus.pending:
        return cs.tertiary;
      case AppointmentStatus.approved:
        return cs.primary;
      case AppointmentStatus.completed:
        return Colors.green;
      case AppointmentStatus.rejected:
        return cs.error;
    }
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

      final canApproveReject = a.status == AppointmentStatus.pending;
      final canComplete = a.status == AppointmentStatus.approved;
      final canUploadResult =
          a.type.isLab &&
          a.status == AppointmentStatus.completed &&
          !a.hasResult;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (loading)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: LinearProgressIndicator(
                color: cs.primary,
                backgroundColor: cs.surfaceVariant,
              ),
            ),

          // Approve/Reject Buttons
          if (canApproveReject) ...[
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    onPressed: loading
                        ? null
                        : () {
                            Get.bottomSheet(
                              const RejectAppointmentBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                    icon: Icons.cancel_outlined,
                    label: tr(LocaleKeys.appointments_actions_reject),
                    color: cs.error,
                    isOutlined: true,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: _ActionButton(
                    onPressed: loading ? null : controller.approve,
                    icon: Icons.check_circle_outline,
                    label: tr(LocaleKeys.appointments_actions_approve),
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            12.verticalSpace,
          ],

          // Complete Button
          if (canComplete) ...[
            _ActionButton(
              onPressed: loading ? null : controller.complete,
              icon: Icons.task_alt_outlined,
              label: tr(LocaleKeys.appointments_actions_complete),
              color: cs.primary,
            ),
            12.verticalSpace,
          ],

          // Upload Result Button
          if (canUploadResult) ...[
            _ActionButton(
              onPressed: loading
                  ? null
                  : () {
                      Get.bottomSheet(
                        const UploadPdfBottomSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
              icon: Icons.picture_as_pdf,
              label: tr(LocaleKeys.appointments_actions_upload_result),
              color: cs.secondary,
            ),
            12.verticalSpace,
          ],

          // View Result Button
          if (a.hasResult)
            _ActionButton(
              onPressed: () async {
                await OpenFilex.open(a.resultPdfPathOrUrl!);
              },
              icon: Icons.visibility_outlined,
              label: tr(LocaleKeys.appointments_actions_view_result),
              color: cs.primary,
              isOutlined: true,
            ),
        ],
      );
    });
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color color;
  final bool isOutlined;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return isOutlined
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: color),
            label: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: color.withOpacity(0.4)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          )
        : ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: cs.onPrimary),
            label: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: cs.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  final Color? color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.children,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final cardColor = color ?? cs.surface;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: cs.primary, size: 20.sp),
              8.horizontalSpace,
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          ...children,
        ],
      ),
    );
  }
}

class _KVRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _KVRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: cs.onSurfaceVariant),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                4.verticalSpace,
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
