import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/entities/peptide.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/repositories/peptides_repository.dart';

part 'peptides_state.dart';

/// Cubit responsible for loading peptide content.
class PeptidesCubit extends Cubit<PeptidesState> {
  /// Creates the peptides cubit.
  PeptidesCubit({required this.repository}) : super(const PeptidesState());

  /// Repository used by the cubit.
  final PeptidesRepository repository;

  /// Loads the featured peptide list.
  Future<void> load() async {
    emit(state.copyWith(status: PeptidesStatus.loading, message: ''));

    final result = await repository.getFeaturedPeptides().run();

    result.match(
      (failure) => emit(
        state.copyWith(
          status: PeptidesStatus.failure,
          peptides: const [],
          message: failure.message,
        ),
      ),
      (peptides) => emit(
        state.copyWith(
          status: PeptidesStatus.success,
          peptides: peptides,
          message: '',
        ),
      ),
    );
  }
}
