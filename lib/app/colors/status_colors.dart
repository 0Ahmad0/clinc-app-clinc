import 'package:flutter/material.dart';
import '../extension/appointment_type_extensions.dart';

class AppStatusColors {
  static Color forStatus(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return const Color(0xFFF59E0B);
      case AppointmentStatus.approved:
        return const Color(0xFF009688);
      case AppointmentStatus.completed:
        return const Color(0xFF16B364);
      case AppointmentStatus.rejected:
        return const Color(0xFFF04438);
    }
  }

  static Color forType(AppointmentType type) {
    switch (type) {
      case AppointmentType.labTest:
        return const Color(0xFF6366F1);
      case AppointmentType.consultation:
        return const Color(0xFF009688);
      case AppointmentType.service:
        return const Color(0xFF2E90FA);
    }
  }
}
