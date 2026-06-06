import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_draft.dart';

abstract interface class LogEntriesRepository {
  Stream<List<LogEntry>> watchRecent({int limit = 20});

  Stream<List<LogEntry>> watchByDateRange(DateTime start, DateTime end);

  Stream<List<LogEntry>> watchByProtocol(String protocolId);

  TaskEither<AppFailure, Unit> create(LogEntryDraft draft);
}
