import 'package:equatable/equatable.dart';

import '../../domain/doctor_specialty.dart';

class DoctorsState extends Equatable {
  const DoctorsState({
    this.query = '',
    this.specialty = DoctorSpecialty.all,
    this.availability = const [true, true, true, true, false],
  });

  final String query;
  final DoctorSpecialty specialty;
  final List<bool> availability;

  int get availableCount => availability.where((value) => value).length;

  DoctorsState copyWith({
    String? query,
    DoctorSpecialty? specialty,
    List<bool>? availability,
  }) => DoctorsState(
    query: query ?? this.query,
    specialty: specialty ?? this.specialty,
    availability: availability ?? this.availability,
  );

  @override
  List<Object> get props => [query, specialty, availability];
}
