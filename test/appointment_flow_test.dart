import 'package:clinc_app_clinc/app/extension/appointment_type_extensions.dart';
import 'package:clinc_app_clinc/modules/appointments/data/appointments_mock_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('appointment actions persist into subsequent list loads', () async {
    final dataSource = AppointmentsMockDataSource();

    final approved = await dataSource.updateStatus(
      id: 'A-001',
      status: AppointmentStatus.approved,
    );
    expect(approved.result?.status, AppointmentStatus.approved);

    final uploaded = await dataSource.uploadResult(
      id: 'A-004',
      filePath: '/tmp/result.pdf',
    );
    expect(uploaded.result?.resultPdfPathOrUrl, '/tmp/result.pdf');

    final approvedList = await dataSource.getAppointments(
      page: 1,
      status: AppointmentStatus.approved,
    );
    expect(approvedList.result?.list.any((item) => item.id == 'A-001'), isTrue);

    final completedList = await dataSource.getAppointments(
      page: 1,
      status: AppointmentStatus.completed,
    );
    expect(
      completedList.result?.list
          .firstWhere((item) => item.id == 'A-004')
          .hasResult,
      isTrue,
    );
  });
}
