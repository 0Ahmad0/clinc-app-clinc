import 'package:flutter/material.dart' show TimeOfDay;
import 'package:intl/intl.dart';

String formatTimeOfDay12(TimeOfDay value) {
  final displayHour = value.hour % 12 == 0 ? 12 : value.hour % 12;
  final minute = value.minute.toString().padLeft(2, '0');
  final period = value.hour >= 12 ? 'pm' : 'am';
  return '$displayHour:$minute $period';
}

String formatClockTime12(String? value, {String fallback = '-'}) {
  final raw = value?.trim();
  if (raw == null || raw.isEmpty) return fallback;

  final parsedDateTime = DateTime.tryParse(raw);
  if (parsedDateTime != null && _looksLikeDateTime(raw)) {
    return formatDateTimeClock12(parsedDateTime.toLocal());
  }

  final normalized = raw
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll('ص', 'am')
      .replaceAll('م', 'pm')
      .toUpperCase();
  for (final pattern in const [
    'HH:mm:ss',
    'H:mm:ss',
    'HH:mm',
    'H:mm',
    'h:mm a',
    'hh:mm a',
    'h:mm:ss a',
    'hh:mm:ss a',
  ]) {
    final parsed = DateFormat(pattern).tryParseStrict(normalized);
    if (parsed != null) return formatDateTimeClock12(parsed);
  }

  return raw.replaceAll('AM', 'am').replaceAll('PM', 'pm');
}

String formatDateTimeClock12(DateTime value) {
  final formatted = DateFormat('h:mm a').format(value);
  return formatted.replaceAll('AM', 'am').replaceAll('PM', 'pm');
}

String formatDateTimeWithClock12(
  DateTime value, {
  String datePattern = 'yyyy-MM-dd',
}) {
  return '${DateFormat(datePattern).format(value)} ${formatDateTimeClock12(value)}';
}

bool _looksLikeDateTime(String value) =>
    value.contains('T') || RegExp(r'^\d{4}-\d{2}-\d{2}').hasMatch(value);
