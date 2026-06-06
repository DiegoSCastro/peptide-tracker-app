import 'package:equatable/equatable.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_source.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/reported_pattern.dart';

/// Full educational profile for a compound in the Library.
class CompoundInfo extends Equatable {
  /// Creates a compound info entry.
  const CompoundInfo({
    required this.id,
    required this.name,
    required this.category,
    required this.summary,
    required this.whatItIs,
    required this.mechanism,
    required this.halfLife,
    required this.typicalRoutes,
    required this.highlights,
    required this.reportedPatterns,
    required this.loggingTips,
    required this.sources,
    required this.caution,
    this.aliases = const [],
    this.tmax = '',
  });

  /// Stable identifier.
  final String id;

  /// Display name.
  final String name;

  /// Category grouping.
  final CompoundCategory category;

  /// Alternate or brand names for search.
  final List<String> aliases;

  /// One-line card summary.
  final String summary;

  /// Neutral "what it is" paragraph.
  final String whatItIs;

  /// Mechanism at a high level (informational).
  final String mechanism;

  /// Reported half-life (attributed, may vary by route).
  final String halfLife;

  /// Time to peak if known.
  final String tmax;

  /// Routes discussed in sources.
  final List<String> typicalRoutes;

  /// Key bullet points for cards/detail.
  final List<String> highlights;

  /// Attributed dose/schedule patterns (not recommendations).
  final List<ReportedPattern> reportedPatterns;

  /// Practical logging notes for the tracker.
  final List<String> loggingTips;

  /// Citations and references.
  final List<CompoundSource> sources;

  /// Compliance caution block.
  final String caution;

  /// Returns true if [query] matches name, aliases, or summary.
  bool matchesQuery(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return true;
    }
    if (name.toLowerCase().contains(normalized)) {
      return true;
    }
    if (summary.toLowerCase().contains(normalized)) {
      return true;
    }
    for (final alias in aliases) {
      if (alias.toLowerCase().contains(normalized)) {
        return true;
      }
    }
    return false;
  }

  @override
  List<Object> get props => [
    id,
    name,
    category,
    aliases,
    summary,
    whatItIs,
    mechanism,
    halfLife,
    tmax,
    typicalRoutes,
    highlights,
    reportedPatterns,
    loggingTips,
    sources,
    caution,
  ];
}
