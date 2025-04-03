bool isToday(DateTime date) {
  DateTime now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

bool areSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

bool isBefore(DateTime date1, DateTime date2) {
  DateTime d1 = DateTime(date1.year, date1.month, date1.day);
  DateTime d2 = DateTime(date2.year, date2.month, date2.day);
  return d1.isBefore(d2);
}

bool isAfter(DateTime date1, DateTime date2) {
  DateTime d1 = DateTime(date1.year, date1.month, date1.day);
  DateTime d2 = DateTime(date2.year, date2.month, date2.day);
  return d1.isAfter(d2);
}

bool isSameMonth(DateTime focusedDate, DateTime joiningDate) {
  return focusedDate.month == joiningDate.month &&
      focusedDate.year == joiningDate.year;
}

DateTime nextWeekday(int weekday) {
  DateTime now = DateTime.now();
  int daysUntilNext = (weekday - now.weekday) % 7;
  if (daysUntilNext <= 0) daysUntilNext += 7;
  return now.add(Duration(days: daysUntilNext));
}

class QuickSelectionDate {
  static List<Map<String, dynamic>> get quickSelectJoiningDateOptions => [
        {"label": "Today", "action": () => DateTime.now()},
        {"label": "Next Monday", "action": () => nextWeekday(DateTime.monday)},
        {
          "label": "Next Tuesday",
          "action": () => nextWeekday(DateTime.tuesday)
        },
        {
          "label": "After 1 week",
          "action": () => DateTime.now().add(const Duration(days: 7)),
        },
      ];

  static List<Map<String, dynamic>> get quickSelectionLastDateOptions => [
        {"label": "No Date", "action": () => null},
        {"label": "Today", "action": () => DateTime.now()},
      ];
}
