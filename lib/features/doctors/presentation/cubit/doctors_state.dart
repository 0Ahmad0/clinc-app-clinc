import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/models/clinic_doctor_model.dart';
import '../../data/models/clinic_specialization_model.dart';

part 'doctors_state.freezed.dart';

@freezed
abstract class DoctorsState with _$DoctorsState {
  const factory DoctorsState({
    required PaginationState<ClinicDoctorModel> pagination,
    @Default(<ClinicSpecializationModel>[])
    List<ClinicSpecializationModel> specializations,
    String? selectedSpecializationId,
    @Default('') String query,
    NetworkExceptions? failure,
  }) = _DoctorsState;
}
