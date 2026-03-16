import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/colors/status_colors.dart';
import '../../../../app/extension/appointment_type_extensions.dart';

class AppointmentsEmptyState extends StatelessWidget {
  final AppointmentStatus? filter;
  const AppointmentsEmptyState({super.key, required this.filter});

  static const _messages = {
    null:                          ('لا توجد مواعيد',             'لم يتم إضافة أي موعد بعد'),
    AppointmentStatus.pending:    ('لا توجد مواعيد قيد المراجعة', 'جميع المواعيد تمت مراجعتها'),
    AppointmentStatus.approved:   ('لا توجد مواعيد مؤكدة',        'لم يتم تأكيد أي موعد بعد'),
    AppointmentStatus.completed:  ('لا توجد مواعيد مكتملة',       'لم يكتمل أي موعد بعد'),
    AppointmentStatus.rejected:   ('لا توجد مواعيد مرفوضة',       'ممتاز! لم يُرفض أي موعد'),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;
    final color = filter != null ? AppStatusColors.forStatus(filter!) : cs.primary;
    final msg   = _messages[filter] ?? ('لا توجد مواعيد', '');

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.r,
              height: 90.r,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.event_busy_outlined, size: 44.sp, color: color.withValues(alpha: 0.6)),
            ),
            20.verticalSpace,
            Text(
              msg.$1,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            Text(
              msg.$2,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
