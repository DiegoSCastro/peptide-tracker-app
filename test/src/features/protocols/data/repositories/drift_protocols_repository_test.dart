import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_tracker_app/src/core/database/app_database.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/protocols/data/repositories/drift_protocols_repository.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

void main() {
  group('DriftProtocolsRepository', () {
    late AppDatabase database;
    late DriftProtocolsRepository repository;

    setUp(() {
      database = AppDatabase.test(NativeDatabase.memory());
      repository = DriftProtocolsRepository(database: database);
    });

    tearDown(() async {
      await database.close();
    });

    test('saves the first active protocol with its compound', () async {
      final result = await repository.saveDraft(_morningDraft()).run();

      expect(result.isRight(), isTrue);

      final items = await repository.watchAll().first;
      expect(items, hasLength(1));
      expect(items.single.protocol.name, 'Morning routine');
      expect(items.single.compound.name, 'Semaglutide');
      expect(items.single.protocol.isActive, isTrue);
      expect(items.single.protocol.intervalDays, 7);
    });

    test('rejects a second active protocol on the free tier', () async {
      await repository.saveDraft(_morningDraft()).run();

      final result = await repository
          .saveDraft(
            _morningDraft(
              protocolName: 'Evening routine',
              compoundName: 'Tirzepatide',
            ),
          )
          .run();

      expect(result.isLeft(), isTrue);
      final failure = result.swap().getOrElse(
        (_) => throw StateError('missing'),
      );
      expect(failure, isA<ProtocolLimitReachedFailure>());
    });

    test(
      'updates and deletes an existing protocol without leaving stale data',
      () async {
        await repository.saveDraft(_morningDraft()).run();
        final existing = (await repository.watchAll().first).single;

        final update = await repository
            .saveDraft(
              _morningDraft(
                protocolId: existing.protocol.id,
                compoundId: existing.compound.id,
                protocolName: 'Paused routine',
                compoundName: 'Compound X',
                isActive: false,
                notes: 'Updated in edit flow',
              ),
            )
            .run();

        expect(update.isRight(), isTrue);

        final updated = (await repository.watchAll().first).single;
        expect(updated.protocol.name, 'Paused routine');
        expect(updated.compound.name, 'Compound X');
        expect(updated.protocol.isActive, isFalse);
        expect(updated.protocol.notes, 'Updated in edit flow');

        final delete = await repository.delete(updated.protocol.id).run();
        expect(delete.isRight(), isTrue);
        expect(await repository.watchAll().first, isEmpty);
      },
    );
  });
}

ProtocolEditorDraft _morningDraft({
  String? protocolId,
  String? compoundId,
  String protocolName = 'Morning routine',
  String compoundName = 'Semaglutide',
  bool isActive = true,
  String notes = 'Weekly tracker',
}) {
  return ProtocolEditorDraft(
    protocolId: protocolId,
    compoundId: compoundId,
    protocolName: protocolName,
    compoundName: compoundName,
    compoundCategory: CompoundCategory.glp1,
    unitLabel: 'mg',
    plannedAmount: 0.25,
    scheduleType: ProtocolScheduleType.everyNDays,
    intervalDays: 7,
    reminderMinutesAfterMidnight: 9 * 60,
    startDate: DateTime.utc(2026, 6, 8),
    isActive: isActive,
    notes: notes,
  );
}
