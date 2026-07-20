import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show TimeOfDay;

import '../../domain/doctor_specialty.dart';
import '../../domain/weekday.dart';

/// A working day's start and end times.
typedef WorkingHours = ({TimeOfDay start, TimeOfDay end});

/// Form state for the add-doctor screen: the chosen specialty (and whether its
/// picker is open), which days the doctor works, and each day's hours.
class AddDoctorState extends Equatable {
  const AddDoctorState({
    this.specialty,
    this.specialtyOpen = false,
    this.activeDays = _defaultDays,
    this.hours = _defaultHours,
  });

  static const Set<Weekday> _defaultDays = {
    Weekday.saturday,
    Weekday.sunday,
    Weekday.monday,
  };

  static const WorkingHours _defaultDay = (
    start: TimeOfDay(hour: 9, minute: 0),
    end: TimeOfDay(hour: 17, minute: 0),
  );

  static const Map<Weekday, WorkingHours> _defaultHours = {
    Weekday.saturday: _defaultDay,
    Weekday.sunday: _defaultDay,
    Weekday.monday: _defaultDay,
    Weekday.tuesday: _defaultDay,
    Weekday.wednesday: _defaultDay,
    Weekday.thursday: _defaultDay,
    Weekday.friday: _defaultDay,
  };

  final DoctorSpecialty? specialty;
  final bool specialtyOpen;
  final Set<Weekday> activeDays;
  final Map<Weekday, WorkingHours> hours;

  bool isActive(Weekday day) => activeDays.contains(day);

  WorkingHours hoursOf(Weekday day) => hours[day] ?? _defaultDay;

  AddDoctorState copyWith({
    DoctorSpecialty? specialty,
    bool? specialtyOpen,
    Set<Weekday>? activeDays,
    Map<Weekday, WorkingHours>? hours,
  }) => AddDoctorState(
    specialty: specialty ?? this.specialty,
    specialtyOpen: specialtyOpen ?? this.specialtyOpen,
    activeDays: activeDays ?? this.activeDays,
    hours: hours ?? this.hours,
  );

  @override
  List<Object?> get props => [specialty, specialtyOpen, activeDays, hours];
}
