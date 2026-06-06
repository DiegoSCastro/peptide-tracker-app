import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';
import 'package:peptide_tracker_app/src/core/widgets/app_card.dart';
import 'package:peptide_tracker_app/src/core/widgets/empty_state.dart';
import 'package:peptide_tracker_app/src/features/peptides/data/datasources/peptides_local_data_source.dart';
import 'package:peptide_tracker_app/src/features/peptides/data/repositories/peptides_repository_impl.dart';
import 'package:peptide_tracker_app/src/features/peptides/domain/entities/peptide.dart';
import 'package:peptide_tracker_app/src/features/peptides/presentation/cubit/peptides_cubit.dart';

/// Knowledge tab: a neutral, educational reference of compounds.
///
/// Content is informational only and intentionally avoids dose or protocol
/// recommendations (see `docs/compliance/compliance-language-pack.md`).
class LibraryPage extends StatelessWidget {
  /// Creates the library page.
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PeptidesCubit>(
      create: (_) =>
          PeptidesCubit(
            repository: const PeptidesRepositoryImpl(
              dataSource: PeptidesLocalDataSource(),
            ),
          )..load(),
      child: const _LibraryView(),
    );
  }
}

class _LibraryView extends StatelessWidget {
  const _LibraryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: BlocBuilder<PeptidesCubit, PeptidesState>(
        builder: (context, state) {
          return switch (state.status) {
            PeptidesStatus.initial || PeptidesStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            PeptidesStatus.failure => EmptyState(
              icon: Icons.menu_book_outlined,
              title: 'Library unavailable',
              message: state.message,
            ),
            PeptidesStatus.success => _LibraryList(peptides: state.peptides),
          };
        },
      ),
    );
  }
}

class _LibraryList extends StatelessWidget {
  const _LibraryList({required this.peptides});

  final List<Peptide> peptides;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpacing.screen,
      children: [
        Text('Library', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Neutral, educational reference for the routines you track. '
          'Informational only — not medical advice or dose recommendations.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final peptide in peptides) ...[
          _CompoundCard(peptide: peptide),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _CompoundCard extends StatelessWidget {
  const _CompoundCard({required this.peptide});

  final Peptide peptide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            peptide.category.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(peptide.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(peptide.summary, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          ...peptide.highlights.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxs + 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            peptide.caution,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
