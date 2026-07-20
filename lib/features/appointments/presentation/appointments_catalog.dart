import '../../../l10n/app_localizations.dart';
import '../domain/appointment.dart';
import '../domain/appointment_kind.dart';
import '../domain/appointment_status.dart';

/// Sample appointments. Names and services come from l10n; phone/time are data.
List<Appointment> localizedAppointments(AppLocalizations l10n) => [
  Appointment(
    id: 1,
    name: l10n.appt1Name,
    service: l10n.appt1Service,
    kind: AppointmentKind.lab,
    time: '11:41 AM',
    phone: '+963911000111',
    status: AppointmentStatus.pending,
  ),
  Appointment(
    id: 2,
    name: l10n.appt2Name,
    service: l10n.appt2Service,
    kind: AppointmentKind.clinic,
    time: '01:41 PM',
    phone: '+963922000222',
    status: AppointmentStatus.pending,
  ),
  Appointment(
    id: 3,
    name: l10n.appt3Name,
    service: l10n.appt3Service,
    kind: AppointmentKind.ray,
    time: '03:41 PM',
    phone: '+963933000333',
    status: AppointmentStatus.pending,
  ),
  Appointment(
    id: 4,
    name: l10n.appt4Name,
    service: l10n.appt4Service,
    kind: AppointmentKind.clinic,
    time: '09:00 AM',
    phone: '+966501234567',
    status: AppointmentStatus.confirmed,
  ),
  Appointment(
    id: 5,
    name: l10n.appt5Name,
    service: l10n.appt5Service,
    kind: AppointmentKind.lab,
    time: '10:30 AM',
    phone: '+966559876543',
    status: AppointmentStatus.confirmed,
  ),
  Appointment(
    id: 6,
    name: l10n.appt6Name,
    service: l10n.appt6Service,
    kind: AppointmentKind.clinic,
    time: '08:15 AM',
    phone: '+966533221100',
    status: AppointmentStatus.done,
  ),
  Appointment(
    id: 7,
    name: l10n.appt7Name,
    service: l10n.appt7Service,
    kind: AppointmentKind.lab,
    time: '07:45 AM',
    phone: '+966544332211',
    status: AppointmentStatus.done,
  ),
  Appointment(
    id: 8,
    name: l10n.appt8Name,
    service: l10n.appt8Service,
    kind: AppointmentKind.clinic,
    time: '05:00 PM',
    phone: '+966566778899',
    status: AppointmentStatus.rejected,
  ),
  Appointment(
    id: 9,
    name: l10n.appt9Name,
    service: l10n.appt9Service,
    kind: AppointmentKind.ray,
    time: '06:30 PM',
    phone: '+966577665544',
    status: AppointmentStatus.rejected,
  ),
];
