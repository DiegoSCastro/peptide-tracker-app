import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_info.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_source.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/reported_pattern.dart';

/// JSON model for a library compound entry.
class CompoundInfoModel {
  /// Creates the model.
  const CompoundInfoModel({
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

  /// Parses a compound from JSON.
  factory CompoundInfoModel.fromJson(Map<String, dynamic> json) {
    return CompoundInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      aliases: (json['aliases'] as List<dynamic>? ?? const [])
          .map((item) => item as String)
          .toList(growable: false),
      summary: json['summary'] as String,
      whatItIs: json['whatItIs'] as String,
      mechanism: json['mechanism'] as String,
      halfLife: json['halfLife'] as String,
      tmax: json['tmax'] as String? ?? '',
      typicalRoutes: (json['typicalRoutes'] as List<dynamic>)
          .map((item) => item as String)
          .toList(growable: false),
      highlights: (json['highlights'] as List<dynamic>)
          .map((item) => item as String)
          .toList(growable: false),
      reportedPatterns: (json['reportedPatterns'] as List<dynamic>)
          .map(
            (item) => ReportedPatternModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(growable: false),
      loggingTips: (json['loggingTips'] as List<dynamic>)
          .map((item) => item as String)
          .toList(growable: false),
      sources: (json['sources'] as List<dynamic>)
          .map(
            (item) => CompoundSourceModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(growable: false),
      caution: json['caution'] as String,
    );
  }

  /// Stable id.
  final String id;

  /// Display name.
  final String name;

  /// Category slug from JSON.
  final String category;

  /// Aliases.
  final List<String> aliases;

  /// Card summary.
  final String summary;

  /// What-it-is paragraph.
  final String whatItIs;

  /// Mechanism summary.
  final String mechanism;

  /// Half-life text.
  final String halfLife;

  /// Tmax text.
  final String tmax;

  /// Typical routes.
  final List<String> typicalRoutes;

  /// Highlights.
  final List<String> highlights;

  /// Reported patterns.
  final List<ReportedPatternModel> reportedPatterns;

  /// Logging tips.
  final List<String> loggingTips;

  /// Sources.
  final List<CompoundSourceModel> sources;

  /// Caution text.
  final String caution;

  /// Converts to domain entity.
  CompoundInfo toEntity() {
    return CompoundInfo(
      id: id,
      name: name,
      category: CompoundCategoryX.fromSlug(category),
      aliases: aliases,
      summary: summary,
      whatItIs: whatItIs,
      mechanism: mechanism,
      halfLife: halfLife,
      tmax: tmax,
      typicalRoutes: typicalRoutes,
      highlights: highlights,
      reportedPatterns: reportedPatterns
          .map((pattern) => pattern.toEntity())
          .toList(growable: false),
      loggingTips: loggingTips,
      sources: sources
          .map((source) => source.toEntity())
          .toList(growable: false),
      caution: caution,
    );
  }
}

/// JSON model for a reported pattern row.
class ReportedPatternModel {
  /// Creates the model.
  const ReportedPatternModel({
    required this.context,
    required this.amountDescription,
    required this.frequency,
    this.notes = '',
  });

  /// Parses from JSON.
  factory ReportedPatternModel.fromJson(Map<String, dynamic> json) {
    return ReportedPatternModel(
      context: json['context'] as String,
      amountDescription: json['amountDescription'] as String,
      frequency: json['frequency'] as String,
      notes: json['notes'] as String? ?? '',
    );
  }

  /// Source context label.
  final String context;

  /// Amount description.
  final String amountDescription;

  /// Frequency description.
  final String frequency;

  /// Optional notes.
  final String notes;

  /// Converts to domain entity.
  ReportedPattern toEntity() {
    return ReportedPattern(
      context: context,
      amountDescription: amountDescription,
      frequency: frequency,
      notes: notes,
    );
  }
}

/// JSON model for a source citation.
class CompoundSourceModel {
  /// Creates the model.
  const CompoundSourceModel({required this.title, this.reference = ''});

  /// Parses from JSON.
  factory CompoundSourceModel.fromJson(Map<String, dynamic> json) {
    return CompoundSourceModel(
      title: json['title'] as String,
      reference: json['reference'] as String? ?? '',
    );
  }

  /// Source title.
  final String title;

  /// Reference id.
  final String reference;

  /// Converts to domain entity.
  CompoundSource toEntity() {
    return CompoundSource(title: title, reference: reference);
  }
}
