import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_logout_model.freezed.dart';
part 'clinic_logout_model.g.dart';

@freezed
abstract class ClinicLogoutModel with _$ClinicLogoutModel {
  const factory ClinicLogoutModel({
    @JsonKey(name: 'logged_out') @Default(false) bool loggedOut,
  }) = _ClinicLogoutModel;

  factory ClinicLogoutModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicLogoutModelFromJson(json);
}
