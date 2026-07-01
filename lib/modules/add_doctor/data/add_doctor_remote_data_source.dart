import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../app/core/utils/app_url.dart';
import '../../../app/data/base_model.dart';
import '../../../app/domain/services/api_service.dart';
import '../models/add_doctor_model.dart';
import 'add_doctor_data_source.dart';

class AddDoctorRemoteDataSource implements AddDoctorDataSource {
  AddDoctorRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<BaseModel<AddedDoctorModel>> addDoctor(
    AddDoctorRequest request,
  ) async {
    final body = request.toJson();
    body['schedule'] = jsonEncode(body['schedule']);
    final formData = FormData.fromMap(body);
    if (request.imagePath?.isNotEmpty ?? false) {
      formData.files.add(
        MapEntry('image', await MultipartFile.fromFile(request.imagePath!)),
      );
    }
    for (final path in request.qualificationFiles) {
      formData.files.add(
        MapEntry('qualification_files[]', await MultipartFile.fromFile(path)),
      );
    }
    final response = await _apiServices.post(
      AppUrl.clinicDoctors,
      formData: formData,
      hasToken: true,
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          AddedDoctorModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  @override
  Future<BaseModel<AddedDoctorModel>> updateDoctor(
    String id,
    AddDoctorRequest request,
  ) async {
    final formData = await _formData(request);
    formData.fields.add(const MapEntry('_method', 'PUT'));
    final response = await _apiServices.post(
      '${AppUrl.clinicDoctors}/$id',
      formData: formData,
      hasToken: true,
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          AddedDoctorModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<FormData> _formData(AddDoctorRequest request) async {
    final body = request.toJson();
    body['schedule'] = jsonEncode(body['schedule']);
    final formData = FormData.fromMap(body);
    if (request.imagePath?.isNotEmpty ?? false) {
      formData.files.add(
        MapEntry('image', await MultipartFile.fromFile(request.imagePath!)),
      );
    }
    for (final path in request.qualificationFiles) {
      if (path.startsWith('http')) continue;
      formData.files.add(
        MapEntry('qualification_files[]', await MultipartFile.fromFile(path)),
      );
    }
    return formData;
  }
}
