part of 'add_doctor_cubit.dart';

typedef WorkingHours = ({TimeOfDay start, TimeOfDay end});
typedef DoctorPickedQualification = ({String path, String name});

@freezed
abstract class AddDoctorState with _$AddDoctorState {
  const factory AddDoctorState({
    ClinicDoctorModel? initialDoctor,
    ClinicDoctorModel? savedDoctor,
    @Default(<ClinicSpecializationModel>[])
    List<ClinicSpecializationModel> specializations,
    String? selectedSpecializationId,
    @Default('male') String gender,
    String? imagePath,
    @Default(<DoctorPickedQualification>[])
    List<DoctorPickedQualification> qualificationFiles,
    @Default(false) bool specialtyOpen,
    @Default(_defaultDays) Set<Weekday> activeDays,
    @Default(_defaultHours) Map<Weekday, WorkingHours> hours,
    @Default(false) bool isLoadingSpecializations,
    @Default(false) bool isSaving,
    @Default(false) bool saved,
    NetworkExceptions? failure,
  }) = _AddDoctorState;
}

const Set<Weekday> _defaultDays = {
  Weekday.saturday,
  Weekday.sunday,
  Weekday.monday,
};

const WorkingHours _defaultDay = (
  start: TimeOfDay(hour: 9, minute: 0),
  end: TimeOfDay(hour: 17, minute: 0),
);

const Map<Weekday, WorkingHours> _defaultHours = {
  Weekday.saturday: _defaultDay,
  Weekday.sunday: _defaultDay,
  Weekday.monday: _defaultDay,
  Weekday.tuesday: _defaultDay,
  Weekday.wednesday: _defaultDay,
  Weekday.thursday: _defaultDay,
  Weekday.friday: _defaultDay,
};

extension AddDoctorStateX on AddDoctorState {
  bool get isEdit => initialDoctor?.doctorId != null;

  bool isActive(Weekday day) => activeDays.contains(day);

  WorkingHours hoursOf(Weekday day) => hours[day] ?? _defaultDay;

  ClinicSpecializationModel? get selectedSpecialization {
    for (final specialization in specializations) {
      if (specialization.specializationId == selectedSpecializationId) {
        return specialization;
      }
    }
    return null;
  }
}
