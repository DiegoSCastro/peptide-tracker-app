import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';

abstract interface class ProtocolsRepository {
  Stream<List<ManagedProtocol>> watchAll();

  TaskEither<AppFailure, Unit> saveDraft(ProtocolEditorDraft draft);

  TaskEither<AppFailure, Unit> setActive({
    required String protocolId,
    required bool isActive,
  });

  TaskEither<AppFailure, Unit> delete(String protocolId);
}
