import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

class ProtocolEditorDraft extends Equatable {
  const ProtocolEditorDraft({
    this.protocolId,
    this.compoundId,
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
  });

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

  final String? protocolId;
  final String? compoundId;
  final String protocolName;
  final String compoundName;
  final CompoundCategory compoundCategory;
  final String unitLabel;
  final double? plannedAmount;
  final ProtocolScheduleType scheduleType;
  final int? intervalDays;
  final int? reminderMinutesAfterMidnight;
  final DateTime startDate;
  final bool isActive;
  final String notes;

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
