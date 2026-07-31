import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../../shared/input/email_input.dart';
import '../../data/models/clinic_doctor_model.dart';
import '../../data/models/clinic_specialization_model.dart';
import '../../domain/clinic_doctors_repository.dart';
import '../../domain/weekday.dart';

part 'add_doctor_cubit.freezed.dart';
part 'add_doctor_state.dart';

class AddDoctorCubit extends Cubit<AddDoctorState> {
  AddDoctorCubit(this._repository, {ClinicDoctorModel? initialDoctor})
    : super(
        AddDoctorState(
          initialDoctor: initialDoctor,
          selectedSpecializationId: initialDoctor?.specializationId,
          gender: initialDoctor?.gender ?? 'male',
          qualificationFiles: _qualificationFilesFrom(initialDoctor),
          activeDays: _activeDaysFrom(initialDoctor),
          hours: _hoursFrom(initialDoctor),
        ),
      );

  final ClinicDoctorsRepository _repository;

  Future<void> loadSpecializations() async {
    emit(state.copyWith(isLoadingSpecializations: true, failure: null));
    final result = await _repository.getSpecializations();
    result.when(
      success: (response) {
        emit(
          state.copyWith(
            specializations: response.result?.list ?? const [],
            isLoadingSpecializations: false,
            failure: null,
          ),
        );
      },
      failure: (exception) => emit(
        state.copyWith(isLoadingSpecializations: false, failure: exception),
      ),
    );
  }

  void toggleSpecialtyPicker() =>
      emit(state.copyWith(specialtyOpen: !state.specialtyOpen));

  void selectSpecialization(String specializationId) => emit(
    state.copyWith(
      selectedSpecializationId: specializationId,
      specialtyOpen: false,
    ),
  );

  void selectGender(String gender) => emit(state.copyWith(gender: gender));

  void setImage(String path) => emit(state.copyWith(imagePath: path));

  void removeImage() => emit(state.copyWith(imagePath: null));

  void addQualificationFile({required String path, required String name}) {
    emit(
      state.copyWith(
        qualificationFiles: [
          ...state.qualificationFiles,
          (path: path, name: name),
        ],
      ),
    );
  }

  void removeQualificationFile(String path) {
    emit(
      state.copyWith(
        qualificationFiles: state.qualificationFiles
            .where((file) => file.path != path)
            .toList(growable: false),
      ),
    );
  }

  void toggleDay(Weekday day) {
    final days = {...state.activeDays};
    if (!days.remove(day)) days.add(day);
    emit(state.copyWith(activeDays: days, failure: null));
  }

  void setStart(Weekday day, TimeOfDay start) {
    final current = state.hoursOf(day);
    emit(
      state.copyWith(
        hours: {...state.hours, day: (start: start, end: current.end)},
        failure: null,
      ),
    );
  }

  void setEnd(Weekday day, TimeOfDay end) {
    final current = state.hoursOf(day);
    emit(
      state.copyWith(
        hours: {...state.hours, day: (start: current.start, end: end)},
        failure: null,
      ),
    );
  }

