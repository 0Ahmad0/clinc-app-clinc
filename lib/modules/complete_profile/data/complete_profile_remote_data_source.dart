import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../app/core/utils/app_url.dart';
import '../../../app/domain/services/api_service.dart';
import '../models/complete_profile_model.dart';
import 'complete_profile_data_source.dart';

class CompleteProfileRemoteDataSource implements CompleteProfileDataSource {
  CompleteProfileRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<List<InsuranceModel>> getInsurances() async {
    final response = await _apiServices.get(AppUrl.insurances, hasToken: true);
    final data = Map<String, dynamic>.from(response['data'] as Map);
    return (data['insurances'] as List)
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
    final formData = FormData.fromMap({
      'phone': request.phone,
      'insurance_ids': request.insuranceIds,
      'schedule': jsonEncode(
        request.schedule.map((day) => day.toJson()).toList(),
      ),
      'logo': await MultipartFile.fromFile(request.logoPath),
      'cover': await MultipartFile.fromFile(request.coverPath),
    });
    final response = await _apiServices.post(
      AppUrl.completeClinicProfile,
      formData: formData,
      hasToken: true,
    );
    return CompleteProfileResponse.fromJson(response);
  }
}
