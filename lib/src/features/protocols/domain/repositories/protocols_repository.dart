import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';

/// Persistence contract for user-defined protocols.
abstract interface class ProtocolsRepository {
  /// Watches all protocols with their linked compounds.
  Stream<List<ManagedProtocol>> watchAll();

  /// Creates or updates a protocol from [draft].
  TaskEither<AppFailure, Unit> saveDraft(ProtocolEditorDraft draft);

  /// Activates or pauses a protocol.
  TaskEither<AppFailure, Unit> setActive({
    required String protocolId,
    required bool isActive,
  });

  /// Deletes a protocol and its linked compound when unused.
  TaskEither<AppFailure, Unit> delete(String protocolId);
}
