import '../clinic_auth_model.dart';
import '../data_sources/clinic_auth_data_source.dart';

class ClinicAuthMockDataSource implements ClinicAuthDataSource {
  static const _delay = Duration(milliseconds: 500);

  @override
  Future<ClinicAuthActionResponse> register(
    ClinicRegisterRequest request,
  ) async {
    await Future<void>.delayed(_delay);

    if (request.email.toLowerCase() == 'info@nukhba-clinic.com' ||
        request.licenseNumber.toLowerCase() == 'cln-ryd-1001') {
      return _response({
        'status': 'error',
        'message': 'Validation failed',
        'error': {
          if (request.licenseNumber.toLowerCase() == 'cln-ryd-1001')
            'license_number': ['The license number has already been taken.'],
          if (request.email.toLowerCase() == 'info@nukhba-clinic.com')
            'email': ['The email has already been taken.'],
        },
      });
    }

    return _response({
      'status': 'success',
      'message': 'Clinic registration request submitted successfully',
      'data': {
        'clinic': {
          'clinic_id': 'C-011',
          'name': request.name,
          'license_number': request.licenseNumber,
          'email': request.email,
          'type': request.type.name,
          'status': 'pending',
        },
      },
      'meta': <String, dynamic>{},
    });
  }

  @override
  Future<ClinicAuthActionResponse> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    await Future<void>.delayed(_delay);

    if (!_isKnownIdentifier(request.identifier)) {
      return _response({
        'status': 'error',
        'message': 'Resource not found',
        'error': null,
      });
    }

    return _response({
      'status': 'success',
      'message': 'Verification code sent successfully',
      'data': {
        'identifier': request.identifier,
        'delivery_method': 'email',
        'expires_in': 60,
      },
      'meta': <String, dynamic>{},
    });
  }

  @override
  Future<ClinicAuthActionResponse> verifyOtp(VerifyOtpRequest request) async {
    await Future<void>.delayed(_delay);

    if (request.otp != '1234') {
      return _response({
        'status': 'error',
        'message': 'Invalid or expired verification code',
        'error': <String, dynamic>{},
      });
    }

    return _response({
      'status': 'success',
      'message': 'Verification code verified successfully',
      'data': {'verified': true, 'reset_token': 'mock-password-reset-token'},
      'meta': <String, dynamic>{},
    });
  }

  @override
  Future<ClinicAuthActionResponse> resendOtp(ResendOtpRequest request) async {
    await Future<void>.delayed(_delay);
    return _response({
      'status': 'success',
      'message': 'Verification code resent successfully',
      'data': {'identifier': request.identifier, 'expires_in': 60},
      'meta': <String, dynamic>{},
    });
  }

  bool _isKnownIdentifier(String value) {
    final identifier = value.trim().toLowerCase();
    return identifier == 'info@nukhba-clinic.com' ||
        identifier == 'cln-ryd-1001';
  }

  ClinicAuthActionResponse _response(Map<String, dynamic> json) {
    return ClinicAuthActionResponse.fromJson(json);
  }
}
