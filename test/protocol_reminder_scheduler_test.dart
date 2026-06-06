import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_tracker_app/src/core/notifications/notification_gateway.dart';
import 'package:peptide_tracker_app/src/core/notifications/protocol_reminder_scheduler.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

void main() {
  group('ProtocolReminderScheduler', () {
    test('schedules upcoming local reminders for active routines', () async {
      final gateway = _FakeNotificationGateway();
      final scheduler = ProtocolReminderScheduler(gateway: gateway);

      await scheduler.syncProtocols([
        _protocol(startDate: DateTime.utc(2026, 6, 1)),
      ], now: DateTime(2026, 6, 8, 8));

      expect(gateway.scheduled, hasLength(8));
      expect(gateway.scheduled.first.title, 'Routine reminder');
      expect(
        gateway.scheduled.first.body,
        "It's time for your scheduled routine: Morning routine.",
      );
      expect(gateway.scheduled.first.scheduledAt, DateTime(2026, 6, 8, 9));
    });

    test(
      'cancels all reserved slots when a routine becomes inactive',
      () async {
        final gateway = _FakeNotificationGateway();
        final scheduler = ProtocolReminderScheduler(gateway: gateway);

        await scheduler.syncProtocols([
          _protocol(startDate: DateTime.utc(2026, 6, 1)),
        ], now: DateTime(2026, 6, 8, 8));
        await scheduler.syncProtocols([
          _protocol(
            startDate: DateTime.utc(2026, 6, 1),
            isActive: false,
          ),
        ], now: DateTime(2026, 6, 8, 8));

        expect(gateway.cancelled.length, 8);
      },
    );
  });
}

class _FakeNotificationGateway implements NotificationGateway {
  final scheduled = <ScheduledNotification>[];
  final cancelled = <int>[];

  @override
  Future<void> cancel(int id) async {
    cancelled.add(id);
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> schedule(ScheduledNotification notification) async {
    scheduled.add(notification);
  }
}

Protocol _protocol({
  required DateTime startDate,
  bool isActive = true,
}) {
  final now = DateTime.utc(2026, 6, 5);
  return Protocol(
    id: 'pro-1',
    compoundId: 'cmp-1',
    name: 'Morning routine',
    plannedAmount: 0.25,
    unitLabel: 'mg',
    scheduleType: ProtocolScheduleType.everyNDays,
    intervalDays: 7,
    reminderMinutesAfterMidnight: 9 * 60,
    startDate: startDate,
    isActive: isActive,
    notes: 'Weekly tracker',
    createdAt: now,
    updatedAt: now,
  );
}
