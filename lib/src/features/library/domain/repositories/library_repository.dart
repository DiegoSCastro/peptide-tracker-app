import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_info.dart';

/// Contract for loading library compound content.
abstract interface class LibraryRepository {
  /// Returns the full compound catalog.
  TaskEither<AppFailure, List<CompoundInfo>> getAllCompounds();

  /// Returns a single compound by id, if present.
  TaskEither<AppFailure, CompoundInfo?> getCompoundById(String id);
}
