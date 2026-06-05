import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/peptides/data/datasources/peptides_local_data_source.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/entities/peptide.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/repositories/peptides_repository.dart';

/// Repository implementation backed by local seed data.
class PeptidesRepositoryImpl implements PeptidesRepository {
  /// Creates the repository implementation.
  const PeptidesRepositoryImpl({required this.dataSource});

  /// Local source used to load seed content.
  final PeptidesLocalDataSource dataSource;

  @override
  TaskEither<AppFailure, List<Peptide>> getFeaturedPeptides() {
    final peptides = dataSource
        .getFeaturedPeptides()
        .map((model) => model.toEntity())
        .toList(growable: false);

    if (peptides.isEmpty) {
      return TaskEither.left(const EmptyCatalogFailure());
    }

    return TaskEither.right(peptides);
  }
}
