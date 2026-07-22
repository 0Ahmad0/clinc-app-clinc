import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_otp_status_model.freezed.dart';
part 'clinic_otp_status_model.g.dart';

@freezed
abstract class ClinicOtpStatusModel with _$ClinicOtpStatusModel {
  const factory ClinicOtpStatusModel({
    String? identifier,
    String? purpose,
    @JsonKey(name: 'expires_in') int? expiresIn,
  }) = _ClinicOtpStatusModel;

  factory ClinicOtpStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicOtpStatusModelFromJson(json);
}
