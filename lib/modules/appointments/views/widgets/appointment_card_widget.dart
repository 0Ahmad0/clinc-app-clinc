import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/colors/status_colors.dart';
import '../../../../app/core/widgets/app_gradient_button.dart';
import '../../../../app/data/appointment_model.dart';
import '../../../../app/extension/appointment_type_extensions.dart';
import '../../../../app/routes/app_routes.dart';
import '../../controllers/appointments_controller.dart';
import 'appointment_helpers.dart';
import 'reject_bottom_sheet.dart';
import 'upload_result_bottom_sheet.dart';

class AppointmentCardWidget extends StatelessWidget {
  final AppointmentModel item;
  const AppointmentCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cs          = Theme.of(context).colorScheme;
    final statusColor = AppStatusColors.forStatus(item.status);
    final timeStr     = DateFormat('hh:mm a').format(item.dateTime);

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.appointmentsDetails, arguments: item),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(color: statusColor.withValues(alpha: 0.08), blurRadius: 20, offset: const Offset(0, 6)),
            BoxShadow(color: cs.shadow.withValues(alpha: 0.04),   blurRadius: 8,  offset: const Offset(0, 2)),
          ],
          border: Border.all(color: statusColor.withValues(alpha: 0.15), width: 1.2),
        ),
        child: Column(
          children: [
            _CardHeader(item: item, statusColor: statusColor, timeStr: timeStr),
            if (item.status == AppointmentStatus.pending)  _PendingActions(item: item),
            if (item.status == AppointmentStatus.approved) _ApprovedActions(item: item),
            if (item.status == AppointmentStatus.completed) _CompletedFooter(item: item, statusColor: statusColor),
            if (item.status == AppointmentStatus.rejected)  _RejectedFooter(item: item),
          ],
        ),
      ),
    );
  }
}

// ─── Card Header ──────────────────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  final AppointmentModel item;
  final Color statusColor;
  final String timeStr;
  const _CardHeader({required this.item, required this.statusColor, required this.timeStr});

  @override
  Widget build(BuildContext context) {
    final theme      = Theme.of(context);
    final cs         = theme.colorScheme;
    final typeColor  = AppStatusColors.forType(item.type);
    final typeIcon   = AppointmentHelper.typeIcon(item.type);
    final statusLabel = AppointmentHelper.statusLabel(item.status);

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PatientAvatar(item: item, statusColor: statusColor),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                    child: Text(
                      item.patientName,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.2),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  6.horizontalSpace,
                  _StatusBadge(label: statusLabel, color: statusColor, theme: theme),
                ]),
                6.verticalSpace,
                _TypeBadge(icon: typeIcon, title: item.title, color: typeColor, theme: theme),
                8.verticalSpace,
                _TimeRow(timeStr: timeStr, phone: item.patientPhone, theme: theme, cs: cs),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientAvatar extends StatelessWidget {
  final AppointmentModel item;
  final Color statusColor;
  const _PatientAvatar({required this.item, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'appt_avatar_${item.id}',
      child: Container(
        width: 52.r, height: 52.r,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [statusColor.withValues(alpha: 0.8), statusColor],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: statusColor.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Center(
          child: Text(
            item.patientName.isNotEmpty ? item.patientName[0] : '؟',
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final ThemeData theme;
  const _StatusBadge({required this.label, required this.color, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700, fontSize: 10.sp),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final ThemeData theme;
  const _TypeBadge({required this.icon, required this.title, required this.color, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11.sp, color: color),
          4.horizontalSpace,
          Text(title, style: theme.textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w600, fontSize: 11.sp)),
        ],
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String timeStr;
  final String? phone;
  final ThemeData theme;
  final ColorScheme cs;
  const _TimeRow({required this.timeStr, required this.phone, required this.theme, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.access_time_rounded, size: 14.sp, color: cs.onSurfaceVariant),
        4.horizontalSpace,
        Text(timeStr, style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w500)),
        if (phone != null) ...[
          12.horizontalSpace,
          Icon(Icons.phone_rounded, size: 13.sp, color: cs.onSurfaceVariant.withValues(alpha: 0.6)),
          4.horizontalSpace,
          Text(phone!, style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.7), fontSize: 10.sp)),
        ],
      ],
    );
  }
}

// ─── Action Sections ──────────────────────────────────────────────────────────

class _PendingActions extends StatelessWidget {
  final AppointmentModel item;
  const _PendingActions({required this.item});

