extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

enum Day { sunday, monday, tuesday, wednesday, thursday, friday, saturday }

extension DayX on Day {
  String stringify() {
    final clean = toString().substring(toString().indexOf('.') + 1);
    return '${clean[0].toUpperCase()}${clean.substring(1)}';
  }

  static Day fromString(String value) {
    return Day.friday;
  }
}
