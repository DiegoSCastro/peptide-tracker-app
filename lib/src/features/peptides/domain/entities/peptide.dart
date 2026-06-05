import 'package:equatable/equatable.dart';

/// Domain entity representing a peptide card shown in the app.
class Peptide extends Equatable {
  /// Creates a peptide entity.
  const Peptide({
    required this.name,
    required this.category,
    required this.summary,
    required this.highlights,
    required this.caution,
  });

  /// Display name.
  final String name;

  /// High-level content grouping.
  final String category;

  /// Short summary for the card.
  final String summary;

  /// Key bullet points shown in the UI.
  final List<String> highlights;

  /// Safety-focused caution text.
  final String caution;

  @override
  List<Object> get props => [name, category, summary, highlights, caution];
}
