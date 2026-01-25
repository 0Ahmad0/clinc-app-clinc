enum AppointmentStatus { pending, approved, rejected, completed }
enum AppointmentType { consultation, service, labTest }

extension AppointmentTypeX on AppointmentType {
  bool get isLab => this == AppointmentType.labTest;
}

extension AppointmentStatusX on AppointmentStatus {
  String key() {
    switch (this) {
      case AppointmentStatus.pending:
        return 'appointments.status.pending';
      case AppointmentStatus.approved:
        return 'appointments.status.approved';
      case AppointmentStatus.completed:
        return 'appointments.status.completed';
      case AppointmentStatus.rejected:
        return 'appointments.status.rejected';
    }
  }
}

extension AppointmentTypeKeyX on AppointmentType {
  String key() {
    switch (this) {
      case AppointmentType.consultation:
        return 'appointments.type.consultation';
      case AppointmentType.service:
        return 'appointments.type.service';
      case AppointmentType.labTest:
        return 'appointments.type.lab_test';
    }
  }
}