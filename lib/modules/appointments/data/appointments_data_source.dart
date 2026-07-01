import '../../../app/data/appointment_model.dart';
import '../../../app/data/base_model.dart';
import '../../../app/extension/appointment_type_extensions.dart';

abstract class AppointmentsDataSource {
  Future<BaseModel<BaseModels<AppointmentModel>>> getAppointments({
    required int page,
    String? search,
    AppointmentStatus? status,
  });

  Future<BaseModel<AppointmentModel>> updateStatus({
    required String id,
    required AppointmentStatus status,
    String? rejectReason,
    String? rejectNote,
  });

  Future<BaseModel<AppointmentModel>> uploadResult({
    required String id,
    required String filePath,
  });
}
