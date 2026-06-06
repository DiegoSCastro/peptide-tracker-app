import 'package:equatable/equatable.dart';

/// An attributed reference for library content.
class CompoundSource extends Equatable {
  /// Creates a source citation.
  const CompoundSource({required this.title, this.reference = ''});

  /// Human-readable source title.
  final String title;

  /// Optional identifier (PubMed ID, StatPearls NBK id, etc.).
  final String reference;

  @override
  List<Object> get props => [title, reference];
}
