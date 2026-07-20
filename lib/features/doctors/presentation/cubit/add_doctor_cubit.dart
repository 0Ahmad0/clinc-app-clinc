import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/doctor_specialty.dart';
import '../../domain/weekday.dart';
import 'add_doctor_state.dart';

/// Drives the add-doctor form: the specialty picker and the weekly schedule.
/// No persistence yet — the save action is wired once the endpoint exists.
class AddDoctorCubit extends Cubit<AddDoctorState> {
  AddDoctorCubit() : super(const AddDoctorState());

  void toggleSpecialtyPicker() =>
      emit(state.copyWith(specialtyOpen: !state.specialtyOpen));

  void selectSpecialty(DoctorSpecialty specialty) =>
      emit(state.copyWith(specialty: specialty, specialtyOpen: false));

  void toggleDay(Weekday day) {
    final days = {...state.activeDays};
    if (!days.remove(day)) days.add(day);
    emit(state.copyWith(activeDays: days));
  }

  void setStart(Weekday day, TimeOfDay start) {
    final current = state.hoursOf(day);
    emit(state.copyWith(hours: {...state.hours, day: (start: start, end: current.end)}));
  }

  void setEnd(Weekday day, TimeOfDay end) {
    final current = state.hoursOf(day);
    emit(state.copyWith(hours: {...state.hours, day: (start: current.start, end: end)}));
  }
}
