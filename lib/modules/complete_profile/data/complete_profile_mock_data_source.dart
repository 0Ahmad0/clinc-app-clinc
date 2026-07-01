import 'complete_profile_data_source.dart';
import '../models/complete_profile_model.dart';

class CompleteProfileMockDataSource implements CompleteProfileDataSource {
  static const _delay = Duration(milliseconds: 500);

  @override
  Future<List<InsuranceModel>> getInsurances() async {
    await Future<void>.delayed(_delay);
    final response = {
      'status': 'success',
      'message': 'Insurances retrieved successfully',
      'data': {
        'insurances': [
          {'id': 1, 'name': 'بوبا العربية'},
          {'id': 2, 'name': 'التعاونية للتأمين'},
          {'id': 3, 'name': 'ميدغلف'},
        ],
      },
      'meta': <String, dynamic>{},
    };

    final items =
        (response['data']! as Map<String, dynamic>)['insurances'] as List;
    return items
        .map(
          (item) =>
              InsuranceModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }

  @override
  Future<CompleteProfileResponse> completeProfile(
    CompleteClinicProfileRequest request,
  ) async {
    await Future<void>.delayed(_delay);
    return CompleteProfileResponse.fromJson({
      'status': 'success',
      'message': 'Clinic profile completed successfully',
      'data': {
        'clinic': {
          'clinic_id': 'C-001',
          'phone': request.phone,
          'logo': 'clinics/logo1.png',
          'cover': 'clinics/cover1.jpg',
          'insurance_ids': request.insuranceIds,
          'schedule': request.schedule.map((day) => day.toJson()).toList(),
        },
        'needs_completion': false,
        'missing_fields': <String>[],
      },
      'meta': <String, dynamic>{},
    });
  }
}
