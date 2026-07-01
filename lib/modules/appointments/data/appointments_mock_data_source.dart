import '../../../app/data/appointment_model.dart';
import '../../../app/data/base_model.dart';
import '../../../app/extension/appointment_type_extensions.dart';
import 'appointments_data_source.dart';

class AppointmentsMockDataSource implements AppointmentsDataSource {
  static const _pageSize = 2;
  static const _delay = Duration(milliseconds: 400);

  static final List<Map<String, dynamic>> _items = [
    {
      'appointment_id': 'A-001',
      'patient_name': 'Liam Harper',
      'patient_phone': '+963999000111',
      'title': 'ECG',
      'type': 'service',
      'date_time': DateTime.now()
          .add(const Duration(hours: 2))
          .toIso8601String(),
      'status': 'pending',
    },
    {
      'appointment_id': 'A-002',
      'patient_name': 'Olivia Bennett',
      'patient_phone': '+963999000222',
      'title': 'Blood Test',
      'type': 'lab_test',
      'date_time': DateTime.now()
          .add(const Duration(hours: 5))
          .toIso8601String(),
      'status': 'approved',
    },
    {
      'appointment_id': 'A-003',
      'patient_name': 'Noah Thompson',
      'patient_phone': '+963999000333',
      'title': 'Consultation',
      'type': 'consultation',
      'date_time': DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
      'status': 'completed',
      'result_file': null,
    },
    {
      'appointment_id': 'A-004',
      'patient_name': 'Sarah Connor',
      'patient_phone': '+963999000444',
      'title': 'Vitamin D Test',
      'type': 'lab_test',
      'date_time': DateTime.now()
          .subtract(const Duration(days: 2))
          .toIso8601String(),
      'status': 'completed',
      'result_file': null,
    },
    {
      'appointment_id': 'A-005',
      'patient_name': 'Mike Ross',
      'patient_phone': '+963999000555',
      'title': 'X-Ray',
      'type': 'service',
      'date_time': DateTime.now()
          .add(const Duration(days: 1, hours: 1))
          .toIso8601String(),
      'status': 'rejected',
      'reject_reason': 'clinic_closed',
      'reject_note': 'Clinic is closed for maintenance.',
    },
  ];

  @override
  Future<BaseModel<BaseModels<AppointmentModel>>> getAppointments({
    required int page,
    String? search,
    AppointmentStatus? status,
  }) async {
    await Future<void>.delayed(_delay);
    final query = search?.trim().toLowerCase() ?? '';
    final filtered = _items.where((item) {
      final matchesStatus = status == null || item['status'] == status.name;
      final matchesSearch =
          query.isEmpty ||
          item['patient_name'].toString().toLowerCase().contains(query) ||
          item['title'].toString().toLowerCase().contains(query) ||
          item['appointment_id'].toString().toLowerCase().contains(query);
      return matchesStatus && matchesSearch;
    }).toList();
    final start = (page - 1) * _pageSize;
    final pageItems = start >= filtered.length
        ? <Map<String, dynamic>>[]
        : filtered.sublist(
            start,
            (start + _pageSize).clamp(0, filtered.length),
          );
    final to = (start + pageItems.length).clamp(0, filtered.length);
    return BaseModel.fromJson(
      {
        'status': 'success',
        'message': 'Appointments retrieved successfully',
        'data': pageItems,
        'meta': {
          'current_page': page,
          'from': pageItems.isEmpty ? null : start + 1,
          'to': pageItems.isEmpty ? null : to,
          'per_page': _pageSize,
          'total': filtered.length,
        },
      },
      (json) => BaseModels.fromJson(
        json,
        (item) =>
            AppointmentModel.fromJson(Map<String, dynamic>.from(item as Map)),
      ),
    );
  }

  @override
  Future<BaseModel<AppointmentModel>> updateStatus({
    required String id,
    required AppointmentStatus status,
    String? rejectReason,
    String? rejectNote,
  }) async {
    await Future<void>.delayed(_delay);
    final index = _items.indexWhere((item) => item['appointment_id'] == id);
    if (index == -1) return _notFound();
    _items[index] = {
      ..._items[index],
      'status': status.name,
      'reject_reason': rejectReason,
      'reject_note': rejectNote,
    };
    return _itemResponse(_items[index], 'Appointment status updated');
  }

  @override
  Future<BaseModel<AppointmentModel>> uploadResult({
    required String id,
    required String filePath,
  }) async {
    await Future<void>.delayed(_delay);
    final index = _items.indexWhere((item) => item['appointment_id'] == id);
    if (index == -1) return _notFound();
    _items[index] = {..._items[index], 'result_file': filePath};
    return _itemResponse(_items[index], 'Lab result uploaded successfully');
  }

  BaseModel<AppointmentModel> _itemResponse(
    Map<String, dynamic> item,
    String message,
  ) {
    return BaseModel.fromJson(
      {'status': 'success', 'message': message, 'data': item, 'meta': null},
      (json) =>
          AppointmentModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  BaseModel<AppointmentModel> _notFound() {
    return BaseModel.fromJson(
      {
        'status': 'error',
        'message': 'Appointment not found',
        'data': null,
        'error': null,
      },
      (json) =>
          AppointmentModel.fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }
}
