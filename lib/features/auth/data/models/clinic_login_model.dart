import 'package:freezed_annotation/freezed_annotation.dart';

import 'clinic_model.dart';

part 'clinic_login_model.freezed.dart';
part 'clinic_login_model.g.dart';

@freezed
abstract class ClinicLoginModel with _$ClinicLoginModel {
  const factory ClinicLoginModel({
    ClinicModel? clinic,
    String? token,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'expires_at') String? expiresAt,
    @JsonKey(name: 'needs_completion') @Default(false) bool needsCompletion,
    @JsonKey(name: 'missing_fields')
    @Default(<String>[])
    List<String> missingFields,
  }) = _ClinicLoginModel;

  factory ClinicLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicLoginModelFromJson(json);
}
