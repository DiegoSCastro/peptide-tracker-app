/// Pure, dependency-free consistency helpers for the Today screen.
///
/// These reward the *act of logging* — never a health outcome. No persistence
/// is involved; values are derived on the fly from existing log timestamps.
library;

/// Returns the current logging streak: the number of consecutive days, ending
/// today (or yesterday), on which at least one entry was logged.
///
/// [loggedDays] may contain any `DateTime`s (local); only the date part is
/// considered. [today] defaults to `DateTime.now()` and is injectable for
/// testing.
int currentStreak(Iterable<DateTime> loggedDays, {DateTime? today}) {
  final reference = _dateOnly(today ?? DateTime.now());
  final days = loggedDays.map(_dateOnly).toSet();
  if (days.isEmpty) return 0;

  // The streak may end today or yesterday (a grace day so it doesn't reset
  // before the user logs today).
  var cursor = reference;
  if (!days.contains(cursor)) {
    cursor = cursor.subtract(const Duration(days: 1));
    if (!days.contains(cursor)) return 0;
  }

  var streak = 0;
  while (days.contains(cursor)) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
}

DateTime _dateOnly(DateTime value) {
  final local = value.toLocal();
  return DateTime(local.year, local.month, local.day);
}
