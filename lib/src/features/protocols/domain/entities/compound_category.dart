/// High-level compound categories supported by the app.
enum CompoundCategory {
  /// GLP-1 style compounds.
  glp1,

  /// General peptide compounds.
  peptide,

  /// Compounds that do not fit other categories.
  other,
}

/// Storage and display helpers for [CompoundCategory].
extension CompoundCategoryX on CompoundCategory {
  /// Value persisted in local storage.
  String get storageValue => switch (this) {
    CompoundCategory.glp1 => 'glp1',
    CompoundCategory.peptide => 'peptide',
    CompoundCategory.other => 'other',
  };

  /// User-facing label for the category.
  String get label => switch (this) {
    CompoundCategory.glp1 => 'GLP-1',
    CompoundCategory.peptide => 'Peptide',
    CompoundCategory.other => 'Other',
  };
}

/// Parses a stored category value into [CompoundCategory].
CompoundCategory compoundCategoryFromStorage(String value) {
  return CompoundCategory.values.firstWhere(
    (category) => category.storageValue == value,
    orElse: () => CompoundCategory.other,
  );
}
