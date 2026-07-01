class DaySchedule {
  String dayKey;
  bool isDayOff;
  String startTime;
  String endTime;

  DaySchedule({
    required this.dayKey,
    this.isDayOff = false,
    this.startTime = '09:00',
    this.endTime = '17:00',
  });

  Map<String, dynamic> toJson() => {
    'day': _apiDayNames[dayKey],
    'is_active': !isDayOff,
    'from': isDayOff ? null : startTime,
    'to': isDayOff ? null : endTime,
  };

  static const _apiDayNames = {
    'sat': 'saturday',
    'sun': 'sunday',
    'mon': 'monday',
    'tue': 'tuesday',
    'wed': 'wednesday',
    'thu': 'thursday',
    'fri': 'friday',
  };
}
