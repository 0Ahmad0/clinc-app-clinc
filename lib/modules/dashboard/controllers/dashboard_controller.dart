import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../models/dashboard_models.dart';

class DashboardController extends GetxController {
  // ─── Clinic Info ───────────────────────────────────────────────────────────
  final String clinicName    = 'عيادة الشفاء';
  final String clinicInitial = 'ع';
  final String clinicStatus  = 'العيادة مفتوحة — ٨:٠٠ ص - ٨:٠٠ م';

  // ─── Stats ─────────────────────────────────────────────────────────────────
  final List<DashboardStat> stats = const [
    DashboardStat(label: 'الأطباء',      value: '12',    icon: Icons.people_alt_rounded,       color: Color(0xFF8B5CF6), badge: '+2 هذا الشهر'),
    DashboardStat(label: 'المرضى',       value: '248',   icon: Icons.groups_rounded,            color: Color(0xFF3949AB), badge: '+18 هذا الأسبوع'),
    DashboardStat(label: 'مواعيد اليوم', value: '8',     icon: Icons.calendar_today_rounded,    color: Color(0xFF009688), badge: '5 قادمة'),
    DashboardStat(label: 'الدخل اليومي', value: '٢٥٠٠',  icon: Icons.monetization_on_rounded,  color: Color(0xFFF59E0B), badge: 'ر.س', isIncome: true),
  ];

  // ─── Quick Actions ─────────────────────────────────────────────────────────
  final List<DashboardQuickAction> quickActions = [
    DashboardQuickAction(label: 'موعد جديد', icon: Icons.add_circle_rounded,     color: Color(0xFF009688), route: AppRoutes.appointments),
    DashboardQuickAction(label: 'الأطباء',   icon: Icons.people_rounded,          color: Color(0xFF3949AB), route: AppRoutes.doctors),
    DashboardQuickAction(label: 'الخدمات',   icon: Icons.medical_services_rounded, color: Color(0xFF2563EB), route: AppRoutes.services),
    DashboardQuickAction(label: 'التقارير',  icon: Icons.analytics_rounded,       color: Color(0xFF10B981), route: AppRoutes.reports),
  ];

  // ─── Today's Appointments ──────────────────────────────────────────────────
  final List<DashboardAppointment> todayAppointments = const [
    DashboardAppointment(name: 'أحمد محمد السيد',        service: 'استشارة قلب',   time: '٩:٠٠ ص',  status: DashboardApptStatus.upcoming,  icon: Icons.monitor_heart_rounded),
    DashboardAppointment(name: 'فاطمة علي الزهراني',     service: 'تحليل دم شامل', time: '١٠:٣٠ ص', status: DashboardApptStatus.completed, icon: Icons.biotech_rounded),
    DashboardAppointment(name: 'محمد عبدالله الغامدي',   service: 'فحص عيون',      time: '١٢:٠٠ م', status: DashboardApptStatus.upcoming,  icon: Icons.visibility_rounded),
    DashboardAppointment(name: 'نورة سلمان القحطاني',    service: 'استشارة عامة',  time: '٢:٠٠ م',  status: DashboardApptStatus.cancelled, icon: Icons.healing_rounded),
    DashboardAppointment(name: 'عبدالرحمن خالد العتيبي', service: 'أشعة سينية',    time: '٤:٠٠ م',  status: DashboardApptStatus.upcoming,  icon: Icons.biotech_rounded),
  ];
}
