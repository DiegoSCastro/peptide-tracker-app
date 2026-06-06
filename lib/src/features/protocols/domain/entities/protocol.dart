import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

/// A user-defined dosing routine.
class Protocol extends Equatable {
  /// Creates a protocol.
  const Protocol({
    required this.id,
    required this.compoundId,
    required this.name,
    required this.plannedAmount,
    required this.unitLabel,
    required this.scheduleType,
    required this.intervalDays,
    required this.reminderMinutesAfterMidnight,
    required this.startDate,
    required this.isActive,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Unique protocol identifier.
  final String id;

  /// Identifier of the linked compound.
  final String compoundId;

  /// Display name of the routine.
  final String name;

  /// Planned dose amount, if configured.
  final double? plannedAmount;

  /// Unit label shown with the planned amount.
  final String unitLabel;

  /// Schedule type for reminders and due-date logic.
  final ProtocolScheduleType scheduleType;

  /// Interval in days for repeating schedules.
  final int? intervalDays;

  /// Reminder offset in minutes after midnight.
  final int? reminderMinutesAfterMidnight;

  /// UTC date when the routine starts.
  final DateTime startDate;

  /// Whether the routine is currently active.
  final bool isActive;

  /// Optional free-form notes.
  final String notes;

  /// UTC timestamp when the protocol was created.
  final DateTime createdAt;

  /// UTC timestamp when the protocol was last updated.
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    id,
    compoundId,
    name,
    plannedAmount,
    unitLabel,
    scheduleType,
    intervalDays,
    reminderMinutesAfterMidnight,
    startDate,
    isActive,
    notes,
    createdAt,
    updatedAt,
  ];
}
