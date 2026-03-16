import 'package:flutter/material.dart';
import '../../../../app/data/report_model.dart';

/// View-only extension — keeps color + icon logic DRY across all report widgets.
extension ReportTypeViewX on ReportType {
  Color typeColor(ColorScheme cs) {
    switch (this) {
      case ReportType.appointments: return cs.primary;
      case ReportType.labResults:   return const Color(0xFF6366F1);
      case ReportType.revenue:      return const Color(0xFF10B981);
      case ReportType.doctors:      return const Color(0xFFF59E0B);
    }
  }

  IconData get typeIcon {
    switch (this) {
      case ReportType.appointments: return Icons.calendar_month_rounded;
      case ReportType.labResults:   return Icons.biotech_rounded;
      case ReportType.revenue:      return Icons.trending_up_rounded;
      case ReportType.doctors:      return Icons.medical_services_rounded;
    }
  }
}
