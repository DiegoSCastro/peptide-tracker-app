import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_tracker_app/src/core/reminders/protocol_reminder_schedule.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

void main() {
  group('ProtocolReminderSchedule', () {
    test(
      'marks an every-n-days protocol as due today when cadence matches',
      () {
        final protocol = _protocol(
          startDate: DateTime.utc(2026, 6),
          intervalDays: 7,
        );

        final isDue = ProtocolReminderSchedule.isDueOnDate(
          protocol,
          DateTime(2026, 6, 8, 10),
        );
        final scheduledAt = ProtocolReminderSchedule.scheduledDateTimeOn(
          protocol,
          DateTime(2026, 6, 8, 10),
        );

        expect(isDue, isTrue);
        expect(scheduledAt, DateTime(2026, 6, 8, 9));
      },
    );

    test('finds the next reminder after the current time', () {
      final protocol = _protocol(
        startDate: DateTime.utc(2026, 6),
        intervalDays: 7,
      );

      final nextReminder = ProtocolReminderSchedule.nextReminderAfter(
        protocol,
        DateTime(2026, 6, 8, 10),
      );

      expect(nextReminder, DateTime(2026, 6, 15, 9));
    });

    test('keeps UTC start dates due on the same UTC calendar day', () {
      final protocol = _protocol(
        startDate: DateTime.utc(2026, 6, 8),
        intervalDays: 7,
      );

      final isDue = ProtocolReminderSchedule.isDueOnDate(
        protocol,
        DateTime.utc(2026, 6, 8, 9),
      );
      final scheduledAt = ProtocolReminderSchedule.scheduledDateTimeOn(
        protocol,
        DateTime.utc(2026, 6, 8, 9),
      );
      final nextReminder = ProtocolReminderSchedule.nextReminderAfter(
        protocol,
        DateTime.utc(2026, 6, 8, 9),
      );

      expect(isDue, isTrue);
      expect(scheduledAt, DateTime.utc(2026, 6, 8, 9));
      expect(nextReminder, DateTime.utc(2026, 6, 8, 9));
    });

    test('returns no reminder for manual-only routines', () {
      final protocol = _protocol(
        scheduleType: ProtocolScheduleType.manualOnly,
        reminderMinutesAfterMidnight: null,
      );

      expect(
        ProtocolReminderSchedule.isDueOnDate(
          protocol,
          DateTime(2026, 6, 8, 10),
        ),
        isFalse,
      );
      expect(
        ProtocolReminderSchedule.nextReminderAfter(
          protocol,
          DateTime(2026, 6, 8, 10),
        ),
        isNull,
      );
    });
  });
}

Protocol _protocol({
  DateTime? startDate,
  int? intervalDays,
  ProtocolScheduleType scheduleType = ProtocolScheduleType.everyNDays,
  int? reminderMinutesAfterMidnight = 9 * 60,
}) {
  final now = DateTime.utc(2026, 6, 5);
  return Protocol(
    id: 'pro-1',
    compoundId: 'cmp-1',
    name: 'Morning routine',
    plannedAmount: 0.25,
    unitLabel: 'mg',
    scheduleType: scheduleType,
    intervalDays: intervalDays,
    reminderMinutesAfterMidnight: reminderMinutesAfterMidnight,
    startDate: startDate ?? DateTime.utc(2026, 6),
    isActive: true,
    notes: 'Weekly tracker',
    createdAt: now,
    updatedAt: now,
  );
}
