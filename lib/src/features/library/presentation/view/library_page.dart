import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';
import 'package:peptide_tracker_app/src/core/widgets/app_card.dart';
import 'package:peptide_tracker_app/src/core/widgets/empty_state.dart';
import 'package:peptide_tracker_app/src/features/library/data/datasources/library_asset_data_source.dart';
import 'package:peptide_tracker_app/src/features/library/data/repositories/library_repository_impl.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_info.dart';
import 'package:peptide_tracker_app/src/features/library/presentation/cubit/library_cubit.dart';
import 'package:peptide_tracker_app/src/features/library/presentation/view/compound_detail_page.dart';

/// Knowledge tab: searchable compound reference with attributed patterns.
class LibraryPage extends StatelessWidget {
  /// Creates the library page.
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LibraryCubit>(
      create: (_) => LibraryCubit(
        repository: const LibraryRepositoryImpl(
          dataSource: LibraryAssetDataSource(),
        ),
      )..load(),
      child: const _LibraryView(),
    );
  }
}

class _LibraryView extends StatefulWidget {
  const _LibraryView();

  @override
  State<_LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<_LibraryView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          return switch (state.status) {
            LibraryStatus.initial || LibraryStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            LibraryStatus.failure => EmptyState(
              icon: Icons.menu_book_outlined,
              title: 'Library unavailable',
              message: state.message,
            ),
            LibraryStatus.success => _LibraryContent(
              state: state,
              searchController: _searchController,
            ),
          };
        },
      ),
    );
  }
}

class _LibraryContent extends StatelessWidget {
  const _LibraryContent({
    required this.state,
    required this.searchController,
  });

  final LibraryState state;
  final TextEditingController searchController;

  static const List<CompoundCategory?> _filterCategories = [
    null,
    CompoundCategory.glp1,
    CompoundCategory.recovery,
    CompoundCategory.ghrhGhrp,
    CompoundCategory.metabolic,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<LibraryCubit>();
    final visible = state.visibleCompounds;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: AppSpacing.screen.copyWith(bottom: AppSpacing.sm),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text('Library', style: theme.textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Compound reference with patterns reported in labeling, '
                'literature, and community sources. Informational only.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SearchBar(
                controller: searchController,
                hintText: 'Search compounds or brands…',
                leading: const Icon(Icons.search),
                onChanged: cubit.setSearchQuery,
                trailing: state.searchQuery.isEmpty
                    ? null
                    : [
                        IconButton(
                          onPressed: () {
                            searchController.clear();
                            cubit.setSearchQuery('');
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
              ),
              const SizedBox(height: AppSpacing.sm),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filterCategories.map((category) {
                    final selected = state.selectedCategory == category;
                    final label = category?.label ?? 'All';
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xs),
                      child: FilterChip(
                        label: Text(label),
                        selected: selected,
                        onSelected: (_) => cubit.setCategory(category),
                      ),
                    );
                  }).toList(growable: false),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${visible.length} compound${visible.length == 1 ? '' : 's'}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ]),
          ),
        ),
        if (visible.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.search_off_outlined,
              title: 'No matches',
              message: 'Try another search term or clear filters.',
              action: FilledButton.tonal(
                onPressed: () {
                  searchController.clear();
                  cubit.clearFilters();
                },
                child: const Text('Clear filters'),
              ),
            ),
          )
        else
          SliverPadding(
            padding: AppSpacing.screen.copyWith(top: 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final compound = visible[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == visible.length - 1
                          ? AppSpacing.xxl
                          : AppSpacing.sm,
                    ),
                    child: _CompoundListCard(compound: compound),
                  );
                },
                childCount: visible.length,
              ),
            ),
          ),
      ],
    );
  }
}

class _CompoundListCard extends StatelessWidget {
  const _CompoundListCard({required this.compound});

  final CompoundInfo compound;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstPattern = compound.reportedPatterns.isEmpty
        ? null
        : compound.reportedPatterns.first;

    return AppCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => CompoundDetailPage(compound: compound),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  compound.category.label.toUpperCase(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(compound.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            compound.summary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
          if (firstPattern != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppRadii.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reported in ${firstPattern.context}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${firstPattern.amountDescription} · '
                    '${firstPattern.frequency}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
