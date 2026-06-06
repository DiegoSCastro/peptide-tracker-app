part of 'library_cubit.dart';

/// View status for the library screen.
enum LibraryStatus {
  /// No work started.
  initial,

  /// Loading catalog.
  loading,

  /// Catalog loaded.
  success,

  /// Load failed.
  failure,
}

/// State for [LibraryCubit].
class LibraryState extends Equatable {
  /// Creates library state.
  const LibraryState({
    this.status = LibraryStatus.initial,
    this.compounds = const [],
    this.searchQuery = '',
    this.selectedCategory,
    this.message = '',
  });

  /// Current status.
  final LibraryStatus status;

  /// Full catalog.
  final List<CompoundInfo> compounds;

  /// Active search string.
  final String searchQuery;

  /// Active category filter.
  final CompoundCategory? selectedCategory;

  /// Error message.
  final String message;

  /// Compounds after search + category filter.
  List<CompoundInfo> get visibleCompounds {
    return compounds
        .where((compound) {
          if (selectedCategory != null &&
              compound.category != selectedCategory) {
            return false;
          }
          return compound.matchesQuery(searchQuery);
        })
        .toList(growable: false);
  }

  /// Returns a copy with updated fields.
  LibraryState copyWith({
    LibraryStatus? status,
    List<CompoundInfo>? compounds,
    String? searchQuery,
    CompoundCategory? selectedCategory,
    bool resetCategory = false,
    String? message,
  }) {
    return LibraryState(
      status: status ?? this.status,
      compounds: compounds ?? this.compounds,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: resetCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    compounds,
    searchQuery,
    selectedCategory,
    message,
  ];
}
