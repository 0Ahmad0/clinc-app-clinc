import 'package:flutter/material.dart';

// ─── Stat Card ────────────────────────────────────────────────────────────────

class DashboardStat {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String badge;
  final bool isIncome;

  const DashboardStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.badge,
    this.isIncome = false,
  });
}

// ─── Quick Action ─────────────────────────────────────────────────────────────

class DashboardQuickAction {
  final String label;
  final IconData icon;
  final Color color;
  final String route;

  const DashboardQuickAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.route,
  });
}

// ─── Appointment Preview ──────────────────────────────────────────────────────

enum DashboardApptStatus { upcoming, completed, cancelled }

class DashboardAppointment {
  final String name;
  final String service;
  final String time;
  final DashboardApptStatus status;
  final IconData icon;

  const DashboardAppointment({
    required this.name,
    required this.service,
    required this.time,
    required this.status,
    required this.icon,
  });
}
