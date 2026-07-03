import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../app/colors/status_colors.dart';
import '../../../../app/data/appointment_model.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../../../app/routes/app_routes.dart';
import '../../controllers/appointments_controller.dart';
import 'reject_bottom_sheet.dart';
import 'upload_result_bottom_sheet.dart';

class AppointmentCardWidget extends StatelessWidget {
  final AppointmentModel item;

  const AppointmentCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final statusColor = AppStatusColors.forStatus(item.status);
    final timeStr = DateFormat('hh:mm a').format(item.dateTime);
    final dt = DateFormat('EEE, MMM d • hh:mm a').format(item.dateTime);

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.appointmentsDetails, arguments: item),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: statusColor.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: cs.shadow.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: statusColor.withValues(alpha: 0.15),
            width: 1.2,
          ),
        ),
        child: Column(
          children: [
            // الهيدر (مدمج من القديم والجديد)
            _CardHeader(
              item: item,
              statusColor: statusColor,
              timeStr: timeStr,
              dt: dt,
            ),
            // أزرار الإجراءات حسب الحالة (من الجديد)
            if (item.status == AppointmentStatus.pending)
              _PendingActions(item: item),
            if (item.status == AppointmentStatus.approved)
              _ApprovedActions(item: item),
            if (item.status == AppointmentStatus.completed)
              _CompletedFooter(item: item, statusColor: statusColor),
            if (item.status == AppointmentStatus.rejected)
              _RejectedFooter(item: item),
          ],
        ),
      ),
    );
  }
}

// ===== الهيدر (مدمج من القديم والجديد) =====
class _CardHeader extends StatelessWidget {
  final AppointmentModel item;
  final Color statusColor;
  final String timeStr;
  final String dt;

