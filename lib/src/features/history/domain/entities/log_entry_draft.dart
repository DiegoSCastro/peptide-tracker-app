import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';

/// Input payload for creating a new log entry.
class LogEntryDraft extends Equatable {
  /// Creates a log entry draft.
  const LogEntryDraft({
    required this.protocolId,
    required this.loggedAt,
    required this.amount,
    required this.status,
    required this.note,
    required this.createdFromReminder,
    this.unitLabel,
  });

  /// Identifier of the protocol being logged.
  final String protocolId;

  /// UTC timestamp when the dose was taken or skipped.
  final DateTime loggedAt;

  /// Logged dose amount, if provided.
  final double? amount;

  /// Completion status of the log entry.
  final LogEntryStatus status;

  /// Optional note attached to the log entry.
  final String note;

  /// Whether the entry was created from a reminder action.
  final bool createdFromReminder;

  /// Optional unit override; falls back to the protocol unit.
  final String? unitLabel;

  @override
  List<Object?> get props => [
    protocolId,
    loggedAt,
    amount,
    status,
    note,
    createdFromReminder,
    unitLabel,
  ];
}
