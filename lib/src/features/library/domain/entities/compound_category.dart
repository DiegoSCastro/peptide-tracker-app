/// High-level grouping for library compounds.
enum CompoundCategory {
  /// GLP-1 / incretin class (e.g. semaglutide, tirzepatide).
  glp1,

  /// Tissue repair / recovery research peptides.
  recovery,

  /// GHRH / GHRP secretagogues.
  ghrhGhrp,

  /// Metabolic / weight-related research peptides.
  metabolic,

  /// Other or mixed categories.
  other,
}

/// Labels and helpers for [CompoundCategory].
extension CompoundCategoryX on CompoundCategory {
  /// User-facing label.
  String get label => switch (this) {
    CompoundCategory.glp1 => 'GLP-1',
    CompoundCategory.recovery => 'Recovery',
    CompoundCategory.ghrhGhrp => 'GHRH / GHRP',
    CompoundCategory.metabolic => 'Metabolic',
    CompoundCategory.other => 'Other',
  };

  /// Parses a JSON category slug.
  static CompoundCategory fromSlug(String slug) => switch (slug) {
    'glp1' => CompoundCategory.glp1,
    'recovery' => CompoundCategory.recovery,
    'ghrh_ghrp' => CompoundCategory.ghrhGhrp,
    'metabolic' => CompoundCategory.metabolic,
    _ => CompoundCategory.other,
  };

  /// JSON slug for this category.
  String get slug => switch (this) {
    CompoundCategory.glp1 => 'glp1',
    CompoundCategory.recovery => 'recovery',
    CompoundCategory.ghrhGhrp => 'ghrh_ghrp',
    CompoundCategory.metabolic => 'metabolic',
    CompoundCategory.other => 'other',
  };
}
