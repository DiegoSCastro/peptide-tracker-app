import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

class Protocol extends Equatable {
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

  final String id;
  final String compoundId;
  final String name;
  final double? plannedAmount;
  final String unitLabel;
  final ProtocolScheduleType scheduleType;
  final int? intervalDays;
  final int? reminderMinutesAfterMidnight;
  final DateTime startDate;
  final bool isActive;
  final String notes;
  final DateTime createdAt;
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
