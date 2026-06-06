import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/database/app_database.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/repositories/protocols_repository.dart';

/// Drift-backed implementation of [ProtocolsRepository].
class DriftProtocolsRepository implements ProtocolsRepository {
  /// Creates the repository with the given database.
  const DriftProtocolsRepository({required this.database});

  /// Local database used for persistence.
  final AppDatabase database;

  @override
  TaskEither<AppFailure, Unit> delete(String protocolId) {
    return TaskEither.tryCatch(() async {
      await database.transaction(() async {
        final protocolRow = await (database.select(
          database.protocolsTable,
        )..where((tbl) => tbl.id.equals(protocolId))).getSingleOrNull();
        if (protocolRow == null) {
          return;
        }

        await (database.delete(
          database.protocolsTable,
        )..where((tbl) => tbl.id.equals(protocolId))).go();

        final remainingCompoundReferences = await (database.select(
          database.protocolsTable,
        )..where((tbl) => tbl.compoundId.equals(protocolRow.compoundId))).get();

        if (remainingCompoundReferences.isEmpty) {
          await (database.delete(
            database.compoundsTable,
          )..where((tbl) => tbl.id.equals(protocolRow.compoundId))).go();
        }
      });

      return unit;
    }, _mapFailure);
  }

  @override
  TaskEither<AppFailure, Unit> saveDraft(ProtocolEditorDraft draft) {
    return TaskEither.tryCatch(() async {
      await database.transaction(() async {
        await _enforceActiveProtocolLimit(
          nextIsActive: draft.isActive,
          excludingProtocolId: draft.protocolId,
        );

        final now = DateTime.now().toUtc();
        final compoundId = draft.compoundId ?? _newId(prefix: 'cmp');
        final protocolId = draft.protocolId ?? _newId(prefix: 'pro');

        await database
            .into(database.compoundsTable)
            .insertOnConflictUpdate(
              CompoundsTableCompanion(
                id: Value(compoundId),
                name: Value(draft.compoundName.trim()),
                category: Value(draft.compoundCategory.storageValue),
                defaultUnit: Value(draft.unitLabel.trim()),
                notes: Value(
                  draft.notes.trim().isEmpty ? null : draft.notes.trim(),
                ),
                isArchived: const Value(false),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );

        final existingProtocol = draft.protocolId == null
            ? null
            : await (database.select(database.protocolsTable)
                    ..where((tbl) => tbl.id.equals(draft.protocolId!)))
                  .getSingleOrNull();

        await database
            .into(database.protocolsTable)
            .insertOnConflictUpdate(
              ProtocolsTableCompanion(
                id: Value(protocolId),
                compoundId: Value(compoundId),
                name: Value(draft.protocolName.trim()),
                plannedAmount: Value(draft.plannedAmount),
                unitLabel: Value(draft.unitLabel.trim()),
                scheduleType: Value(draft.scheduleType.storageValue),
                intervalDays: Value(draft.intervalDays),
                reminderMinutesAfterMidnight: Value(
                  draft.reminderMinutesAfterMidnight,
                ),
                startDate: Value(draft.startDate.toUtc()),
                isActive: Value(draft.isActive),
                notes: Value(
                  draft.notes.trim().isEmpty ? null : draft.notes.trim(),
                ),
                createdAt: Value(existingProtocol?.createdAt ?? now),
                updatedAt: Value(now),
              ),
            );
      });

      return unit;
    }, _mapFailure);
  }

  @override
  TaskEither<AppFailure, Unit> setActive({
    required String protocolId,
    required bool isActive,
  }) {
    return TaskEither.tryCatch(() async {
      await database.transaction(() async {
        await _enforceActiveProtocolLimit(
          nextIsActive: isActive,
          excludingProtocolId: protocolId,
        );

        await (database.update(
          database.protocolsTable,
        )..where((tbl) => tbl.id.equals(protocolId))).write(
          ProtocolsTableCompanion(
            isActive: Value(isActive),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
      });

      return unit;
    }, _mapFailure);
  }

  @override
  Stream<List<ManagedProtocol>> watchAll() {
    final query =
        database.select(database.protocolsTable).join([
          innerJoin(
            database.compoundsTable,
            database.compoundsTable.id.equalsExp(
              database.protocolsTable.compoundId,
            ),
          ),
        ])..orderBy([
          OrderingTerm.asc(database.protocolsTable.createdAt),
        ]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => ManagedProtocol(
              protocol: _mapProtocol(row.readTable(database.protocolsTable)),
              compound: _mapCompound(row.readTable(database.compoundsTable)),
            ),
          )
          .toList(growable: false),
    );
  }

  Future<void> _enforceActiveProtocolLimit({
    required bool nextIsActive,
    String? excludingProtocolId,
  }) async {
    if (!nextIsActive) {
      return;
    }

    final activeProtocols =
        await (database.select(database.protocolsTable)..where((tbl) {
              final notExcluded = excludingProtocolId == null
                  ? const Constant(true)
                  : tbl.id.isNotValue(excludingProtocolId);
              return tbl.isActive.equals(true) & notExcluded;
            }))
            .get();

    if (activeProtocols.isNotEmpty) {
      throw const ProtocolLimitReachedFailure();
    }
  }

  Compound _mapCompound(CompoundsTableData row) {
    return Compound(
      id: row.id,
      name: row.name,
      category: compoundCategoryFromStorage(row.category),
      defaultUnit: row.defaultUnit,
      notes: row.notes ?? '',
      isArchived: row.isArchived,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Protocol _mapProtocol(ProtocolsTableData row) {
    return Protocol(
      id: row.id,
      compoundId: row.compoundId,
      name: row.name,
      plannedAmount: row.plannedAmount,
      unitLabel: row.unitLabel,
      scheduleType: protocolScheduleTypeFromStorage(row.scheduleType),
      intervalDays: row.intervalDays,
      reminderMinutesAfterMidnight: row.reminderMinutesAfterMidnight,
      startDate: row.startDate,
      isActive: row.isActive,
      notes: row.notes ?? '',
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
