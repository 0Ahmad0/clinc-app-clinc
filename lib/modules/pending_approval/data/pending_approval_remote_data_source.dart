import '../../../app/core/utils/app_url.dart';
import '../../../app/data/base_model.dart';
import '../../../app/domain/services/api_service.dart';
import '../models/pending_approval_model.dart';
import 'pending_approval_data_source.dart';

class PendingApprovalRemoteDataSource implements PendingApprovalDataSource {
  PendingApprovalRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<BaseModel<PendingApprovalModel>> getRegistrationStatus({
    required String reference,
  }) async {
    final response = await _apiServices.get(
      AppUrl.clinicRegistrationStatus,
      queryParams: {'registration_reference': reference},
      hasToken: false,
    );
    return BaseModel.fromJson(
      response,
      (json) =>
          PendingApprovalModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
