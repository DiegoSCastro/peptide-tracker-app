import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/entities/peptide.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/repositories/peptides_repository.dart';
import 'package:peptide_tracker_app/src/features/peptides/presentation/cubit/peptides_cubit.dart';

class _SuccessRepository implements PeptidesRepository {
  @override
  TaskEither<AppFailure, List<Peptide>> getFeaturedPeptides() {
    return TaskEither.right(
      const [
        Peptide(
          name: 'GLP-1 Overview',
          category: 'Tracking',
          summary: 'Summary',
          highlights: ['A'],
          caution: 'Educational only.',
        ),
      ],
    );
  }
}

class _FailureRepository implements PeptidesRepository {
  @override
  TaskEither<AppFailure, List<Peptide>> getFeaturedPeptides() {
    return TaskEither.left(const EmptyCatalogFailure());
  }
}

void main() {
  group('PeptidesCubit', () {
    blocTest<PeptidesCubit, PeptidesState>(
      'emits loading then success when repository returns peptides',
      build: () => PeptidesCubit(repository: _SuccessRepository()),
      act: (cubit) => cubit.load(),
      expect: () => <PeptidesState>[
        const PeptidesState(status: PeptidesStatus.loading),
        const PeptidesState(
          status: PeptidesStatus.success,
          peptides: [
            Peptide(
              name: 'GLP-1 Overview',
              category: 'Tracking',
              summary: 'Summary',
              highlights: ['A'],
              caution: 'Educational only.',
            ),
          ],
        ),
      ],
    );

    blocTest<PeptidesCubit, PeptidesState>(
      'emits loading then failure when repository returns an error',
      build: () => PeptidesCubit(repository: _FailureRepository()),
      act: (cubit) => cubit.load(),
      expect: () => <PeptidesState>[
        const PeptidesState(status: PeptidesStatus.loading),
        const PeptidesState(
          status: PeptidesStatus.failure,
          message: 'No peptides are available in the local catalog.',
        ),
      ],
    );
  });
}
