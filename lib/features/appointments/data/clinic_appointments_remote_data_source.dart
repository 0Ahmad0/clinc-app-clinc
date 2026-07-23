import 'package:dio/dio.dart';

import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';
import 'models/clinic_appointment_model.dart';

class ClinicAppointmentsRemoteDataSource {
  ClinicAppointmentsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<BaseModels<ClinicAppointmentModel>>> getAppointments({
    required int page,
    required int perPage,
    String? status,
    String? type,
    String? date,
    String? search,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicAppointments,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (status != null) 'status': status,
        if (type != null) 'type': type,
        if (date != null) 'date': date,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
    );

    return BaseModel.fromJson(
      _normalizePaginatedResponse(Map<String, dynamic>.from(response as Map)),
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => ClinicAppointmentModel.fromJson(
          Map<String, dynamic>.from(itemJson as Map),
        ),
      ),
    );
  }

  Future<BaseModel<ClinicAppointmentModel>> getAppointment(String id) async {
    final response = await _apiServices.get(AppUrl.clinicAppointment(id));
    return _appointmentResponse(response);
  }

  Future<BaseModel<ClinicAppointmentModel>> accept(String id) async {
    final response = await _apiServices.post(
      AppUrl.clinicAppointmentAccept(id),
    );
    return _appointmentResponse(response);
  }

  Future<BaseModel<ClinicAppointmentModel>> reject({
    required String id,
    String? reason,
    String? notes,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicAppointmentReject(id),
      body: {
        if (reason != null && reason.trim().isNotEmpty) 'reason': reason.trim(),
        if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
      },
    );
    return _appointmentResponse(response);
  }

  Future<BaseModel<ClinicAppointmentModel>> finish({
    required String id,
    String? notes,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicAppointmentFinish(id),
      body: {
        if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
      },
    );
    return _appointmentResponse(response);
  }

  Future<BaseModel<ClinicAppointmentModel>> uploadResult({
    required String id,
    required String filePath,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicAppointmentResult(id),
      formData: FormData.fromMap({
        'result_file': await MultipartFile.fromFile(filePath),
      }),
    );
    return _appointmentResponse(response);
  }

  BaseModel<ClinicAppointmentModel> _appointmentResponse(dynamic response) {
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => ClinicAppointmentModel.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  Map<String, dynamic> _normalizePaginatedResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map && data['meta'] is Map) {
      final meta = Map<String, dynamic>.from(data['meta'] as Map);
      final currentPage = int.tryParse('${meta['currentPage']}') ?? 1;
      final perPage = int.tryParse('${meta['perPage']}') ?? 0;
      data['meta'] = {
        'current_page': currentPage,
        'per_page': perPage,
        'total': meta['total'],
        'to': currentPage * perPage,
      };
    }
    return json;
  }
}
