import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../app/colors/status_colors.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../controllers/appointment_details_controller.dart';
import 'widgets/reject_bottom_sheet.dart';
import 'widgets/upload_result_bottom_sheet.dart';

class AppointmentDetailsView extends GetView<AppointmentDetailsController> {
  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() {
        final a = controller.appointment.value;
        final statusColor = AppStatusColors.forStatus(a.status);
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _HeroHeader(appointment: a, statusColor: statusColor),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _PatientCard(appointment: a),
                  16.verticalSpace,
                  _AppointmentInfoCard(appointment: a),
                  16.verticalSpace,
                  if (a.status == AppointmentStatus.rejected) ...[
                    _RejectionCard(appointment: a),
                    16.verticalSpace,
                  ],
                  if (a.type == AppointmentType.labTest) ...[
                    _LabResultCard(appointment: a),
                    16.verticalSpace,
                  ],
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

class _HeroHeader extends StatelessWidget {
  final dynamic appointment;
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 18),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                statusColor,
                statusColor.withValues(alpha: 0.75),
              ],
            ),
          ),
          child: Stack(
            children: [
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
                        tag: 'appt_avatar_${a.id}',
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
                                  ? a.patientName[0]
                                  : '؟',
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
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(typeIcon,
                                    size: 13.sp, color: Colors.white),
                                5.horizontalSpace,
                                Text(
                                  typeLabel,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          8.horizontalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              statusLabel,
                              style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
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
    );
  }

  String _statusLabel(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return 'قيد المراجعة';
      case AppointmentStatus.approved:
        return 'مؤكد';
      case AppointmentStatus.completed:
        return 'مكتمل';
      case AppointmentStatus.rejected:
        return 'مرفوض';
    }
  }

  String _typeLabel(AppointmentType type) {
    switch (type) {
      case AppointmentType.labTest:
        return 'تحليل مخبري';
      case AppointmentType.consultation:
        return 'استشارة';
      case AppointmentType.service:
        return 'خدمة طبية';
    }
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

class _PatientCard extends StatelessWidget {
  final dynamic appointment;
  const _PatientCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final a = appointment;

    return _DetailCard(
      icon: Icons.person_rounded,
      title: 'معلومات المريض',
      iconColor: const Color(0xFF009688),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.badge_rounded,
            label: 'الاسم',
            value: a.patientName,
          ),
          if ((a.patientPhone ?? '').isNotEmpty)
            _InfoRow(
              icon: Icons.phone_rounded,
              label: 'الهاتف',
              value: a.patientPhone!,
              valueColor: const Color(0xFF009688),
            ),
        ],
      ),
    );
  }
}

class _AppointmentInfoCard extends StatelessWidget {
  final dynamic appointment;
  const _AppointmentInfoCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final a = appointment;
    final dateStr = DateFormat('EEEE، d MMMM yyyy', 'ar').format(a.dateTime);
    final timeStr = DateFormat('hh:mm a').format(a.dateTime);

    return _DetailCard(
      icon: Icons.event_note_rounded,
      title: 'تفاصيل الموعد',
      iconColor: const Color(0xFF6366F1),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.medical_services_rounded,
            label: 'الخدمة',
            value: a.title,
          ),
          _InfoRow(
            icon: Icons.calendar_today_rounded,
            label: 'التاريخ',
            value: dateStr,
          ),
          _InfoRow(
            icon: Icons.access_time_rounded,
            label: 'الوقت',
            value: timeStr,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _RejectionCard extends StatelessWidget {
  final dynamic appointment;
  const _RejectionCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const redColor = Color(0xFFF04438);
    final a = appointment;
    final reasonLabel = _reasonLabel(a.rejectReasonKey);

    return _DetailCard(
      icon: Icons.cancel_rounded,
      title: 'سبب الرفض',
      iconColor: redColor,
      backgroundColor: redColor.withValues(alpha: 0.04),
      borderColor: redColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            icon: Icons.label_important_rounded,
            label: 'السبب',
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
        return 'الطبيب غير متاح';
      case 'clinic_closed':
        return 'العيادة مغلقة';
      case 'invalid_booking':
        return 'حجز غير صحيح';
      case 'need_more_info':
        return 'تحتاج معلومات إضافية';
      default:
        return 'أخرى';
    }
  }
}

class _LabResultCard extends StatelessWidget {
  final dynamic appointment;
  const _LabResultCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const blueColor = Color(0xFF2E90FA);
    final a = appointment;
    final hasResult = a.hasResult as bool;

    return _DetailCard(
      icon: Icons.science_rounded,
      title: 'نتيجة التحليل',
      iconColor: blueColor,
      backgroundColor: blueColor.withValues(alpha: 0.04),
      borderColor: blueColor.withValues(alpha: 0.2),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: (hasResult
                      ? const Color(0xFF16B364)
                      : const Color(0xFFF59E0B))
                  .withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasResult
                  ? Icons.check_circle_rounded
                  : Icons.hourglass_empty_rounded,
              color:
                  hasResult ? const Color(0xFF16B364) : const Color(0xFFF59E0B),
              size: 22.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasResult ? 'تم رفع النتيجة' : 'لم يتم رفع النتيجة بعد',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: hasResult
                        ? const Color(0xFF16B364)
                        : const Color(0xFFF59E0B),
                  ),
                ),
                if (hasResult)
                  Text(
                    'اضغط لفتح الملف',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: blueColor,
                    ),
                  ),
              ],
            ),
          ),
          if (hasResult)
            Icon(Icons.picture_as_pdf_rounded,
                color: const Color(0xFFF04438), size: 28.sp),
        ],
      ),
    );
  }
}

class _ActionsCard extends GetView<AppointmentDetailsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final a = controller.appointment.value;
      final loading = controller.isLoading.value;
      final listCtrl = controller.listController;

      if (a.status == AppointmentStatus.completed ||
          a.status == AppointmentStatus.rejected) {
        return const SizedBox.shrink();
      }

      return _DetailCard(
        icon: Icons.touch_app_rounded,
        title: 'الإجراءات',
        iconColor: const Color(0xFF009688),
        child: Column(
          children: [
            if (loading)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: LinearProgressIndicator(
                  color: const Color(0xFF009688),
                  backgroundColor:
                      const Color(0xFF009688).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            if (a.status == AppointmentStatus.pending) ...[
              Row(
                children: [
                  Expanded(
                    child: _GradientButton(
                      label: 'رفض',
                      icon: Icons.close_rounded,
                      color: const Color(0xFFF04438),
                      outlined: true,
                      onTap: loading
                          ? null
                          : () => Get.bottomSheet(
                                RejectBottomSheet(
                                    item: a, controller: listCtrl),
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                              ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: _GradientButton(
                      label: 'قبول',
                      icon: Icons.check_rounded,
                      color: const Color(0xFF16B364),
                      onTap: loading ? null : controller.approve,
                    ),
                  ),
                ],
              ),
            ],
            if (a.status == AppointmentStatus.approved) ...[
              if (a.type == AppointmentType.labTest)
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: _GradientButton(
                    label: 'رفع نتيجة التحليل',
                    icon: Icons.upload_file_rounded,
                    color: const Color(0xFF2E90FA),
                    onTap: loading
                        ? null
                        : () => Get.bottomSheet(
                              UploadResultBottomSheet(
                                  item: a, controller: listCtrl),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            ),
                  ),
                ),
              _GradientButton(
                label: 'إكمال الموعد',
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
              border:
                  Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
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
