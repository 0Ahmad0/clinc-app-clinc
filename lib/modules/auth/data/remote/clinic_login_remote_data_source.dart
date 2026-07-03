import '../../../../app/core/utils/app_url.dart';
import '../../../../app/domain/services/api_service.dart';
import '../data_sources/clinic_login_data_source.dart';
import '../login_model.dart';
import '../clinic_auth_model.dart';

class ClinicLoginRemoteDataSource implements ClinicLoginDataSource {
  ClinicLoginRemoteDataSource(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<ClinicLoginResponse> login(ClinicLoginRequest request) async {
    final response = await _apiServices.post(
      AppUrl.login,
      body: request.toJson(),
      hasToken: false,
    );

    return ClinicLoginResponse.fromJson(response);
  }

  @override
  Future<ClinicLoginResponse> socialLogin(SocialLoginRequest request) async {
    final response = await _apiServices.post(
      AppUrl.clinicSocialLogin,
      body: request.toJson(),
      hasToken: false,
    );
    return ClinicLoginResponse.fromJson(response);
  }
}
