import '../login_model.dart';
import '../clinic_auth_model.dart';

abstract class ClinicLoginDataSource {
  Future<ClinicLoginResponse> login(ClinicLoginRequest request);

  Future<ClinicLoginResponse> socialLogin(SocialLoginRequest request);
}
