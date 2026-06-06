import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_info.dart';
import 'package:peptide_tracker_app/src/features/library/domain/repositories/library_repository.dart';

part 'library_state.dart';

/// Cubit for the Library tab: load, search, and category filter.
class LibraryCubit extends Cubit<LibraryState> {
  /// Creates the library cubit.
  LibraryCubit({required this.repository}) : super(const LibraryState());

  /// Repository for compound content.
  final LibraryRepository repository;

  /// Loads the bundled catalog.
  Future<void> load() async {
    emit(state.copyWith(status: LibraryStatus.loading, message: ''));

    final result = await repository.getAllCompounds().run();

    result.match(
      (failure) => emit(
        state.copyWith(
          status: LibraryStatus.failure,
          compounds: const [],
          message: failure.message,
        ),
      ),
      (compounds) => emit(
        state.copyWith(
          status: LibraryStatus.success,
          compounds: compounds,
          message: '',
        ),
      ),
    );
  }

  /// Updates the search query.
  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Sets the active category filter (`null` = all).
  void setCategory(CompoundCategory? category) {
    if (category == null) {
      emit(state.copyWith(resetCategory: true));
      return;
    }
    emit(state.copyWith(selectedCategory: category));
  }

  /// Clears search and category filters.
  void clearFilters() {
    emit(state.copyWith(searchQuery: '', resetCategory: true));
  }
}
