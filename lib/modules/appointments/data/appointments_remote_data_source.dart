import 'package:dio/dio.dart';

import '../../../app/core/utils/app_url.dart';
import '../../../app/data/appointment_model.dart';
import '../../../app/data/base_model.dart';
import '../../../app/domain/services/api_service.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import 'appointments_data_source.dart';

class AppointmentsRemoteDataSource implements AppointmentsDataSource {
  AppointmentsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<BaseModel<BaseModels<AppointmentModel>>> getAppointments({
    required int page,
    String? search,
    AppointmentStatus? status,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicAppointments,
      queryParams: {
        'page': page,
        if (search?.trim().isNotEmpty ?? false) 'search': search!.trim(),
        if (status != null) 'status': status.name,
      },
      hasToken: true,
    );
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => BaseModels.fromJson(
        json,
        (item) =>
            AppointmentModel.fromJson(Map<String, dynamic>.from(item as Map)),
      ),
    );
  }

  @override
  Future<BaseModel<AppointmentModel>> updateStatus({
    required String id,
    required AppointmentStatus status,
    String? rejectReason,
    String? rejectNote,
  }) async {
    final response = await _apiServices.put(
      '${AppUrl.clinicAppointments}/$id/status',
      body: {
        'status': status.name,
        if (rejectReason != null) 'reject_reason': rejectReason,
        if (rejectNote != null) 'reject_note': rejectNote,
      },
      hasToken: true,
    );
    return _itemResponse(response);
  }

  @override
  Future<BaseModel<AppointmentModel>> uploadResult({
    required String id,
    required String filePath,
  }) async {
    final response = await _apiServices.post(
      '${AppUrl.clinicAppointments}/$id/result',
      formData: FormData.fromMap({
        'result': await MultipartFile.fromFile(filePath),
      }),
      hasToken: true,
    );
    return _itemResponse(response);
  }

  BaseModel<AppointmentModel> _itemResponse(dynamic response) {
    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) =>
          AppointmentModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
