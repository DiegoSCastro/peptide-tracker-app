import 'package:peptide_tracker_app/src/core/notifications/notification_gateway.dart';
import 'package:peptide_tracker_app/src/core/reminders/protocol_reminder_schedule.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';

/// Syncs local notifications with upcoming protocol reminders.
class ProtocolReminderScheduler {
  /// Creates a scheduler with the given gateway and slot count.
  const ProtocolReminderScheduler({
    required this.gateway,
    this.slotsPerProtocol = 8,
  });

  /// Gateway used to schedule and cancel notifications.
  final NotificationGateway gateway;

  /// Number of reminder slots reserved per protocol.
  final int slotsPerProtocol;

  /// Schedules upcoming reminders and clears stale slots.
  Future<void> syncProtocols(
    Iterable<Protocol> protocols, {
    DateTime? now,
  }) async {
    final anchor = now ?? DateTime.now();

    for (final protocol in protocols) {
      if (!protocol.isActive) {
        await _clearReservedSlots(protocol.id);
        continue;
      }

      final reminders = ProtocolReminderSchedule.upcomingReminders(
        protocol,
        anchor,
        count: slotsPerProtocol,
      );

      for (var index = 0; index < reminders.length; index++) {
        await gateway.schedule(
          ScheduledNotification(
            id: _notificationId(protocol.id, index),
            title: 'Routine reminder',
            body: "It's time for your scheduled routine: ${protocol.name}.",
            scheduledAt: reminders[index],
            payload: protocol.id,
          ),
        );
      }

      for (var index = reminders.length; index < slotsPerProtocol; index++) {
        await gateway.cancel(_notificationId(protocol.id, index));
      }
    }
  }

  Future<void> _clearReservedSlots(String protocolId) async {
    for (var index = 0; index < slotsPerProtocol; index++) {
      await gateway.cancel(_notificationId(protocolId, index));
    }
  }

  int _notificationId(String protocolId, int slotIndex) {
    var hash = 2166136261;
    for (final codeUnit in protocolId.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 16777619) & 0x7fffffff;
    }
    return (hash % 1000000) * 10 + slotIndex;
  }
}
