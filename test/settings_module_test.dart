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
}
