import '../data_sources/clinic_login_data_source.dart';
import '../login_model.dart';

class ClinicLoginMockDataSource implements ClinicLoginDataSource {
  @override
  Future<ClinicLoginResponse> login(ClinicLoginRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final identifier = request.identifier.trim().toLowerCase();

    if (identifier.isEmpty || request.password.isEmpty) {
      return ClinicLoginResponse.fromJson({
        'status': 'error',
        'message': 'Validation failed',
        'error': {
          if (identifier.isEmpty)
            'identifier': ['The identifier field is required.'],
          if (request.password.isEmpty)
            'password': ['The password field is required.'],
        },
      });
    }

    if (identifier == 'admin@dammam-care.com' || identifier == 'cln-dmm-1006') {
      return ClinicLoginResponse.fromJson({
        'status': 'error',
        'message':
            'Clinic registration request is still pending admin approval',
        'error': {'status': 'pending', 'needs_completion': true},
      });
    }

    if (identifier != 'info@nukhba-clinic.com' &&
        identifier != 'cln-ryd-1001') {
      return ClinicLoginResponse.fromJson({
        'status': 'error',
        'message': 'Invalid email, license number, or password',
        'error': <String, dynamic>{},
      });
    }

    return ClinicLoginResponse.fromJson({
      'status': 'success',
      'message': 'Clinic logged in successfully',
      'data': {
        'clinic': {
          'clinic_id': 'C-001',
          'name': 'عيادات النخبة الطبية',
          'location': 'الرياض - شمال الرياض - حي النرجس',
          'doctors_count': 3,
          'appointments_count': 1,
          'revenue': 0,
          'rating': 0,
          'status': 'approved',
          'email': 'info@nukhba-clinic.com',
          'phone': '966501111111',
          'type': 'both',
          'logo': 'clinics/logo1.png',
          'cover': 'clinics/cover1.jpg',
          'description': 'مجمع طبي متكامل يضم عدة تخصصات وخدمات تشخيصية.',
          'lat': '24.8485000',
          'lng': '46.7121000',
          'is_active': true,
          'created_at': '2026-04-19',
        },
        'needs_completion': false,
        'missing_fields': <String>[],
        'token': '',
      },
      'meta': <String, dynamic>{},
    });
  }
}
