import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:open_filex/open_filex.dart';

import '../../../app/colors/status_colors.dart';
import '../../../app/data/appointment_model.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../../../generated/locale_keys.g.dart';
import '../controllers/appointment_details_controller.dart';
import 'widgets/reject_bottom_sheet.dart';
import 'widgets/upload_result_bottom_sheet.dart';

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
        final statusColor = AppStatusColors.forStatus(a.status);
        final date = DateFormat.yMMMMd(
          context.locale.languageCode,
        ).format(a.dateTime);
        final time = DateFormat.jm(
          context.locale.languageCode,
        ).format(a.dateTime);

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // الهيدر الجديد مع Hero
            _HeroHeader(appointment: a, statusColor: statusColor),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // بطاقة المريض (مدمجة)
                  _PatientCard(appointment: a),
                  16.verticalSpace,

                  // بطاقة معلومات الموعد (مدمجة)
                  _AppointmentInfoCard(appointment: a, date: date, time: time),
                  16.verticalSpace,

                  // بطاقة الرفض (إذا كان مرفوضاً)
                  if (a.status == AppointmentStatus.rejected) ...[
                    _RejectionCard(appointment: a),
                    16.verticalSpace,
                  ],

                  // بطاقة نتيجة التحليل (إذا كان تحليل مخبري)
                  if (a.type == AppointmentType.labTest) ...[
                    _LabResultCard(appointment: a),
                    16.verticalSpace,
                  ],

                  // بطاقة الملاحظات (من الكود القديم)
                  _NotesCard(appointment: a),
                  16.verticalSpace,

                  // بطاقة الإجراءات (مدمجة)
                  _ActionsCard(),
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ===== الهيدر مع Hero (مدمج من القديم والجديد) =====
class _HeroHeader extends StatelessWidget {
  final AppointmentModel appointment;
  final Color statusColor;
  const _HeroHeader({required this.appointment, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final a = appointment;
    final statusLabel = _statusLabel(a.status);
    final typeLabel = _typeLabel(a.type);
    final typeIcon = _typeIcon(a.type);

    return SliverAppBar(
      pinned: true,
      expandedHeight: 240.h,
      backgroundColor: statusColor,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [statusColor, statusColor.withValues(alpha: 0.75)],
              ),
            ),
            child: Stack(
              children: [
                // دوائر زخرفية (من الجديد)
                Positioned(
                  top: -30,
                  right: -30,
                  child: Container(
                    width: 160.r,
                    height: 160.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: Container(
                    width: 120.r,
                    height: 120.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        60.verticalSpace,
                        Hero(
                          tag: 'appointment_${a.id}',
                          child: Container(
                            width: 72.r,
                            height: 72.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.25),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                a.patientName.isNotEmpty
                                    ? a.patientName[0].toUpperCase()
                                    : '?',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          a.patientName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // نوع الموعد (من الجديد)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    typeIcon,
                                    size: 13.sp,
                                    color: Colors.white,
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    typeLabel,
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            8.horizontalSpace,
                            // حالة الموعد (من القديم)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                statusLabel,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusLabel(AppointmentStatus status) {
    return tr(status.key());
  }

  String _typeLabel(AppointmentType type) {
    return tr(type.key());
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
}

// ===== بطاقة المريض (جديد) =====
class _PatientCard extends StatelessWidget {
  final AppointmentModel appointment;
  const _PatientCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final a = appointment;

    return _DetailCard(
      icon: Icons.person_rounded,
      title: tr(LocaleKeys.appointments_details_patient_info),
      iconColor: const Color(0xFF009688),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.badge_rounded,
            label: tr(LocaleKeys.appointments_card_patient),
            value: a.patientName,
          ),
          if ((a.patientPhone ?? '').isNotEmpty)
            _InfoRow(
              icon: Icons.phone_rounded,
              label: 'Phone',
              value: a.patientPhone!,
              valueColor: const Color(0xFF009688),
            ),
        ],
      ),
    );
  }
}

// ===== بطاقة معلومات الموعد (مدمج من القديم والجديد) =====
class _AppointmentInfoCard extends StatelessWidget {
  final AppointmentModel appointment;
  final String date;
  final String time;
  const _AppointmentInfoCard({
    required this.appointment,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final a = appointment;

    return _DetailCard(
      icon: Icons.event_note_rounded,
      title: tr(LocaleKeys.appointments_details_appointment_info),
      iconColor: const Color(0xFF6366F1),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.medical_services_rounded,
            label: tr(LocaleKeys.appointments_card_service),
            value: a.title,
          ),
          _InfoRow(
            icon: Icons.category_outlined,
            label: tr(LocaleKeys.appointments_card_type),
            value: tr(a.type.key()),
          ),
          if ((a.specialization ?? '').isNotEmpty)
            _InfoRow(
              icon: Icons.medical_information_outlined,
              label: tr('appointments.card.specialization'),
              value: a.specialization!,
            ),
          _InfoRow(
            icon: Icons.calendar_today_rounded,
            label: tr('appointments.card.date'),
            value: date,
          ),
          _InfoRow(
            icon: Icons.access_time_rounded,
            label: tr(LocaleKeys.appointments_card_time),
            value: time,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

// ===== بطاقة الرفض (من الجديد) =====
class _RejectionCard extends StatelessWidget {
  final AppointmentModel appointment;
  const _RejectionCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const redColor = Color(0xFFF04438);
    final a = appointment;
    final reasonLabel = _reasonLabel(a.rejectReasonKey);

    return _DetailCard(
      icon: Icons.cancel_rounded,
      title: tr(LocaleKeys.appointments_reject_title),
      iconColor: redColor,
      backgroundColor: redColor.withValues(alpha: 0.04),
      borderColor: redColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            icon: Icons.label_important_rounded,
            label: tr(LocaleKeys.appointments_reject_reason_label),
            value: reasonLabel,
            valueColor: redColor,
            isLast: (a.rejectNote ?? '').isEmpty,
          ),
          if ((a.rejectNote ?? '').isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: redColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  a.rejectNote!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: redColor.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
              ),
            ),
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

// ===== بطاقة نتيجة التحليل (مدمج من القديم والجديد) =====
class _LabResultCard extends StatelessWidget {
  final AppointmentModel appointment;
  const _LabResultCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const blueColor = Color(0xFF2E90FA);
    final a = appointment;
    final hasResult = a.hasResult as bool;

    return _DetailCard(
      icon: Icons.science_rounded,
      title: tr(LocaleKeys.appointments_details_result),
      iconColor: blueColor,
      backgroundColor: blueColor.withValues(alpha: 0.04),
      borderColor: blueColor.withValues(alpha: 0.2),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color:
                      (hasResult
                              ? const Color(0xFF16B364)
                              : const Color(0xFFF59E0B))
                          .withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  hasResult
                      ? Icons.check_circle_rounded
                      : Icons.hourglass_empty_rounded,
                  color: hasResult
                      ? const Color(0xFF16B364)
                      : const Color(0xFFF59E0B),
                  size: 22.sp,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasResult
                          ? tr(LocaleKeys.appointments_details_result_uploaded)
                          : tr(LocaleKeys.appointments_details_result_missing),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: hasResult
                            ? const Color(0xFF16B364)
                            : const Color(0xFFF59E0B),
                      ),
                    ),
                    if (hasResult)
                      Text(
                        tr('appointments.result.click_to_view'),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: blueColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (hasResult)
                GestureDetector(
                  onTap: () async {
                    await OpenFilex.open(a.resultPdfPathOrUrl!);
                  },
                  child: Icon(
                    Icons.picture_as_pdf_rounded,
                    color: const Color(0xFFF04438),
                    size: 28.sp,
                  ),
                ),
            ],
          ),
          if (hasResult) ...[
            12.verticalSpace,
            OutlinedButton.icon(
              onPressed: () async {
                await OpenFilex.open(a.resultPdfPathOrUrl!);
              },
              icon: Icon(Icons.visibility_outlined, color: blueColor),
              label: Text(
                tr(LocaleKeys.appointments_actions_view_result),
                style: TextStyle(color: blueColor),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: blueColor.withValues(alpha: 0.4)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ===== بطاقة الملاحظات (من الكود القديم) =====
class _NotesCard extends StatelessWidget {
  final AppointmentModel appointment;
  const _NotesCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const greenColor = Color(0xFF009688);

    return _DetailCard(
      icon: Icons.notes_rounded,
      title: tr(LocaleKeys.appointments_details_notes),
      iconColor: greenColor,
      child: TextField(
        decoration: InputDecoration(
          hintText: tr(LocaleKeys.appointments_details_add_notes),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          ),
        ),
        maxLines: 3,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}

// ===== بطاقة الإجراءات (مدمج من القديم والجديد) =====
class _ActionsCard extends GetView<AppointmentDetailsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final a = controller.appointment.value;
      final loading = controller.isLoading.value;

      // إذا كان مكتملاً أو مرفوضاً، لا نعرض الأزرار
      if (a.status == AppointmentStatus.completed ||
          a.status == AppointmentStatus.rejected) {
        return const SizedBox.shrink();
      }

      return _DetailCard(
        icon: Icons.touch_app_rounded,
        title: tr(LocaleKeys.appointments_details_actions),
        iconColor: const Color(0xFF009688),
        child: Column(
          children: [
            if (loading)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: LinearProgressIndicator(
                  color: const Color(0xFF009688),
                  backgroundColor: const Color(
                    0xFF009688,
                  ).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            // حالة قيد المراجعة (من القديم)
            if (a.status == AppointmentStatus.pending) ...[
              Row(
                children: [
                  Expanded(
                    child: _GradientButton(
                      label: tr(LocaleKeys.appointments_actions_reject),
                      icon: Icons.close_rounded,
                      color: const Color(0xFFF04438),
                      outlined: true,
                      onTap: loading
                          ? null
                          : () => Get.bottomSheet(
                              RejectBottomSheet(
                                item: a,
                                controller: controller.listController,
                              ),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: _GradientButton(
                      label: tr(LocaleKeys.appointments_actions_approve),
                      icon: Icons.check_rounded,
                      color: const Color(0xFF16B364),
                      onTap: loading ? null : controller.approve,
                    ),
                  ),
                ],
              ),
            ],
            // حالة مؤكد (من الجديد)
            if (a.status == AppointmentStatus.approved) ...[
              // زر رفع النتيجة (إذا كان تحليل مخبري)
              if (a.type == AppointmentType.labTest && !a.hasResult)
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: _GradientButton(
                    label: tr(LocaleKeys.appointments_actions_upload_result),
                    icon: Icons.upload_file_rounded,
                    color: const Color(0xFF2E90FA),
                    onTap: loading
                        ? null
                        : () => Get.bottomSheet(
                            UploadResultBottomSheet(
                              item: a,
                              controller: controller.listController,
                            ),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          ),
                  ),
                ),
              // زر إكمال الموعد
              _GradientButton(
                label: tr(LocaleKeys.appointments_actions_complete),
                icon: Icons.task_alt_rounded,
                color: const Color(0xFF009688),
                onTap: loading ? null : controller.complete,
              ),
            ],
          ],
        ),
      );
    });
  }
}

// ===== زر متدرج (من الجديد) =====
class _GradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool outlined;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (outlined) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: color.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18.sp, color: color),
                8.horizontalSpace,
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 13.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.85), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: Colors.white),
              8.horizontalSpace,
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

// ===== بطاقة التفاصيل (من الجديد) =====
class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.child,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? cs.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: borderColor ?? cs.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: iconColor, size: 18.sp),
              ),
              10.horizontalSpace,
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          child,
        ],
      ),
    );
  }
}

// ===== صف معلومات (من الجديد) =====
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14.h),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 15.sp, color: cs.onSurfaceVariant),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                ),
                3.verticalSpace,
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? cs.onSurface,
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
