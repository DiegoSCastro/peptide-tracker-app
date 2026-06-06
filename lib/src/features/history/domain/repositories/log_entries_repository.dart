import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_draft.dart';

/// Persistence contract for dose log entries.
abstract interface class LogEntriesRepository {
  /// Watches the most recent log entries.
  Stream<List<LogEntry>> watchRecent({int limit = 20});

  /// Watches log entries within the inclusive [start, end] range.
  Stream<List<LogEntry>> watchByDateRange(DateTime start, DateTime end);

  /// Watches log entries for a single protocol.
  Stream<List<LogEntry>> watchByProtocol(String protocolId);

  /// Persists a new log entry from [draft].
  TaskEither<AppFailure, Unit> create(LogEntryDraft draft);
}
