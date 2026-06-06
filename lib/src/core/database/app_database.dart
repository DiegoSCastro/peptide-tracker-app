import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Drift table for locally stored compounds.
class CompoundsTable extends Table {
  /// Unique compound identifier.
  TextColumn get id => text()();

  /// Display name of the compound.
  TextColumn get name => text()();

  /// Category label stored as text.
  TextColumn get category => text()();

  /// Default dosing unit for the compound.
  TextColumn get defaultUnit => text()();

  /// Optional free-form notes.
  TextColumn get notes => text().nullable()();

  /// Whether the compound is archived.
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  /// UTC timestamp when the row was created.
  DateTimeColumn get createdAt => dateTime()();

  /// UTC timestamp when the row was last updated.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Drift table for user-defined dosing routines.
class ProtocolsTable extends Table {
  /// Unique protocol identifier.
  TextColumn get id => text()();

  /// Foreign key to the linked compound.
  TextColumn get compoundId => text().references(CompoundsTable, #id)();

  /// Display name of the routine.
  TextColumn get name => text()();

  /// Planned dose amount, if configured.
  RealColumn get plannedAmount => real().nullable()();

  /// Unit label shown with the planned amount.
  TextColumn get unitLabel => text()();

  /// Schedule type stored as text.
  TextColumn get scheduleType => text()();

  /// Interval in days for repeating schedules.
  IntColumn get intervalDays => integer().nullable()();

  /// Reminder offset in minutes after midnight.
  IntColumn get reminderMinutesAfterMidnight => integer().nullable()();

  /// UTC date when the routine starts.
  DateTimeColumn get startDate => dateTime()();

  /// Whether the routine is currently active.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Optional free-form notes.
  TextColumn get notes => text().nullable()();

  /// UTC timestamp when the row was created.
  DateTimeColumn get createdAt => dateTime()();

  /// UTC timestamp when the row was last updated.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Drift table for saved dose log entries.
class LogEntriesTable extends Table {
  /// Unique log entry identifier.
  TextColumn get id => text()();

  /// Foreign key to the linked protocol.
  TextColumn get protocolId => text().references(ProtocolsTable, #id)();

  /// Foreign key to the linked compound.
  TextColumn get compoundId => text().references(CompoundsTable, #id)();

  /// UTC timestamp when the dose was logged.
  DateTimeColumn get loggedAt => dateTime()();

  /// Completion status stored as text.
  TextColumn get status => text()();

  /// Logged dose amount, if provided.
  RealColumn get amount => real().nullable()();

  /// Unit label shown with the logged amount.
  TextColumn get unitLabel => text()();

  /// Optional note attached to the log entry.
  TextColumn get note => text().nullable()();

  /// Whether the entry was created from a reminder action.
  BoolColumn get createdFromReminder =>
      boolean().withDefault(const Constant(false))();

  /// Protocol name captured at log time.
  TextColumn get protocolNameSnapshot => text()();

  /// Compound name captured at log time.
  TextColumn get compoundNameSnapshot => text()();

  /// UTC timestamp when the row was created.
  DateTimeColumn get createdAt => dateTime()();

  /// UTC timestamp when the row was last updated.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Local SQLite database for compounds, routines, and logs.
@DriftDatabase(tables: [CompoundsTable, ProtocolsTable, LogEntriesTable])
class AppDatabase extends _$AppDatabase {
  /// Opens the production database or uses the provided executor.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Opens an in-memory or custom executor for tests.
  AppDatabase.test(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(logEntriesTable);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final file = File(
      p.join(documentsDirectory.path, 'peptide_tracker.sqlite'),
    );

    return NativeDatabase.createInBackground(file);
  });
}
