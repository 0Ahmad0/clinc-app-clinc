/// Client-side validation shared by every form in the app. Messages are passed
/// in so callers stay responsible for localization.
class FormValidators {
  const FormValidators._();

  /// Shortest password we accept anywhere in the app.
  static const minPasswordLength = 8;

  static String? required(String? value, String message) =>
      value == null || value.trim().isEmpty ? message : null;

  static String? email(
    String? value, {
    required String requiredMessage,
    required String invalidMessage,
  }) {
    final requiredError = required(value, requiredMessage);
    if (requiredError != null) return requiredError;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!.trim())
        ? null
        : invalidMessage;
  }

  static String? password(
    String? value, {
    required String requiredMessage,
    required String shortMessage,
  }) {
    final requiredError = required(value, requiredMessage);
    if (requiredError != null) return requiredError;
    return value!.length < minPasswordLength ? shortMessage : null;
  }

  static String? confirmation(
    String? value,
    String password, {
    required String requiredMessage,
    required String mismatchMessage,
  }) {
    final requiredError = required(value, requiredMessage);
    if (requiredError != null) return requiredError;
    return value == password ? null : mismatchMessage;
  }
}
