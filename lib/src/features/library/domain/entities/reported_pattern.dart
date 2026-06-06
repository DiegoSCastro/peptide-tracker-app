import 'package:equatable/equatable.dart';

/// A dose or schedule pattern attributed to literature, labeling, or community
/// reports — never presented as an app-endorsed recommendation.
class ReportedPattern extends Equatable {
  /// Creates a reported pattern entry.
  const ReportedPattern({
    required this.context,
    required this.amountDescription,
    required this.frequency,
    this.notes = '',
  });

  /// Where this pattern is reported (e.g. FDA label, preclinical, community).
  final String context;

  /// Amount range or titration description (e.g. "250–500 mcg").
  final String amountDescription;

  /// How often it appears in that source context.
  final String frequency;

  /// Optional nuance or titration note.
  final String notes;

  @override
  List<Object> get props => [context, amountDescription, frequency, notes];
}
