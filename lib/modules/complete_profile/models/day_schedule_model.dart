class DaySchedule {
  String dayKey; // 'sat', 'sun'...
  bool isDayOff;
  String startTime;
  String endTime;

  DaySchedule({
    required this.dayKey,
    this.isDayOff = false,
    this.startTime = "09:00 AM",
    this.endTime = "05:00 PM",
  });
}