import 'package:equatable/equatable.dart';

import 'appointment_kind.dart';
import 'appointment_status.dart';

/// One appointment. Display strings are already localized by the catalog; the
/// live status and rejection reason are tracked in the cubit so the list can be
/// rebuilt from l10n on locale change.
class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.name,
    required this.service,
    required this.kind,
    required this.time,
    required this.phone,
    required this.status,
  });

  final int id;
  final String name;
  final String service;
  final AppointmentKind kind;
  final String time;
  final String phone;
  final AppointmentStatus status;

  /// First letter of the name, for the avatar.
  String get initial => name.substring(0, 1);

  @override
  List<Object?> get props => [id, name, service, kind, time, phone, status];
}
