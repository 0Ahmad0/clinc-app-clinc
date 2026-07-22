import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_otp_verification_model.freezed.dart';
part 'clinic_otp_verification_model.g.dart';

@freezed
abstract class ClinicOtpVerificationModel with _$ClinicOtpVerificationModel {
  const factory ClinicOtpVerificationModel({
    @JsonKey(name: 'reset_token') String? resetToken,
    @JsonKey(name: 'expires_in') int? expiresIn,
  }) = _ClinicOtpVerificationModel;

  factory ClinicOtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicOtpVerificationModelFromJson(json);
}
