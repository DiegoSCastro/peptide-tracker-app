import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/library/data/datasources/library_asset_data_source.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_info.dart';
import 'package:peptide_tracker_app/src/features/library/domain/repositories/library_repository.dart';

/// Repository backed by bundled JSON assets.
class LibraryRepositoryImpl implements LibraryRepository {
  /// Creates the repository.
  const LibraryRepositoryImpl({required this.dataSource});

  /// Asset loader.
  final LibraryAssetDataSource dataSource;

  @override
  TaskEither<AppFailure, List<CompoundInfo>> getAllCompounds() {
    return TaskEither.tryCatch(
      () async {
        final models = await dataSource.loadCompounds();
        if (models.isEmpty) {
          throw const EmptyCatalogFailure();
        }
        return models.map((model) => model.toEntity()).toList(growable: false);
      },
      (_, _) => const StorageFailure('Could not load library content.'),
    );
  }

  @override
  TaskEither<AppFailure, CompoundInfo?> getCompoundById(String id) {
    return getAllCompounds().map(
      (compounds) {
        for (final compound in compounds) {
          if (compound.id == id) {
            return compound;
          }
        }
        return null;
      },
    );
  }
}
