import '../../../app/data/base_model.dart';
import '../models/pending_approval_model.dart';
import 'pending_approval_data_source.dart';

class PendingApprovalMockDataSource implements PendingApprovalDataSource {
  int _checksCount = 0;

  @override
  Future<BaseModel<PendingApprovalModel>> getRegistrationStatus({
    required String reference,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _checksCount++;
    final status = _checksCount >= 2 ? 'approved' : 'pending';

    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': status == 'approved'
            ? 'Clinic registration request approved'
            : 'Clinic registration request is still pending admin approval',
        'data': {
          'registration_reference': reference,
          'status': status,
          'needs_completion': true,
          'rejection_reason': null,
        },
        'meta': <String, dynamic>{},
      },
      (json) =>
          PendingApprovalModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
