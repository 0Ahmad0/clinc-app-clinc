import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_password_reset_model.freezed.dart';
part 'clinic_password_reset_model.g.dart';

@freezed
abstract class ClinicPasswordResetModel with _$ClinicPasswordResetModel {
  const factory ClinicPasswordResetModel({@Default(false) bool reset}) =
      _ClinicPasswordResetModel;

  factory ClinicPasswordResetModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicPasswordResetModelFromJson(json);
}
