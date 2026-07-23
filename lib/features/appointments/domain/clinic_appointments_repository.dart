import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_appointments_remote_data_source.dart';
import '../data/models/clinic_appointment_model.dart';

class ClinicAppointmentsRepository {
  ClinicAppointmentsRepository(this._remoteDataSource);

  final ClinicAppointmentsRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<BaseModels<ClinicAppointmentModel>>>>
  getAppointments({
    required int page,
    required int perPage,
    String? status,
    String? type,
    String? date,
    String? search,
  }) => _execute(
    () => _remoteDataSource.getAppointments(
      page: page,
      perPage: perPage,
      status: status,
      type: type,
      date: date,
      search: search,
    ),
  );

  Future<ApiResponse<BaseModel<ClinicAppointmentModel>>> getAppointment(
    String id,
  ) => _execute(() => _remoteDataSource.getAppointment(id));

  Future<ApiResponse<BaseModel<ClinicAppointmentModel>>> accept(String id) =>
      _execute(() => _remoteDataSource.accept(id));

  Future<ApiResponse<BaseModel<ClinicAppointmentModel>>> reject({
    required String id,
    String? reason,
    String? notes,
  }) => _execute(
    () => _remoteDataSource.reject(id: id, reason: reason, notes: notes),
  );

  Future<ApiResponse<BaseModel<ClinicAppointmentModel>>> finish({
    required String id,
    String? notes,
  }) => _execute(() => _remoteDataSource.finish(id: id, notes: notes));

  Future<ApiResponse<BaseModel<ClinicAppointmentModel>>> uploadResult({
    required String id,
    required String filePath,
  }) => _execute(
    () => _remoteDataSource.uploadResult(id: id, filePath: filePath),
  );

  Future<ApiResponse<BaseModel<T>>> _execute<T>(
    Future<BaseModel<T>> Function() action,
  ) async {
    try {
      return ApiResponse.success(await action());
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
