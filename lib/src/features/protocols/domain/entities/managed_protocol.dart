import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

class ManagedProtocol extends Equatable {
  const ManagedProtocol({required this.protocol, required this.compound});

  final Protocol protocol;
  final Compound compound;

  ProtocolEditorDraft toEditorDraft() {
    return ProtocolEditorDraft(
      protocolId: protocol.id,
      compoundId: compound.id,
      protocolName: protocol.name,
      compoundName: compound.name,
      compoundCategory: compound.category,
      unitLabel: protocol.unitLabel,
      plannedAmount: protocol.plannedAmount,
      scheduleType: protocol.scheduleType,
      intervalDays: protocol.intervalDays,
      reminderMinutesAfterMidnight: protocol.reminderMinutesAfterMidnight,
      startDate: protocol.startDate,
      isActive: protocol.isActive,
      notes: protocol.notes,
    );
  }

  String get scheduleSummary {
    return switch (protocol.scheduleType) {
      ProtocolScheduleType.everyNDays =>
        'Every ${protocol.intervalDays ?? 7} days',
      ProtocolScheduleType.specificWeekdays => 'Specific weekdays',
      ProtocolScheduleType.manualOnly => 'Manual only',
    };
  }

  @override
  List<Object> get props => [protocol, compound];
}
