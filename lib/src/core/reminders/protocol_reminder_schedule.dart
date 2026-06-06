import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

class ProtocolReminderSchedule {
  const ProtocolReminderSchedule._();

  static bool isDueOnDate(Protocol protocol, DateTime date) {
    if (!protocol.isActive || !_hasReminder(protocol)) {
      return false;
    }

    final targetDay = _startOfDay(date);
    final startDay = _startOfDay(protocol.startDate);
    if (targetDay.isBefore(startDay)) {
      return false;
    }

    final intervalDays = (protocol.intervalDays ?? 1).clamp(1, 3650);

    return switch (protocol.scheduleType) {
      ProtocolScheduleType.everyNDays =>
        targetDay.difference(startDay).inDays % intervalDays == 0,
      ProtocolScheduleType.specificWeekdays =>
        targetDay.weekday == startDay.weekday,
      ProtocolScheduleType.manualOnly => false,
    };
  }

  static DateTime? scheduledDateTimeOn(Protocol protocol, DateTime date) {
    if (!isDueOnDate(protocol, date)) {
      return null;
    }

    final reminderMinutes = protocol.reminderMinutesAfterMidnight;
    if (reminderMinutes == null) {
      return null;
    }

    final day = _startOfDay(date);
    final hours = reminderMinutes ~/ 60;
    final minutes = reminderMinutes % 60;
    return _dateTimeOnDay(day, hours: hours, minutes: minutes);
  }

  static DateTime? nextReminderAfter(
    Protocol protocol,
    DateTime anchor, {
    int searchWindowDays = 365,
  }) {
    for (var offset = 0; offset <= searchWindowDays; offset++) {
      final candidateDay = _startOfDay(anchor).add(Duration(days: offset));
      final scheduledAt = scheduledDateTimeOn(protocol, candidateDay);
      if (scheduledAt == null) {
        continue;
      }
      if (!scheduledAt.isBefore(anchor)) {
        return scheduledAt;
      }
    }

    return null;
  }

  static List<DateTime> upcomingReminders(
    Protocol protocol,
    DateTime anchor, {
    int count = 8,
    int searchWindowDays = 365,
  }) {
    final reminders = <DateTime>[];
    var cursor = anchor;

    while (reminders.length < count) {
      final nextReminder = nextReminderAfter(
        protocol,
        cursor,
        searchWindowDays: searchWindowDays,
      );
      if (nextReminder == null) {
        break;
      }
      reminders.add(nextReminder);
      cursor = nextReminder.add(const Duration(minutes: 1));
    }

    return List.unmodifiable(reminders);
  }

  static bool _hasReminder(Protocol protocol) {
    return protocol.reminderMinutesAfterMidnight != null &&
        protocol.scheduleType != ProtocolScheduleType.manualOnly;
  }

  static DateTime _dateTimeOnDay(
    DateTime day, {
    int hours = 0,
    int minutes = 0,
  }) {
    return _dateTime(
      day.year,
      day.month,
      day.day,
      hours: hours,
      minutes: minutes,
      isUtc: day.isUtc,
    );
  }

  static DateTime _startOfDay(DateTime value) {
    return _dateTime(value.year, value.month, value.day, isUtc: value.isUtc);
  }

  static DateTime _dateTime(
    int year,
    int month,
    int day, {
    int hours = 0,
    int minutes = 0,
    required bool isUtc,
  }) {
    return isUtc
        ? DateTime.utc(year, month, day, hours, minutes)
        : DateTime(year, month, day, hours, minutes);
  }
}
