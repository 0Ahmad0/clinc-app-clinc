import 'package:clinic_app/core/utils/app_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formats clock values as 12-hour am pm', () {
    expect(formatClockTime12('17:30'), '5:30 pm');
    expect(formatClockTime12('09:00:00'), '9:00 am');
    expect(formatClockTime12('12:00 PM'), '12:00 pm');
    expect(formatClockTime12('2026-08-01T00:05:00Z'), '3:05 am');
  });

  test('formats TimeOfDay as 12-hour am pm', () {
    expect(formatTimeOfDay12(const TimeOfDay(hour: 0, minute: 5)), '12:05 am');
    expect(formatTimeOfDay12(const TimeOfDay(hour: 12, minute: 0)), '12:00 pm');
    expect(
      formatTimeOfDay12(const TimeOfDay(hour: 23, minute: 45)),
      '11:45 pm',
    );
  });
}
