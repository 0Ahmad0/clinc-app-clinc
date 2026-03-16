import 'package:flutter/material.dart';
import '../../../../app/extension/appointment_type_extensions.dart';

/// Centralised string/icon helpers for appointment-related widgets.
/// Eliminates duplicated switch-statements across list, card and detail files.
class AppointmentHelper {
  AppointmentHelper._();

  static String statusLabel(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:   return 'قيد المراجعة';
      case AppointmentStatus.approved:  return 'مؤكد';
      case AppointmentStatus.completed: return 'مكتمل';
      case AppointmentStatus.rejected:  return 'مرفوض';
    }
  }

  static String typeLabel(AppointmentType type) {
    switch (type) {
      case AppointmentType.labTest:      return 'تحليل مخبري';
      case AppointmentType.consultation: return 'استشارة';
      case AppointmentType.service:      return 'خدمة طبية';
    }
  }

  static IconData typeIcon(AppointmentType type) {
    switch (type) {
      case AppointmentType.labTest:      return Icons.science_rounded;
      case AppointmentType.consultation: return Icons.medical_services_rounded;
      case AppointmentType.service:      return Icons.healing_rounded;
    }
  }

  static String rejectReasonLabel(String? key) {
    switch (key) {
      case 'doctor_unavailable': return 'الطبيب غير متاح';
      case 'clinic_closed':      return 'العيادة مغلقة';
      case 'invalid_booking':    return 'حجز غير صحيح';
      case 'need_more_info':     return 'تحتاج معلومات إضافية';
      default:                   return 'أخرى';
    }
  }
}
