import 'day_schedule_model.dart';

class InsuranceModel {
  const InsuranceModel({required this.id, required this.name});

  final int id;
  final String name;

  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    return InsuranceModel(id: json['id'] as int, name: json['name'] as String);
  }
}

class CompleteClinicProfileRequest {
  const CompleteClinicProfileRequest({
    required this.phone,
    required this.insuranceIds,
    required this.schedule,
    required this.logoPath,
    required this.coverPath,
  });

  final String phone;
  final List<int> insuranceIds;
  final List<DaySchedule> schedule;
  final String logoPath;
  final String coverPath;

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'insurance_ids': insuranceIds,
    'schedule': schedule.map((day) => day.toJson()).toList(),
  };
}

class CompleteProfileResponse {
  const CompleteProfileResponse({
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

  factory CompleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponse(
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
