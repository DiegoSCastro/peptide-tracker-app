import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/entities/peptide.dart';

/// Contract for loading peptide content.
// ignore: one_member_abstracts
abstract interface class PeptidesRepository {
  /// Returns the featured peptide cards for the home screen.
  TaskEither<AppFailure, List<Peptide>> getFeaturedPeptides();
}
