import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/entities/peptide.dart';
import 'package:peptide_tracker_app/src/features/peptides/presentation/cubit/peptides_cubit.dart';

/// Home page for the peptide tracker starter app.
class PeptidesPage extends StatelessWidget {
  /// Creates the peptides page.
  const PeptidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peptide Tracker')),
      body: BlocBuilder<PeptidesCubit, PeptidesState>(
        builder: (context, state) {
          return switch (state.status) {
            PeptidesStatus.initial || PeptidesStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            PeptidesStatus.failure => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(state.message, textAlign: TextAlign.center),
              ),
            ),
            PeptidesStatus.success => _PeptidesView(peptides: state.peptides),
          };
        },
      ),
    );
  }
}

class _PeptidesView extends StatelessWidget {
  const _PeptidesView({required this.peptides});

  final List<Peptide> peptides;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'A simple MVVM starter for a peptide tracking app.',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Focus the first version on logs, reminders, and education '
          'without crossing into personalized medical guidance.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        for (final peptide in peptides) ...[
          _PeptideCard(peptide: peptide),
          const SizedBox(height: 16),
        ],
        const _RoadmapCard(),
      ],
    );
  }
}

class _PeptideCard extends StatelessWidget {
  const _PeptideCard({required this.peptide});

  final Peptide peptide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              peptide.category.toUpperCase(),
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Text(peptide.name, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(peptide.summary, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            ...peptide.highlights.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(Icons.check_circle_outline, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              peptide.caution,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoadmapCard extends StatelessWidget {
  const _RoadmapCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Next MVP steps'),
            SizedBox(height: 12),
            Text('1. User logs for check-ins and adherence.'),
            SizedBox(height: 8),
            Text('2. Freemium hooks for ads and premium upgrade paths.'),
            SizedBox(height: 8),
            Text('3. Remote-config driven content and disclaimers.'),
          ],
        ),
      ),
    );
  }
}