  static const _red   = Color(0xFFF04438);
  static const _green = Color(0xFF16B364);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AppointmentsController>();
    return _ActionsDivider(
      child: Row(
        children: [
          Expanded(
            child: AppOutlineGradientButton(
              label: 'رفض',
              borderColor: _red,
              textColor: _red,
              prefixIcon: Icon(Icons.close_rounded, color: _red, size: 18.sp),
              height: 42,
              onTap: () => Get.bottomSheet(
                RejectBottomSheet(item: item, controller: ctrl),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: AppGradientButton(
              label: 'قبول',
              gradient: LinearGradient(colors: [_green.withValues(alpha: 0.85), _green]),
              shadowColor: _green.withValues(alpha: 0.3),
              prefixIcon: Icon(Icons.check_rounded, color: Colors.white, size: 18.sp),
              height: 42,
              onTap: () => ctrl.approveItem(item.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApprovedActions extends StatelessWidget {
  final AppointmentModel item;
  const _ApprovedActions({required this.item});

  static const _teal = Color(0xFF009688);
  static const _blue = Color(0xFF2E90FA);

  @override
  Widget build(BuildContext context) {
    final ctrl  = Get.find<AppointmentsController>();
    final isLab = item.type == AppointmentType.labTest;

    return _ActionsDivider(
      child: Row(
        children: [
          if (isLab) ...[
            Expanded(
              child: AppGradientButton(
                label: 'رفع النتيجة',
                gradient: LinearGradient(colors: [_blue.withValues(alpha: 0.85), _blue]),
                shadowColor: _blue.withValues(alpha: 0.3),
                prefixIcon: Icon(Icons.upload_file_rounded, color: Colors.white, size: 18.sp),
                height: 42,
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
            child: AppGradientButton(
              label: 'إكمال',
              gradient: LinearGradient(colors: [_teal.withValues(alpha: 0.85), _teal]),
              shadowColor: _teal.withValues(alpha: 0.3),
              prefixIcon: Icon(Icons.task_alt_rounded, color: Colors.white, size: 18.sp),
              height: 42,
              onTap: () => ctrl.completeItem(item.id),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Status Footers ───────────────────────────────────────────────────────────

class _CompletedFooter extends StatelessWidget {
  final AppointmentModel item;
  final Color statusColor;
  const _CompletedFooter({required this.item, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    final theme     = Theme.of(context);
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
          Icon(hasResult ? Icons.picture_as_pdf_rounded : Icons.check_circle_rounded, size: 18.sp, color: statusColor),
          8.horizontalSpace,
          Text(
            hasResult ? 'تم رفع النتيجة' : 'اكتمل الموعد بنجاح',
            style: theme.textTheme.bodySmall?.copyWith(color: statusColor, fontWeight: FontWeight.w700),
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
                Icon(Icons.arrow_forward_ios_rounded, size: 10.sp, color: statusColor),
                4.horizontalSpace,
                Text('عرض التفاصيل', style: theme.textTheme.labelSmall?.copyWith(color: statusColor, fontWeight: FontWeight.w600, fontSize: 10.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RejectedFooter extends StatelessWidget {
  final AppointmentModel item;
  const _RejectedFooter({required this.item});

  static const _red = Color(0xFFF04438);

  @override
  Widget build(BuildContext context) {
    final theme       = Theme.of(context);
    final note        = item.rejectNote ?? '';
    final reasonLabel = AppointmentHelper.rejectReasonLabel(item.rejectReasonKey);

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: _red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _red.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.info_outline_rounded, size: 14.sp, color: _red),
            6.horizontalSpace,
            Text('سبب الرفض: $reasonLabel', style: theme.textTheme.labelSmall?.copyWith(color: _red, fontWeight: FontWeight.w700)),
          ]),
          if (note.isNotEmpty) ...[
            6.verticalSpace,
            Text(note, style: theme.textTheme.bodySmall?.copyWith(color: _red.withValues(alpha: 0.8), height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ],
      ),
    );
  }
}

// ─── Shared Divider Wrapper ───────────────────────────────────────────────────

class _ActionsDivider extends StatelessWidget {
  final Widget child;
  const _ActionsDivider({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Divider(height: 1, thickness: 1, color: cs.outlineVariant.withValues(alpha: 0.3)),
        Padding(padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h), child: child),
      ],
    );
  }
}
