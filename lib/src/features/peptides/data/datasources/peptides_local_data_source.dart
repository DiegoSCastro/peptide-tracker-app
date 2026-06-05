import 'package:peptide_tracker_app/src/features/peptides/data/models/peptide_model.dart';

/// Local seed data used by the first app version.
class PeptidesLocalDataSource {
  /// Creates the local data source.
  const PeptidesLocalDataSource();

  /// Returns the featured peptide catalog.
  List<PeptideModel> getFeaturedPeptides() {
    return const [
      PeptideModel(
        name: 'GLP-1 Overview',
        category: 'Tracking',
        summary:
            'Quick summary card for adherence, appetite, and weekly '
            'check-ins.',
        highlights: [
          'Weekly check-in flow',
          'Simple progress notes',
          'Side-effect journal starter',
        ],
        caution:
            'Educational only. Avoid dose recommendations or '
            'medical advice.',
      ),
      PeptideModel(
        name: 'BPC-157 Notes',
        category: 'Education',
        summary:
            'Reference card structure for cycle notes, protocols, '
            'and research links.',
        highlights: [
          'Protocol snapshot',
          'Recovery checklist',
          'Research-first positioning',
        ],
        caution: 'Do not frame content as treatment guidance.',
      ),
      PeptideModel(
        name: 'Sermorelin Routine',
        category: 'Routine',
        summary:
            'Template for reminder windows, sleep observations, and '
            'compliance logs.',
        highlights: [
          'Reminder windows',
          'Sleep quality notes',
          'Consistency scoreboard',
        ],
        caution:
            'Keep user-entered records separate from personalized '
            'recommendations.',
      ),
    ];
  }
}
