import '../../../app/data/appointment_model.dart';
import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import '../data/appointments_data_source.dart';

class AppointmentsRepository {
  AppointmentsRepository(this._dataSource);

  final AppointmentsDataSource _dataSource;

  Future<ApiResponse<BaseModel<BaseModels<AppointmentModel>>>> getAppointments({
    required int page,
    String? search,
    AppointmentStatus? status,
  }) async {
    try {
      return ApiResponse.success(
        await _dataSource.getAppointments(
          page: page,
          search: search,
          status: status,
        ),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel<AppointmentModel>>> updateStatus({
    required String id,
    required AppointmentStatus status,
    String? rejectReason,
    String? rejectNote,
  }) async {
    try {
      return ApiResponse.success(
        await _dataSource.updateStatus(
          id: id,
          status: status,
          rejectReason: rejectReason,
          rejectNote: rejectNote,
        ),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseModel<AppointmentModel>>> uploadResult({
    required String id,
    required String filePath,
  }) async {
    try {
      return ApiResponse.success(
        await _dataSource.uploadResult(id: id, filePath: filePath),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
