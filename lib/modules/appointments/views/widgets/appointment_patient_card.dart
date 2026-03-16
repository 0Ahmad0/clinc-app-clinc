import 'package:flutter/material.dart';
import '../../../../app/core/widgets/app_detail_card.dart';
import '../../../../app/core/widgets/app_info_row.dart';
import '../../../../app/data/appointment_model.dart';

class AppointmentPatientCard extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentPatientCard({super.key, required this.appointment});

  static const _teal = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    final a = appointment;

    return AppDetailCard(
      icon: Icons.person_rounded,
      title: 'معلومات المريض',
      iconColor: _teal,
      child: Column(
        children: [
          AppInfoRow(icon: Icons.badge_rounded, label: 'الاسم', value: a.patientName),
          if ((a.patientPhone ?? '').isNotEmpty)
            AppInfoRow(
              icon: Icons.phone_rounded,
              label: 'الهاتف',
              value: a.patientPhone!,
              valueColor: _teal,
              isLast: true,
            ),
        ],
      ),
    );
  }
}
