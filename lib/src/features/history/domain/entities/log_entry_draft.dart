import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';

class LogEntryDraft extends Equatable {
  const LogEntryDraft({
    required this.protocolId,
    required this.loggedAt,
    required this.amount,
    required this.status,
    required this.note,
    required this.createdFromReminder,
    this.unitLabel,
  });

  final String protocolId;
  final DateTime loggedAt;
  final double? amount;
  final LogEntryStatus status;
  final String note;
  final bool createdFromReminder;
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
