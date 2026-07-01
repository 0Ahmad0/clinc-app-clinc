import '../models/dashboard_model.dart';
import 'dashboard_data_source.dart';

class DashboardMockDataSource implements DashboardDataSource {
  @override
  Future<DashboardResponse> getDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return DashboardResponse.fromJson({
      'status': 'success',
      'message': 'Clinic dashboard retrieved successfully',
      'data': {
        'clinic': {
          'clinic_id': 'C-001',
          'name': 'عيادات النخبة الطبية',
          'logo': 'clinics/logo1.png',
          'is_open': true,
          'today_working_hours': {'from': '09:00', 'to': '17:00'},
        },
        'stats': {
          'doctors_count': 3,
          'patients_count': 120,
          'today_appointments_count': 3,
          'daily_income': 2500,
          'currency': 'SAR',
        },
        'today_appointments': [
          {
            'appointment_id': 'A-001',
            'patient': {'name': 'أحمد محمد علي', 'image': null},
            'consultation': {'name': 'استشارة قلبية', 'icon': 'cardiology'},
            'time': '10:00',
            'status': 'confirmed',
          },
          {
            'appointment_id': 'A-002',
            'patient': {'name': 'سارة خالد عبدالله', 'image': null},
            'consultation': {'name': 'فحص أسنان', 'icon': 'dental'},
            'time': '11:30',
            'status': 'pending',
          },
          {
            'appointment_id': 'A-003',
            'patient': {'name': 'محمد يوسف حسن', 'image': null},
            'consultation': {'name': 'تحليل دم شامل', 'icon': 'lab'},
            'time': '13:00',
            'status': 'completed',
          },
        ],
      },
      'meta': {'date': '2026-07-01', 'timezone': 'Asia/Riyadh'},
    });
  }
}
