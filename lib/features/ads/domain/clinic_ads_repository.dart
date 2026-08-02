import '../../../core/data/base_model.dart';
import '../../../core/data/remote/api_response.dart';
import '../../../core/domain/error_handler/network_exceptions.dart';
import '../data/clinic_ads_remote_data_source.dart';

class ClinicAdsRepository {
  ClinicAdsRepository(this._remoteDataSource);

  final ClinicAdsRemoteDataSource _remoteDataSource;

  Future<ApiResponse<BaseModel<Map<String, dynamic>>>> createAd({
    required String titleAr,
    required String titleEn,
    required String descriptionAr,
    required String descriptionEn,
    required String coverPath,
  }) => _execute(
    () => _remoteDataSource.createAd(
      titleAr: titleAr,
      titleEn: titleEn,
      descriptionAr: descriptionAr,
      descriptionEn: descriptionEn,
      coverPath: coverPath,
    ),
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