  const _CardHeader({
    required this.item,
    required this.statusColor,
    required this.timeStr,
    required this.dt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final typeColor = AppStatusColors.forType(item.type);
    final typeIcon = _typeIcon(item.type);
    final statusLabel = _statusLabel(item.status);

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة الرمزية مع Hero (من القديم والجديد)
          Hero(
            tag: 'appointment_${item.id}',
            child: Container(
              width: 52.r,
              height: 52.r,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [statusColor.withValues(alpha: 0.8), statusColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: statusColor.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  item.patientName.isNotEmpty
                      ? item.patientName[0].toUpperCase()
                      : '?',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.patientName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    6.horizontalSpace,
                    // شارة الحالة (من القديم)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        statusLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                6.verticalSpace,
                // نوع الخدمة (من الجديد)
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: typeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(typeIcon, size: 11.sp, color: typeColor),
                          4.horizontalSpace,
                          Text(
                            item.title,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: typeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                // التاريخ والوقت (من القديم مع تصميم جديد)
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14.sp,
                      color: cs.onSurfaceVariant,
                    ),
                    4.horizontalSpace,
                    Text(
                      dt,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.patientPhone != null) ...[
                      12.horizontalSpace,
                      Icon(
                        Icons.phone_rounded,
                        size: 13.sp,
                        color: cs.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                      4.horizontalSpace,
                      Text(
                        item.patientPhone!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _typeIcon(AppointmentType type) {
    switch (type) {
      case AppointmentType.labTest:
        return Icons.science_rounded;
      case AppointmentType.consultation:
        return Icons.medical_services_rounded;
      case AppointmentType.service:
        return Icons.healing_rounded;
    }
  }

  String _statusLabel(AppointmentStatus status) {
    return tr(status.key());
  }
}

// ===== أزرار حالة قيد المراجعة (من الجديد) =====
class _PendingActions extends StatelessWidget {
  final AppointmentModel item;
  const _PendingActions({required this.item});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AppointmentsController>();

    return _ActionsDivider(
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              label: tr(LocaleKeys.appointments_actions_reject),
              icon: Icons.close_rounded,
              color: const Color(0xFFF04438),
              onTap: () => _showRejectSheet(context, item, ctrl),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: _ActionButton(
              label: tr(LocaleKeys.appointments_actions_approve),
              icon: Icons.check_rounded,
              color: const Color(0xFF16B364),
              onTap: () => ctrl.approveItem(item.id),
            ),
          ),
        ],
      ),
    );
  }

  void _showRejectSheet(
    BuildContext context,
    AppointmentModel item,
    AppointmentsController ctrl,
  ) {
    Get.bottomSheet(
      RejectBottomSheet(item: item, controller: ctrl),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

// ===== أزرار حالة مؤكد (من الجديد) =====
class _ApprovedActions extends StatelessWidget {
  final AppointmentModel item;
  const _ApprovedActions({required this.item});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AppointmentsController>();
    final isLab = item.type == AppointmentType.labTest;

    return _ActionsDivider(
      child: Row(
        children: [
          if (isLab) ...[
            Expanded(
              child: _ActionButton(
                label: tr(LocaleKeys.appointments_actions_upload_result),
                icon: Icons.upload_file_rounded,
                color: const Color(0xFF2E90FA),
                onTap: () => Get.bottomSheet(
                  UploadResultBottomSheet(item: item, controller: ctrl),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            12.horizontalSpace,
          ],
          Expanded(
            child: _ActionButton(
              label: tr(LocaleKeys.appointments_actions_complete),
              icon: Icons.task_alt_rounded,
              color: const Color(0xFF009688),
              onTap: () => ctrl.completeItem(item.id),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== تذييل حالة مكتمل (من الجديد) =====
class _CompletedFooter extends StatelessWidget {
  final AppointmentModel item;
  final Color statusColor;
  const _CompletedFooter({required this.item, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasResult = item.hasResult;

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: statusColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(
            hasResult
                ? Icons.picture_as_pdf_rounded
                : Icons.check_circle_rounded,
            size: 18.sp,
            color: statusColor,
          ),
          8.horizontalSpace,
          Text(
            hasResult
                ? tr(LocaleKeys.appointments_details_result_uploaded)
                : tr('appointments.completed.success'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 10.sp,
                  color: statusColor,
                ),
                4.horizontalSpace,
                Text(
                  tr(LocaleKeys.dashboard_view_all),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
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

// ===== تذييل حالة مرفوض (من الجديد) =====
class _RejectedFooter extends StatelessWidget {
  final AppointmentModel item;
  const _RejectedFooter({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const redColor = Color(0xFFF04438);
    final note = item.rejectNote ?? '';
    final reasonLabel = _reasonLabel(item.rejectReasonKey);

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: redColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: redColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 14.sp, color: redColor),
              6.horizontalSpace,
              Text(
                '${tr(LocaleKeys.appointments_reject_reason_label)}: $reasonLabel',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: redColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (note.isNotEmpty) ...[
            6.verticalSpace,
            Text(
              note,
              style: theme.textTheme.bodySmall?.copyWith(
                color: redColor.withValues(alpha: 0.8),
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  String _reasonLabel(String? key) {
    switch (key) {
      case 'doctor_unavailable':
        return tr('appointments.reject.reasons.doctor_unavailable');
      case 'clinic_closed':
        return tr('appointments.reject.reasons.clinic_closed');
      case 'invalid_booking':
        return tr('appointments.reject.reasons.invalid_booking');
      case 'need_more_info':
        return tr('appointments.reject.reasons.need_more_info');
      default:
        return '-';
    }
  }
}

// ===== فاصل الأزرار =====
class _ActionsDivider extends StatelessWidget {
  final Widget child;
  const _ActionsDivider({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: cs.outlineVariant.withValues(alpha: 0.3),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h),
          child: child,
        ),
      ],
    );
  }
}

// ===== زر الإجراء (من الجديد) =====
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.85), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: Colors.white),
              6.horizontalSpace,
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
