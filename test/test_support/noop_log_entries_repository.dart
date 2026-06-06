import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_draft.dart';
import 'package:peptide_tracker_app/src/features/history/domain/repositories/log_entries_repository.dart';

class NoopLogEntriesRepository implements LogEntriesRepository {
  const NoopLogEntriesRepository();

  @override
  TaskEither<AppFailure, Unit> create(LogEntryDraft draft) {
    return TaskEither.right(unit);
  }

  @override
  Stream<List<LogEntry>> watchByDateRange(DateTime start, DateTime end) {
    return Stream.value(const <LogEntry>[]);
  }

  @override
  Stream<List<LogEntry>> watchByProtocol(String protocolId) {
    return Stream.value(const <LogEntry>[]);
  }

  @override
  Stream<List<LogEntry>> watchRecent({int limit = 20}) {
    return Stream.value(const <LogEntry>[]);
  }
}
