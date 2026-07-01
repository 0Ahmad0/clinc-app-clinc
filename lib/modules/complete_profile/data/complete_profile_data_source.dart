import '../models/complete_profile_model.dart';

abstract class CompleteProfileDataSource {
  Future<List<InsuranceModel>> getInsurances();

  Future<CompleteProfileResponse> completeProfile(
    CompleteClinicProfileRequest request,
  );
}
