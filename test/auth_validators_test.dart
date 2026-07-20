import 'package:clinic_app/features/auth/domain/auth_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('auth validators reject invalid signup values', () {
    expect(AuthValidators.required('  ', 'required'), 'required');
    expect(
      AuthValidators.email(
        'wrong',
        requiredMessage: 'required',
        invalidMessage: 'email',
      ),
      'email',
    );
    expect(
      AuthValidators.password(
        'short',
        requiredMessage: 'required',
        shortMessage: 'short',
      ),
      'short',
    );
    expect(
      AuthValidators.confirmation(
        'different',
        'password',
        requiredMessage: 'required',
        mismatchMessage: 'mismatch',
      ),
      'mismatch',
    );
  });
}
