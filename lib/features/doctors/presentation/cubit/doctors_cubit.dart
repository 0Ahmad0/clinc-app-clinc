import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/doctor_specialty.dart';
import '../../domain/doctor_summary.dart';
import 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit() : super(const DoctorsState());

  void search(String query) => emit(state.copyWith(query: query));

  void selectSpecialty(DoctorSpecialty specialty) =>
      emit(state.copyWith(specialty: specialty));

  void toggleAvailability(int id) {
    final availability = [...state.availability];
    availability[id] = !availability[id];
    emit(state.copyWith(availability: availability));
  }

  List<DoctorSummary> visibleDoctors(List<DoctorSummary> doctors) {
    final query = state.query.trim().toLowerCase();
    return doctors
        .where((doctor) {
          final specialtyMatches =
              state.specialty == DoctorSpecialty.all ||
              doctor.specialty == state.specialty;
          final queryMatches =
              query.isEmpty ||
              doctor.name.toLowerCase().contains(query) ||
              doctor.specialtyName.toLowerCase().contains(query);
          return specialtyMatches && queryMatches;
        })
        .toList(growable: false);
  }
}
