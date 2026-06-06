import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';
import 'package:peptide_tracker_app/src/core/widgets/app_card.dart';
import 'package:peptide_tracker_app/src/core/widgets/section_header.dart';
import 'package:peptide_tracker_app/src/features/calculator/presentation/view/calculator_page.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/library/domain/entities/compound_info.dart';

/// Full compound reference screen with attributed patterns and sources.
class CompoundDetailPage extends StatelessWidget {
  /// Creates the detail page.
  const CompoundDetailPage({required this.compound, super.key});

  /// Compound to display.
  final CompoundInfo compound;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(compound.name)),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          Text(
            compound.category.label.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(compound.name, style: theme.textTheme.headlineLarge),
          if (compound.aliases.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              compound.aliases.join(' · '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(compound.summary, style: theme.textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.md),
          const _InfoBanner(
            icon: Icons.info_outline,
            text:
                'Educational reference only. Reported patterns below come '
                'from labeling, literature, or community sources — not from '
                'this app.',
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'What it is'),
          const SizedBox(height: AppSpacing.xs),
          Text(compound.whatItIs, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Mechanism (overview)'),
          const SizedBox(height: AppSpacing.xs),
          Text(compound.mechanism, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pharmacokinetics', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                _DetailRow(label: 'Half-life', value: compound.halfLife),
                if (compound.tmax.isNotEmpty)
                  _DetailRow(label: 'Tmax', value: compound.tmax),
                const SizedBox(height: AppSpacing.xs),
                Text('Routes discussed', style: theme.textTheme.labelMedium),
                const SizedBox(height: AppSpacing.xxs),
                ...compound.typicalRoutes.map(
                  (route) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
                    child: Text('• $route'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Reported patterns in sources'),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Amounts and schedules as described elsewhere — for your records, '
            'not as guidance from this tracker.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...compound.reportedPatterns.map(
            (pattern) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pattern.context,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      pattern.amountDescription,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text('Frequency: ${pattern.frequency}'),
                    if (pattern.notes.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        pattern.notes,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const SectionHeader(title: 'Logging tips'),
          const SizedBox(height: AppSpacing.xs),
          ...compound.loggingTips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.edit_note_outlined,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(child: Text(tip)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Sources'),
          const SizedBox(height: AppSpacing.xs),
          ...compound.sources.map(
            (source) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                source.reference.isEmpty
                    ? '• ${source.title}'
                    : '• ${source.title} (${source.reference})',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Text(
              compound.caution,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const CalculatorPage(),
                  ),
                ),
                icon: const Icon(Icons.calculate_outlined),
                label: const Text('Open calculator'),
              ),
              FilledButton.tonalIcon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Create a routine in Protocols using '
                        '"${compound.name}" as your compound label.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Use in a routine'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 88,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(text, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
