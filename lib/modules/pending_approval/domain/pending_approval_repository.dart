import '../../../app/data/base_model.dart';
import '../../../app/data/remote/api_response.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../data/pending_approval_data_source.dart';
import '../models/pending_approval_model.dart';

class PendingApprovalRepository {
  PendingApprovalRepository(this._dataSource);

  final PendingApprovalDataSource _dataSource;

  Future<ApiResponse<BaseModel<PendingApprovalModel>>> getRegistrationStatus({
    required String reference,
  }) async {
    try {
      return ApiResponse.success(
        await _dataSource.getRegistrationStatus(reference: reference),
      );
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
