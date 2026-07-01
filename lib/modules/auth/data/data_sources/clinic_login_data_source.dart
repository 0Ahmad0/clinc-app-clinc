import '../login_model.dart';

abstract class ClinicLoginDataSource {
  Future<ClinicLoginResponse> login(ClinicLoginRequest request);
}
