import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';

/// A persisted dose log entry.
class LogEntry extends Equatable {
  /// Creates a log entry.
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

  /// Unique log entry identifier.
  final String id;

  /// Identifier of the linked protocol.
  final String protocolId;

  /// Identifier of the linked compound.
  final String compoundId;

  /// UTC timestamp when the dose was logged.
  final DateTime loggedAt;

  /// Completion status of the log entry.
  final LogEntryStatus status;

  /// Logged dose amount, if provided.
  final double? amount;

  /// Unit label shown with the logged amount.
  final String unitLabel;

  /// Optional note attached to the log entry.
  final String note;

  /// Whether the entry was created from a reminder action.
  final bool createdFromReminder;

  /// Protocol name captured at log time.
  final String protocolNameSnapshot;

  /// Compound name captured at log time.
  final String compoundNameSnapshot;

  /// UTC timestamp when the entry was created.
  final DateTime createdAt;

  /// UTC timestamp when the entry was last updated.
  final DateTime updatedAt;

  /// Human-readable amount with unit, or unit alone when amount is null.
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
