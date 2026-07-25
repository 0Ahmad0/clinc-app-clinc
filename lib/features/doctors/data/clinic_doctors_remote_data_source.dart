import 'package:dio/dio.dart';

import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_doctor_model.dart';
import 'models/clinic_specialization_model.dart';

class ClinicDoctorsRemoteDataSource {
  ClinicDoctorsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<BaseModels<ClinicDoctorModel>>> getDoctors({
    required int page,
    required int perPage,
    String? search,
    String? specializationId,
    bool? isActive,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicDoctors,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        if (specializationId != null) 'specialization_id': specializationId,
        if (isActive != null) 'is_active': isActive,
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicDoctorModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<ClinicDoctorModel>> getDoctor(String id) async {
    final response = await _apiServices.get(AppUrl.clinicDoctor(id));
    return _doctorResponse(response);
  }

  Future<BaseModel<ClinicDoctorModel>> createDoctor({
    required Map<String, dynamic> body,
    String? imagePath,
    List<String> qualificationFilePaths = const [],
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicDoctors,
      formData: await _doctorFormData(
        body: body,
        imagePath: imagePath,
        qualificationFilePaths: qualificationFilePaths,
      ),
    );
    return _doctorResponse(response);
  }

  Future<BaseModel<ClinicDoctorModel>> updateDoctor({
    required String id,
    required Map<String, dynamic> body,
    String? imagePath,
    List<String> qualificationFilePaths = const [],
  }) async {
    final response = await _apiServices.put(
      AppUrl.clinicDoctor(id),
      formData: await _doctorFormData(
        body: body,
        imagePath: imagePath,
        qualificationFilePaths: qualificationFilePaths,
      ),
    );
    return _doctorResponse(response);
  }

  Future<BaseModel<ClinicDoctorModel>> updateAvailability({
    required String id,
    required bool isActive,
  }) async {
    final response = await _apiServices.patch(
      AppUrl.clinicDoctorAvailability(id),
      body: {'is_active': isActive},
    );
    return _doctorResponse(response);
  }

  Future<BaseModel<BaseModels<ClinicSpecializationModel>>>
  getSpecializations() async {
    final response = await _apiServices.get(AppUrl.clinicSpecializations);
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicSpecializationModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  BaseModel<ClinicDoctorModel> _doctorResponse(dynamic response) {
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          ClinicDoctorModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  Future<FormData> _doctorFormData({
    required Map<String, dynamic> body,
    String? imagePath,
    List<String> qualificationFilePaths = const [],
  }) async {
    final form = FormData();
    for (final entry in body.entries) {
      final value = entry.value;
      if (value is List) {
        for (var index = 0; index < value.length; index++) {
          final item = value[index];
          if (item is Map<String, dynamic>) {
            for (final itemEntry in item.entries) {
              form.fields.add(
                MapEntry(
                  '${entry.key}[$index][${itemEntry.key}]',
                  _fieldValue(itemEntry.value),
                ),
              );
            }
          }
        }
      } else if (value != null) {
        form.fields.add(MapEntry(entry.key, _fieldValue(value)));
      }
    }
    if (imagePath != null) {
      form.files.add(
        MapEntry('image', await MultipartFile.fromFile(imagePath)),
      );
    }
    for (final path in qualificationFilePaths) {
      form.files.add(
        MapEntry('qualification_files[]', await MultipartFile.fromFile(path)),
      );
    }
    return form;
  }

  String _fieldValue(dynamic value) {
    if (value is bool) return value ? '1' : '0';
    return value.toString();
  }

  Map<String, dynamic> _normalizePaginatedResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map && data['meta'] is Map) {
      final meta = Map<String, dynamic>.from(data['meta'] as Map);
      data['meta'] = {
        'current_page': meta['currentPage'],
        'per_page': meta['perPage'],
        'total': meta['total'],
        'to':
            ((meta['currentPage'] ?? 1) as int) *
            ((meta['perPage'] ?? 0) as int),
      };
    }
    return json;
  }
}
