import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/design/app_spacing.dart';
import 'package:peptide_tracker_app/src/core/widgets/section_header.dart';
import 'package:peptide_tracker_app/src/features/onboarding/data/app_launch_repository.dart';

/// Settings screen: appearance, legal/safety, and privacy.
///
/// Reached from the gear icon in the main shell (a pushed route rather than a
/// bottom-navigation tab).
class SettingsPage extends StatelessWidget {
  /// Creates the settings page.
  const SettingsPage({
    required this.snapshot,
    required this.themeMode,
    required this.onThemeModeChanged,
    super.key,
  });

  /// Launch metadata captured during onboarding.
  final LaunchSnapshot snapshot;

  /// Currently selected theme mode.
  final ThemeMode themeMode;

  /// Called when the user picks a different theme mode.
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final acceptedAt = snapshot.acceptedAt;
    final acceptedLabel = acceptedAt == null
        ? 'Not recorded'
        : '${acceptedAt.year}-'
              '${acceptedAt.month.toString().padLeft(2, '0')}-'
              '${acceptedAt.day.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          const SectionHeader(title: 'Appearance'),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(Icons.brightness_auto_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.light_mode_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.dark_mode_outlined),
              ),
            ],
            selected: {themeMode},
            onSelectionChanged: (selection) =>
                onThemeModeChanged(selection.first),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Legal and safety', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'This app is a private tracking and record-keeping tool.',
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'It does not provide medical advice, diagnosis, treatment, '
            'or personalized recommendations.',
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Any calculations shown are generated from values you enter '
            'and are provided for informational purposes only.',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Accepted disclaimer version: '
            '${snapshot.acceptedDisclaimerVersion ?? currentDisclaimerVersion}',
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text('Accepted on: $acceptedLabel'),
          const SizedBox(height: AppSpacing.md),
          FilledButton.tonal(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Medical and safety notice'),
                content: SingleChildScrollView(
                  child: Text(
                    'This app is for record-keeping, reminders, and '
                    'informational calculations based on values you enter. '
                    'It does not provide medical advice, diagnosis, treatment '
                    'guidance, or personalized dose recommendations. Always '
                    'use your own judgment and consult a qualified healthcare '
                    'professional for medical decisions.',
                  ),
                ),
              ),
            ),
            child: const Text('Review medical and safety notice'),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Privacy', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          const Text('No account required in the MVP.'),
          const SizedBox(height: AppSpacing.xs),
          const Text('Your data is stored locally on this device.'),
        ],
      ),
    );
  }
}
