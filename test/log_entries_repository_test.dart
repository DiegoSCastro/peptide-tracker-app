import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_tracker_app/src/core/database/app_database.dart';
import 'package:peptide_tracker_app/src/features/history/data/repositories/drift_log_entries_repository.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_draft.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';
import 'package:peptide_tracker_app/src/features/protocols/data/repositories/drift_protocols_repository.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';

void main() {
  group('DriftLogEntriesRepository', () {
    late AppDatabase database;
    late DriftProtocolsRepository protocolsRepository;
    late DriftLogEntriesRepository logEntriesRepository;

    setUp(() {
      database = AppDatabase.test(NativeDatabase.memory());
      protocolsRepository = DriftProtocolsRepository(database: database);
      logEntriesRepository = DriftLogEntriesRepository(database: database);
    });

    tearDown(() async {
      await database.close();
    });

    test(
      'creates history records with protocol snapshots ordered by newest first',
      () async {
        await protocolsRepository.saveDraft(_morningDraft()).run();
        final protocolId =
            (await protocolsRepository.watchAll().first).single.protocol.id;

        final firstResult = await logEntriesRepository
            .create(
              LogEntryDraft(
                protocolId: protocolId,
                loggedAt: DateTime.utc(2026, 6, 8, 9, 12),
                amount: 0.25,
                status: LogEntryStatus.done,
                note: 'Morning dose logged quickly',
                createdFromReminder: false,
              ),
            )
            .run();

        final secondResult = await logEntriesRepository
            .create(
              LogEntryDraft(
                protocolId: protocolId,
                loggedAt: DateTime.utc(2026, 6, 15, 9, 0),
                amount: 0.25,
                status: LogEntryStatus.skipped,
                note: '',
                createdFromReminder: true,
              ),
            )
            .run();

        expect(firstResult.isRight(), isTrue);
        expect(secondResult.isRight(), isTrue);

        final history = await logEntriesRepository.watchRecent().first;
        expect(history, hasLength(2));
        expect(history.first.protocolNameSnapshot, 'Morning routine');
        expect(history.first.compoundNameSnapshot, 'Semaglutide');
        expect(history.first.status, LogEntryStatus.skipped);
        expect(history.first.createdFromReminder, isTrue);
        expect(history.first.amount, 0.25);
        expect(history.last.note, 'Morning dose logged quickly');
      },
    );

    test(
      'preserves past history snapshots after a protocol is renamed',
      () async {
        await protocolsRepository.saveDraft(_morningDraft()).run();
        final existing = (await protocolsRepository.watchAll().first).single;

        await logEntriesRepository
            .create(
              LogEntryDraft(
                protocolId: existing.protocol.id,
                loggedAt: DateTime.utc(2026, 6, 8, 9),
                amount: 0.25,
                status: LogEntryStatus.done,
                note: 'Original name snapshot',
                createdFromReminder: false,
              ),
            )
            .run();

        await protocolsRepository
            .saveDraft(
              _morningDraft(
                protocolId: existing.protocol.id,
                compoundId: existing.compound.id,
                protocolName: 'Renamed routine',
                compoundName: 'Updated compound',
              ),
            )
            .run();

        final history = await logEntriesRepository.watchRecent().first;
        expect(history.single.protocolNameSnapshot, 'Morning routine');
        expect(history.single.compoundNameSnapshot, 'Semaglutide');
        expect(history.single.note, 'Original name snapshot');
      },
    );
  });
}

ProtocolEditorDraft _morningDraft({
  String? protocolId,
  String? compoundId,
  String protocolName = 'Morning routine',
  String compoundName = 'Semaglutide',
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
    isActive: true,
    notes: 'Weekly tracker',
  );
}
