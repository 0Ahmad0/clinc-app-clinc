import '../../../app/data/base_model.dart';
import '../models/clinic_service_model.dart';
import 'services_data_source.dart';

class ServicesMockDataSource implements ServicesDataSource {
  static const _delay = Duration(milliseconds: 400);
  static const _pageSize = 2;

  static final _labSections = <Map<String, dynamic>>[
    {
      'section_id': 'LC-001',
      'name_ar': 'تحاليل الدم',
      'name_en': 'Blood Tests',
      'icon': 'droplets',
      'is_added': true,
      'has_doctor': true,
      'tests': [
        {
          'test_id': 'LT-001',
          'name': 'صورة دم كاملة CBC',
          'icon': 'blood',
          'price': 85,
          'is_enabled': true,
        },
        {
          'test_id': 'LT-002',
          'name': 'فصيلة الدم ABO/Rh',
          'icon': 'blood',
          'price': 0,
          'is_enabled': false,
        },
      ],
    },
    {
      'section_id': 'LC-002',
      'name_ar': 'تحاليل السكر والغدد',
      'name_en': 'Diabetes and Glands',
      'icon': 'activity',
      'is_added': false,
      'has_doctor': true,
      'tests': [
        {
          'test_id': 'LT-003',
          'name': 'سكر صائم FBS',
          'icon': 'activity',
          'price': 0,
          'is_enabled': false,
        },
        {
          'test_id': 'LT-004',
          'name': 'السكر التراكمي HbA1c',
          'icon': 'activity',
          'price': 0,
          'is_enabled': false,
        },
      ],
    },
    {
      'section_id': 'LC-003',
      'name_ar': 'الفيتامينات والمعادن',
      'name_en': 'Vitamins and Minerals',
      'icon': 'pill',
      'is_added': false,
      'has_doctor': true,
      'tests': [
        {
          'test_id': 'LT-005',
          'name': 'فيتامين D',
          'icon': 'pill',
          'price': 0,
          'is_enabled': false,
        },
      ],
    },
  ];

  static final _medicalSections = <Map<String, dynamic>>[
    {
      'section_id': 'SP-001',
      'name_ar': 'الطب العام',
      'name_en': 'General Medicine',
      'icon': 'stethoscope',
      'is_added': true,
      'has_doctor': true,
      'tests': <Map<String, dynamic>>[],
    },
    {
      'section_id': 'SP-007',
      'name_ar': 'طب الأسنان',
      'name_en': 'Dentistry',
      'icon': 'tooth',
      'is_added': false,
      'has_doctor': true,
      'tests': <Map<String, dynamic>>[],
    },
    {
      'section_id': 'SP-003',
      'name_ar': 'أمراض القلب',
      'name_en': 'Cardiology',
      'icon': 'heart-pulse',
      'is_added': false,
      'has_doctor': false,
      'tests': <Map<String, dynamic>>[],
    },
  ];

  @override
  Future<BaseModel<BaseModels<ClinicServiceSection>>> getSections({
    required ClinicServiceTab type,
    required int page,
  }) async {
    await Future<void>.delayed(_delay);
    final source = type == ClinicServiceTab.lab
        ? _labSections
        : _medicalSections;
    final start = (page - 1) * _pageSize;
    final items = start >= source.length
        ? <Map<String, dynamic>>[]
        : source.sublist(start, (start + _pageSize).clamp(0, source.length));
    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': 'Service sections retrieved successfully',
        'data': items,
        'meta': {
          'current_page': page,
          'from': items.isEmpty ? null : start + 1,
          'to': items.isEmpty ? null : start + items.length,
          'per_page': _pageSize,
          'total': source.length,
        },
      },
      (json) => BaseModels.fromJson(
        json,
        (item) => ClinicServiceSection.fromJson(
          Map<String, dynamic>.from(item as Map),
        ),
      ),
    );
  }

  @override
  Future<BaseModel<ClinicServiceSection>> addSection({
    required ClinicServiceTab type,
    required String sectionId,
  }) async {
    await Future<void>.delayed(_delay);
    final source = type == ClinicServiceTab.lab
        ? _labSections
        : _medicalSections;
    final index = source.indexWhere(
      (section) => section['section_id'] == sectionId,
    );
    final section = source[index];
    if (type == ClinicServiceTab.medical && section['has_doctor'] != true) {
      return _sectionResponse(
        section,
        status: 'error',
        message: 'A doctor with this specialization is required',
      );
    }
    source[index] = {...section, 'is_added': true};
    return _sectionResponse(
      source[index],
      message: 'Service section added successfully',
    );
  }

  @override
  Future<BaseModel<ClinicServiceSection>> updateLabTest({
    required String sectionId,
    required String testId,
    required bool isEnabled,
    required num price,
  }) async {
    await Future<void>.delayed(_delay);
    final sectionIndex = _labSections.indexWhere(
      (section) => section['section_id'] == sectionId,
    );
    final tests = List<Map<String, dynamic>>.from(
      _labSections[sectionIndex]['tests'] as List,
    );
    final testIndex = tests.indexWhere((test) => test['test_id'] == testId);
    tests[testIndex] = {
      ...tests[testIndex],
      'is_enabled': isEnabled,
      'price': isEnabled ? price : 0,
    };
    _labSections[sectionIndex] = {
      ..._labSections[sectionIndex],
      'tests': tests,
    };
    return _sectionResponse(
      _labSections[sectionIndex],
      message: 'Lab test updated successfully',
    );
  }

  BaseModel<ClinicServiceSection> _sectionResponse(
    Map<String, dynamic> section, {
    String status = 'success',
    required String message,
  }) {
    return BaseModel.fromJson(
      {
        'status': status,
        'message': message,
        'data': section,
        'meta': <String, dynamic>{},
      },
      (json) =>
          ClinicServiceSection.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
