import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';

/// A compound tracked by the user.
class Compound extends Equatable {
  /// Creates a compound.
  const Compound({
    required this.id,
    required this.name,
    required this.category,
    required this.defaultUnit,
    required this.notes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Unique compound identifier.
  final String id;

  /// Display name of the compound.
  final String name;

  /// Category used for grouping and defaults.
  final CompoundCategory category;

  /// Default unit label for doses.
  final String defaultUnit;

  /// Optional free-form notes.
  final String notes;

  /// Whether the compound is archived.
  final bool isArchived;

  /// UTC timestamp when the compound was created.
  final DateTime createdAt;

  /// UTC timestamp when the compound was last updated.
  final DateTime updatedAt;

  @override
  List<Object> get props => [
    id,
    name,
    category,
    defaultUnit,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ];
}
