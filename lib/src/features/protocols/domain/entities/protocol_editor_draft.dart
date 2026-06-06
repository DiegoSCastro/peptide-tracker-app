import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

/// Mutable form state for creating or editing a protocol.
class ProtocolEditorDraft extends Equatable {
  /// Creates a protocol editor draft.
  const ProtocolEditorDraft({
    required this.protocolName,
    required this.compoundName,
    required this.compoundCategory,
    required this.unitLabel,
    required this.plannedAmount,
    required this.scheduleType,
    required this.intervalDays,
    required this.reminderMinutesAfterMidnight,
    required this.startDate,
    required this.isActive,
    required this.notes,
    this.protocolId,
    this.compoundId,
  });

  /// Returns a draft with sensible defaults for a new routine.
  factory ProtocolEditorDraft.initial() {
    return ProtocolEditorDraft(
      protocolName: '',
      compoundName: '',
      compoundCategory: CompoundCategory.glp1,
      unitLabel: 'mg',
      plannedAmount: 0.25,
      scheduleType: ProtocolScheduleType.everyNDays,
      intervalDays: 7,
      reminderMinutesAfterMidnight: 9 * 60,
      startDate: DateTime.now().toUtc(),
      isActive: true,
      notes: '',
    );
  }

  /// Existing protocol identifier when editing.
  final String? protocolId;

  /// Existing compound identifier when editing.
  final String? compoundId;

  /// Display name of the routine.
  final String protocolName;

  /// Display name of the compound.
  final String compoundName;

  /// Category selected for the compound.
  final CompoundCategory compoundCategory;

  /// Unit label for planned doses.
  final String unitLabel;

  /// Planned dose amount, if configured.
  final double? plannedAmount;

  /// Schedule type for reminders and due-date logic.
  final ProtocolScheduleType scheduleType;

  /// Interval in days for repeating schedules.
  final int? intervalDays;

  /// Reminder offset in minutes after midnight.
  final int? reminderMinutesAfterMidnight;

  /// UTC date when the routine starts.
  final DateTime startDate;

  /// Whether the routine should be active after saving.
  final bool isActive;

  /// Optional free-form notes.
  final String notes;

  /// Returns a copy with the given fields replaced.
  ProtocolEditorDraft copyWith({
    String? protocolId,
    String? compoundId,
    String? protocolName,
    String? compoundName,
    CompoundCategory? compoundCategory,
    String? unitLabel,
    double? plannedAmount,
    ProtocolScheduleType? scheduleType,
    int? intervalDays,
    int? reminderMinutesAfterMidnight,
    DateTime? startDate,
    bool? isActive,
    String? notes,
  }) {
    return ProtocolEditorDraft(
      protocolId: protocolId ?? this.protocolId,
      compoundId: compoundId ?? this.compoundId,
      protocolName: protocolName ?? this.protocolName,
      compoundName: compoundName ?? this.compoundName,
      compoundCategory: compoundCategory ?? this.compoundCategory,
      unitLabel: unitLabel ?? this.unitLabel,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      scheduleType: scheduleType ?? this.scheduleType,
      intervalDays: intervalDays ?? this.intervalDays,
      reminderMinutesAfterMidnight:
          reminderMinutesAfterMidnight ?? this.reminderMinutesAfterMidnight,
      startDate: startDate ?? this.startDate,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
    protocolId,
    compoundId,
    protocolName,
    compoundName,
    compoundCategory,
    unitLabel,
    plannedAmount,
    scheduleType,
    intervalDays,
    reminderMinutesAfterMidnight,
    startDate,
    isActive,
    notes,
  ];
}
