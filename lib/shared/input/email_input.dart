import 'package:flutter/services.dart';

String normalizeEmailInput(String value) => value.trim().toLowerCase();

class EmailInputFormatter extends TextInputFormatter {
  const EmailInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final normalized = newValue.text.trim().toLowerCase();
    return TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(
        offset: normalized.length.clamp(0, normalized.length),
      ),
      composing: TextRange.empty,
    );
  }
}
