import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';

class Compound extends Equatable {
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

  final String id;
  final String name;
  final CompoundCategory category;
  final String defaultUnit;
  final String notes;
  final bool isArchived;
  final DateTime createdAt;
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
