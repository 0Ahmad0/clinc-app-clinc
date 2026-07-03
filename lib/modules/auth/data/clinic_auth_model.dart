import '../../../app/data/account_type.dart';

class ClinicRegisterRequest {
  const ClinicRegisterRequest({
    required this.name,
    required this.licenseNumber,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.type,
  });

  final String name;
  final String licenseNumber;
  final String email;
  final String password;
  final String passwordConfirmation;
  final AccountType type;

  Map<String, dynamic> toJson() => {
    'name': name,
    'license_number': licenseNumber,
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation,
    'type': type.name,
  };
}

class ForgotPasswordRequest {
  const ForgotPasswordRequest({required this.identifier});

  final String identifier;

  Map<String, dynamic> toJson() => {'identifier': identifier};
}

class VerifyOtpRequest {
  const VerifyOtpRequest({
    required this.identifier,
    required this.otp,
    required this.purpose,
  });

  final String identifier;
  final String otp;
  final String purpose;

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'otp': otp,
    'purpose': purpose,
  };
}

class ResendOtpRequest {
  const ResendOtpRequest({required this.identifier, required this.purpose});

  final String identifier;
  final String purpose;

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'purpose': purpose,
  };
}

class ResetPasswordRequest {
  const ResetPasswordRequest({
    required this.identifier,
    required this.resetToken,
    required this.password,
    required this.passwordConfirmation,
  });

  final String identifier;
  final String resetToken;
  final String password;
  final String passwordConfirmation;

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'reset_token': resetToken,
    'password': password,
    'password_confirmation': passwordConfirmation,
  };
}

class SocialLoginRequest {
  const SocialLoginRequest({required this.provider});

  final String provider;

  Map<String, dynamic> toJson() => {'provider': provider};
}

class ClinicAuthActionResponse {
  const ClinicAuthActionResponse({
    required this.status,
    required this.message,
    this.data,
    this.error,
    this.meta = const {},
  });

  final String status;
  final String message;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? error;
  final Map<String, dynamic> meta;

  bool get isSuccess => status == 'success';

  factory ClinicAuthActionResponse.fromJson(Map<String, dynamic> json) {
    return ClinicAuthActionResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] is Map
          ? Map<String, dynamic>.from(json['data'] as Map)
          : null,
      error: json['error'] is Map
          ? Map<String, dynamic>.from(json['error'] as Map)
          : null,
      meta: json['meta'] is Map
          ? Map<String, dynamic>.from(json['meta'] as Map)
          : const {},
    );
  }
}
