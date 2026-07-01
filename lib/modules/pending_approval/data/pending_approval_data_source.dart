import '../../../app/data/base_model.dart';
import '../models/pending_approval_model.dart';

abstract class PendingApprovalDataSource {
  Future<BaseModel<PendingApprovalModel>> getRegistrationStatus({
    required String reference,
  });
}
