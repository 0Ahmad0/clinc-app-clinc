import 'package:clinc_app_clinc/app/data/profile_model.dart';
import 'package:clinc_app_clinc/modules/settings/data/settings_mock_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'change password mock handles success and invalid current password',
    () async {
      final dataSource = SettingsMockDataSource();

      final success = await dataSource.changePassword(
        currentPassword: 'password',
        newPassword: 'new-password',
        passwordConfirmation: 'new-password',
      );
      expect(success.status, 'success');

      final failure = await dataSource.changePassword(
        currentPassword: 'wrong-password',
        newPassword: 'new-password',
        passwordConfirmation: 'new-password',
      );
      expect(failure.status, 'error');
    },
  );

  test('profile changes remain pending for admin approval', () async {
    final dataSource = SettingsMockDataSource();
    final original = ProfileModel.mock;
    final response = await dataSource.submitProfileUpdate(
      original.copyWith(
        clinicName: 'Updated Clinic',
        cover: '/tmp/cover.png',
        googleMapsUrl: 'https://maps.google.com/?q=1,2',
        latitude: 1,
        longitude: 2,
      ),
    );

    expect(response.status, 'success');
    expect(response.result?.updateStatus, 'pending');
    expect(response.result?.licenseNumber, original.licenseNumber);
    expect(response.result?.latitude, 1);
    expect(response.result?.longitude, 2);
    expect(dataSource.pendingProfileUpdate?.clinicName, 'Updated Clinic');
  });

  test(
    'support report keeps subject, description, and image attachments',
    () async {
      final dataSource = SettingsMockDataSource();
      final response = await dataSource.submitSupportRequest(
        subject: 'Appointment Issue',
        description: 'The appointment status did not update.',
        imagePaths: const ['/tmp/one.png', '/tmp/two.png'],
      );

      expect(response.status, 'success');
      expect(response.result?.status, 'pending');
      expect(response.result?.subject, 'Appointment Issue');
      expect(response.result?.imagePaths.length, 2);
    },
  );
}
