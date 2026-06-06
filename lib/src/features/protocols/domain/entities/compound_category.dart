enum CompoundCategory { glp1, peptide, other }

extension CompoundCategoryX on CompoundCategory {
  String get storageValue => switch (this) {
    CompoundCategory.glp1 => 'glp1',
    CompoundCategory.peptide => 'peptide',
    CompoundCategory.other => 'other',
  };

  String get label => switch (this) {
    CompoundCategory.glp1 => 'GLP-1',
    CompoundCategory.peptide => 'Peptide',
    CompoundCategory.other => 'Other',
  };
}

CompoundCategory compoundCategoryFromStorage(String value) {
  return CompoundCategory.values.firstWhere(
    (category) => category.storageValue == value,
    orElse: () => CompoundCategory.other,
  );
}
