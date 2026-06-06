import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';

class LogEntry extends Equatable {
  const LogEntry({
    required this.id,
    required this.protocolId,
    required this.compoundId,
    required this.loggedAt,
    required this.status,
    required this.amount,
    required this.unitLabel,
    required this.note,
    required this.createdFromReminder,
    required this.protocolNameSnapshot,
    required this.compoundNameSnapshot,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String protocolId;
  final String compoundId;
  final DateTime loggedAt;
  final LogEntryStatus status;
  final double? amount;
  final String unitLabel;
  final String note;
  final bool createdFromReminder;
  final String protocolNameSnapshot;
  final String compoundNameSnapshot;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get amountLabel {
    final amountValue = amount;
    if (amountValue == null) {
      return unitLabel;
    }

    final normalized = amountValue == amountValue.roundToDouble()
        ? amountValue.toStringAsFixed(0)
        : amountValue.toString();
    return '$normalized $unitLabel';
  }

  @override
  List<Object?> get props => [
    id,
    protocolId,
    compoundId,
    loggedAt,
    status,
    amount,
    unitLabel,
    note,
    createdFromReminder,
    protocolNameSnapshot,
    compoundNameSnapshot,
    createdAt,
    updatedAt,
  ];
}
