import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CompoundsTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get category => text()();

  TextColumn get defaultUnit => text()();

  TextColumn get notes => text().nullable()();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ProtocolsTable extends Table {
  TextColumn get id => text()();

  TextColumn get compoundId => text().references(CompoundsTable, #id)();

  TextColumn get name => text()();

  RealColumn get plannedAmount => real().nullable()();

  TextColumn get unitLabel => text()();

  TextColumn get scheduleType => text()();

  IntColumn get intervalDays => integer().nullable()();

  IntColumn get reminderMinutesAfterMidnight => integer().nullable()();

  DateTimeColumn get startDate => dateTime()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LogEntriesTable extends Table {
  TextColumn get id => text()();

  TextColumn get protocolId => text().references(ProtocolsTable, #id)();

  TextColumn get compoundId => text().references(CompoundsTable, #id)();

  DateTimeColumn get loggedAt => dateTime()();

  TextColumn get status => text()();

  RealColumn get amount => real().nullable()();

  TextColumn get unitLabel => text()();

  TextColumn get note => text().nullable()();

  BoolColumn get createdFromReminder =>
      boolean().withDefault(const Constant(false))();

  TextColumn get protocolNameSnapshot => text()();

  TextColumn get compoundNameSnapshot => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [CompoundsTable, ProtocolsTable, LogEntriesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.test(QueryExecutor executor) : super(executor);

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
