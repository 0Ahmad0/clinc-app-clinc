import 'package:dio/dio.dart';

import '../../../core/data/base_model.dart';
import '../../../core/domain/services/api_service.dart';
import '../../../core/utils/app_url.dart';

class ClinicAdsRemoteDataSource {
  ClinicAdsRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  Future<BaseModel<Map<String, dynamic>>> createAd({
    required String titleAr,
    required String titleEn,
    required String descriptionAr,
    required String descriptionEn,
    required String coverPath,
  }) async {
    final response = await _apiServices.post(
      AppUrl.clinicAds,
      formData: FormData.fromMap({
        'title_ar': titleAr,
        'title_en': titleEn,
        'description_ar': descriptionAr,
        'description_en': descriptionEn,
        'cover': await MultipartFile.fromFile(coverPath),
      }),
    );

    return BaseModel.fromJson(
      Map<String, dynamic>.from(response as Map),
      (json) => Map<String, dynamic>.from(json as Map),
    );
  }
}