  Future<void> save({
    required String nameAr,
    required String nameEn,
    required String phone,
    required String email,
    required String licenseNumber,
    required String experienceYears,
    required String consultationFee,
    required String bio,
  }) async {
    final specializationId = state.selectedSpecializationId;
    if (specializationId == null || specializationId.isEmpty) {
      emit(
        state.copyWith(
          failure: const NetworkExceptions.unprocessableEntity(
            'specialization_id is required',
          ),
        ),
      );
      return;
    }

    if (!_hasValidActiveSchedule()) {
      emit(state.copyWith(showScheduleValidation: true, failure: null));
      return;
    }

    final remainingRemoteQualificationFiles = state.qualificationFiles
        .where((file) => _isRemoteQualificationPath(file.path))
        .map((file) => file.path)
        .toList(growable: false);
    final body = {
      'name_ar': nameAr.trim(),
      'name_en': _nullable(nameEn),
      'specialization_id': specializationId,
      'gender': state.gender,
      'phone': _nullable(phone),
      'email': _nullable(normalizeEmailInput(email)),
      'license_number': _nullable(licenseNumber),
      'experience_years': int.tryParse(experienceYears.trim()) ?? 0,
      'consultation_fee': num.tryParse(consultationFee.trim()) ?? 0,
      'bio': _nullable(bio),
      'is_active': state.initialDoctor?.isActive ?? true,
      if (state.isEdit)
        'existing_qualification_files': remainingRemoteQualificationFiles,
      'schedules': [
        for (final day in Weekday.values)
          {
            'day': day.name,
            'from': _time(state.hoursOf(day).start),
            'to': _time(state.hoursOf(day).end),
            'is_active': state.isActive(day),
          },
      ],
    };

    emit(
      state.copyWith(
        isSaving: true,
        saved: false,
        showScheduleValidation: false,
        failure: null,
      ),
    );
    final id = state.initialDoctor?.doctorId;
    final result = id == null
        ? await _repository.createDoctor(
            body,
            imagePath: state.imagePath,
            qualificationFilePaths: state.qualificationFiles
                .where((file) => !_isRemoteQualificationPath(file.path))
                .map((file) => file.path)
                .toList(growable: false),
          )
        : await _repository.updateDoctor(
            id: id,
            body: body,
            imagePath: state.imagePath,
            qualificationFilePaths: state.qualificationFiles
                .where((file) => !_isRemoteQualificationPath(file.path))
                .map((file) => file.path)
                .toList(growable: false),
          );

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            savedDoctor: response.result,
            isSaving: false,
            saved: true,
            failure: null,
          ),
        );
      },
      failure: (exception) => emit(
        state.copyWith(isSaving: false, saved: false, failure: exception),
      ),
    );
  }

  bool _hasValidActiveSchedule() {
    for (final day in state.activeDays) {
      if (state.hasInvalidHours(day)) return false;
    }
    return true;
  }

  String? _nullable(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String _time(TimeOfDay value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static Set<Weekday> _activeDaysFrom(ClinicDoctorModel? doctor) {
    if (doctor == null || doctor.schedules.isEmpty) return _defaultDays;
    return {
      for (final schedule in doctor.schedules)
        if (schedule.isActive) _weekday(schedule.day),
    };
  }

  static Map<Weekday, WorkingHours> _hoursFrom(ClinicDoctorModel? doctor) {
    if (doctor == null || doctor.schedules.isEmpty) return _defaultHours;
    return {
      ..._defaultHours,
      for (final schedule in doctor.schedules)
        _weekday(schedule.day): (
          start: _parseTime(schedule.from),
          end: _parseTime(schedule.to),
        ),
    };
  }

  static Weekday _weekday(String? value) {
    return Weekday.values.firstWhere(
      (day) => day.name == (value ?? '').toLowerCase(),
      orElse: () => Weekday.saturday,
    );
  }

  static TimeOfDay _parseTime(String? value) {
    final parts = (value ?? '').split(':');
    return TimeOfDay(
      hour: int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 9,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
    );
  }

  static List<DoctorPickedQualification> _qualificationFilesFrom(
    ClinicDoctorModel? doctor,
  ) {
    final files = doctor?.qualificationFiles ?? const <String>[];
    return [
      for (final file in files)
        if (file.trim().isNotEmpty)
          (path: file.trim(), name: _qualificationName(file.trim())),
    ];
  }

  static String _qualificationName(String path) {
    final uri = Uri.tryParse(path);
    final segment = uri?.pathSegments.isNotEmpty == true
        ? uri!.pathSegments.last
        : path.split('/').last;
    final decoded = Uri.decodeComponent(segment).trim();
    return decoded.isEmpty ? 'qualification.pdf' : decoded;
  }

  static bool _isRemoteQualificationPath(String path) {
    final uri = Uri.tryParse(path.trim());
    return uri?.hasScheme == true && uri?.hasAuthority == true;
  }
}
