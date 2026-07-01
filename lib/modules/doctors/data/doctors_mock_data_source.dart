import '../../../app/data/base_model.dart';
import '../models/doctor_details_model.dart';
import '../models/doctors_list_model.dart';
import 'doctors_data_source.dart';

class DoctorsMockDataSource implements DoctorsDataSource {
  static void addMockDoctor(Map<String, dynamic> doctor) {
    _doctors.insert(0, doctor);
  }

  static bool updateMockDoctor(String id, Map<String, dynamic> doctor) {
    final index = _doctors.indexWhere((item) => item['doctor_id'] == id);
    if (index == -1) return false;
    _doctors[index] = {..._doctors[index], ...doctor, 'doctor_id': id};
    return true;
  }

  static Map<String, dynamic>? specializationById(int id) {
    final matches = _specializations.where((item) => item['id'] == id);
    return matches.isEmpty ? null : Map<String, dynamic>.from(matches.first);
  }

  @override
  Future<DoctorsListResponse> getDoctors({
    String? search,
    int? specializationId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final query = search?.trim().toLowerCase() ?? '';
    final doctors = _doctors.where((doctor) {
      final specialization = doctor['specialization'] as Map<String, dynamic>;
      final matchesSearch =
          query.isEmpty ||
          doctor['name_ar'].toString().toLowerCase().contains(query) ||
          doctor['name_en'].toString().toLowerCase().contains(query) ||
          specialization['name_ar'].toString().toLowerCase().contains(query) ||
          specialization['name_en'].toString().toLowerCase().contains(query);
      final matchesSpecialization =
          specializationId == null || specialization['id'] == specializationId;
      return matchesSearch && matchesSpecialization;
    }).toList();

    return DoctorsListResponse.fromJson({
      'status': 'success',
      'message': 'Clinic doctors retrieved successfully',
      'data': {'doctors': doctors, 'specializations': _specializations},
      'meta': {
        'current_page': 1,
        'per_page': 20,
        'total': doctors.length,
        'last_page': 1,
      },
    });
  }

  @override
  Future<BaseModel<DoctorDetailsModel>> getDoctor(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final matches = _doctors.where((item) => item['doctor_id'] == id);
    if (matches.isEmpty) {
      return BaseModel.fromJson(
        {
          'status': 'error',
          'message': 'Doctor not found',
          'data': null,
          'error': null,
        },
        (json) =>
            DoctorDetailsModel.fromJson(Map<String, dynamic>.from(json as Map)),
      );
    }
    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': 'Doctor details retrieved successfully',
        'data': matches.first,
        'meta': null,
      },
      (json) =>
          DoctorDetailsModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  static const _specializations = [
    {
      'id': 1,
      'name_ar': 'الطب العام',
      'name_en': 'General Medicine',
      'icon': 'stethoscope',
    },
    {
      'id': 2,
      'name_ar': 'طب الأسرة',
      'name_en': 'Family Medicine',
      'icon': 'house-medical',
    },
    {'id': 7, 'name_ar': 'طب الأسنان', 'name_en': 'Dentistry', 'icon': 'tooth'},
  ];

  static final List<Map<String, dynamic>> _doctors = [
    {
      'doctor_id': 'D-001',
      'name_ar': 'د. أحمد السالم',
      'name_en': 'Dr. Ahmed Al Salem',
      'specialization': {
        'id': 1,
        'name_ar': 'الطب العام',
        'name_en': 'General Medicine',
        'icon': 'stethoscope',
      },
      'image': null,
      'is_available': true,
      'experience_years': 12,
      'consultation_fee': 180,
      'currency': 'SAR',
      'phone': '+963 944 111 001',
      'license_number': 'MED-1001',
      'email': 'ahmed@example.com',
      'biography': 'General physician with extensive outpatient experience.',
      'qualification_files': ['https://example.com/medical-license.pdf'],
      'schedule': _defaultSchedule,
    },
    {
      'doctor_id': 'D-002',
      'name_ar': 'د. خالد العتيبي',
      'name_en': 'Dr. Khaled Al Otaibi',
      'specialization': {
        'id': 7,
        'name_ar': 'طب الأسنان',
        'name_en': 'Dentistry',
        'icon': 'tooth',
      },
      'image': null,
      'is_available': true,
      'experience_years': 9,
      'consultation_fee': 220,
      'currency': 'SAR',
      'phone': '+963 944 111 002',
      'license_number': 'MED-1002',
      'email': 'khaled@example.com',
      'biography': 'Dentist focused on restorative and preventive care.',
      'qualification_files': ['https://example.com/dentistry-degree.pdf'],
      'schedule': _defaultSchedule,
    },
    {
      'doctor_id': 'D-011',
      'name_ar': 'د. مازن العنزي',
      'name_en': 'Dr. Mazen Al Enazi',
      'specialization': {
        'id': 2,
        'name_ar': 'طب الأسرة',
        'name_en': 'Family Medicine',
        'icon': 'house-medical',
      },
      'image': null,
      'is_available': false,
      'experience_years': 5,
      'consultation_fee': 170,
      'currency': 'SAR',
      'phone': '+963 944 111 011',
      'license_number': 'MED-1011',
      'email': 'mazen@example.com',
      'biography': 'Family medicine specialist.',
      'qualification_files': const [],
      'schedule': _defaultSchedule,
    },
  ];

  static const _defaultSchedule = [
    {
      'day': 'saturday',
      'is_active': true,
      'from': '09:00 AM',
      'to': '05:00 PM',
    },
    {'day': 'sunday', 'is_active': true, 'from': '09:00 AM', 'to': '05:00 PM'},
    {'day': 'monday', 'is_active': true, 'from': '09:00 AM', 'to': '05:00 PM'},
    {'day': 'tuesday', 'is_active': true, 'from': '09:00 AM', 'to': '05:00 PM'},
    {
      'day': 'wednesday',
      'is_active': true,
      'from': '09:00 AM',
      'to': '05:00 PM',
    },
    {
      'day': 'thursday',
      'is_active': true,
      'from': '09:00 AM',
      'to': '05:00 PM',
    },
    {'day': 'friday', 'is_active': false, 'from': null, 'to': null},
  ];
}
