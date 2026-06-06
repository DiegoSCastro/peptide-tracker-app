import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

/// A protocol paired with its linked compound.
class ManagedProtocol extends Equatable {
  /// Creates a managed protocol.
  const ManagedProtocol({required this.protocol, required this.compound});

  /// The persisted protocol.
  final Protocol protocol;

  /// The compound linked to the protocol.
  final Compound compound;

  /// Converts the managed protocol into an editor draft.
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

  /// Short summary of the protocol schedule for list views.
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
