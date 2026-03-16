import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/core/widgets/app_detail_card.dart';
import '../../../../app/core/widgets/app_info_row.dart';
import '../../../../app/data/appointment_model.dart';

class AppointmentInfoCard extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentInfoCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final a       = appointment;
    final dateStr = DateFormat('EEEE، d MMMM yyyy', 'ar').format(a.dateTime);
    final timeStr = DateFormat('hh:mm a').format(a.dateTime);

    return AppDetailCard(
      icon: Icons.event_note_rounded,
      title: 'تفاصيل الموعد',
      iconColor: const Color(0xFF6366F1),
      child: Column(
        children: [
          AppInfoRow(icon: Icons.medical_services_rounded, label: 'الخدمة', value: a.title),
          AppInfoRow(icon: Icons.calendar_today_rounded,   label: 'التاريخ', value: dateStr),
          AppInfoRow(icon: Icons.access_time_rounded,      label: 'الوقت',   value: timeStr, isLast: true),
        ],
      ),
    );
  }
}
