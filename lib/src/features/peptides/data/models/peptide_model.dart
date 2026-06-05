import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/entities/peptide.dart';

/// Data model for peptide catalog items.
class PeptideModel extends Equatable {
  /// Creates a peptide data model.
  const PeptideModel({
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

  /// Converts this model into a domain entity.
  Peptide toEntity() {
    return Peptide(
      name: name,
      category: category,
      summary: summary,
      highlights: highlights,
      caution: caution,
    );
  }

  @override
  List<Object> get props => [name, category, summary, highlights, caution];
}
