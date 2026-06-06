import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/database/app_database.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_draft.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';
import 'package:peptide_tracker_app/src/features/history/domain/repositories/log_entries_repository.dart';

class DriftLogEntriesRepository implements LogEntriesRepository {
  const DriftLogEntriesRepository({required this.database});

  final AppDatabase database;

  @override
  TaskEither<AppFailure, Unit> create(LogEntryDraft draft) {
    return TaskEither.tryCatch(() async {
      await database.transaction(() async {
        final protocolRow = await (database.select(
          database.protocolsTable,
        )..where((tbl) => tbl.id.equals(draft.protocolId))).getSingleOrNull();
        if (protocolRow == null) {
          throw const StorageFailure(
            'Routine not found. Save a routine before logging.',
          );
        }

        final compoundRow =
            await (database.select(database.compoundsTable)
                  ..where((tbl) => tbl.id.equals(protocolRow.compoundId)))
                .getSingleOrNull();
        if (compoundRow == null) {
          throw const StorageFailure('Compound not found for this routine.');
        }

        final now = DateTime.now().toUtc();
        await database
            .into(database.logEntriesTable)
            .insert(
              LogEntriesTableCompanion.insert(
                id: _newId(prefix: 'log'),
                protocolId: draft.protocolId,
                compoundId: protocolRow.compoundId,
                loggedAt: draft.loggedAt.toUtc(),
                status: draft.status.storageValue,
                unitLabel: (draft.unitLabel ?? protocolRow.unitLabel).trim(),
                createdFromReminder: Value(draft.createdFromReminder),
                protocolNameSnapshot: protocolRow.name,
                compoundNameSnapshot: compoundRow.name,
                createdAt: now,
                updatedAt: now,
                amount: Value(draft.amount),
                note: Value(
                  draft.note.trim().isEmpty ? null : draft.note.trim(),
                ),
              ),
            );
      });

      return unit;
    }, _mapFailure);
  }

  @override
  Stream<List<LogEntry>> watchByDateRange(DateTime start, DateTime end) {
    final query = database.select(database.logEntriesTable)
      ..where(
        (tbl) =>
            tbl.loggedAt.isBiggerOrEqualValue(start.toUtc()) &
            tbl.loggedAt.isSmallerOrEqualValue(end.toUtc()),
      )
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.loggedAt)]);

    return query.watch().map(_mapRows);
  }

  @override
  Stream<List<LogEntry>> watchByProtocol(String protocolId) {
    final query = database.select(database.logEntriesTable)
      ..where((tbl) => tbl.protocolId.equals(protocolId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.loggedAt)]);

    return query.watch().map(_mapRows);
  }

  @override
  Stream<List<LogEntry>> watchRecent({int limit = 20}) {
    final query = database.select(database.logEntriesTable)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.loggedAt)])
      ..limit(limit);

    return query.watch().map(_mapRows);
  }

  List<LogEntry> _mapRows(List<LogEntriesTableData> rows) {
    return rows.map(_mapRow).toList(growable: false);
  }

  LogEntry _mapRow(LogEntriesTableData row) {
    return LogEntry(
      id: row.id,
      protocolId: row.protocolId,
      compoundId: row.compoundId,
      loggedAt: row.loggedAt,
      status: logEntryStatusFromStorage(row.status),
      amount: row.amount,
      unitLabel: row.unitLabel,
      note: row.note ?? '',
      createdFromReminder: row.createdFromReminder,
      protocolNameSnapshot: row.protocolNameSnapshot,
      compoundNameSnapshot: row.compoundNameSnapshot,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  AppFailure _mapFailure(Object error, StackTrace stackTrace) {
    if (error is AppFailure) {
      return error;
    }
    return const StorageFailure();
  }

  String _newId({required String prefix}) {
    final micros = DateTime.now().microsecondsSinceEpoch;
    return '$prefix-$micros';
  }
}
