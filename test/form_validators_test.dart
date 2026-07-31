import 'package:clinic_app/shared/form_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('form validators reject invalid values', () {
    expect(FormValidators.required('  ', 'required'), 'required');
    expect(
      FormValidators.email(
        'wrong',
        requiredMessage: 'required',
        invalidMessage: 'email',
      ),
      'email',
    );
    expect(
      FormValidators.password(
        'short',
        requiredMessage: 'required',
        shortMessage: 'short',
      ),
      'short',
    );
    expect(
      FormValidators.confirmation(
        'different',
        'password',
        requiredMessage: 'required',
        mismatchMessage: 'mismatch',
      ),
      'mismatch',
    );
  });
}
