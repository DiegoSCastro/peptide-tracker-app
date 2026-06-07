import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/features/onboarding/data/app_launch_repository.dart';
import 'package:peptide_tracker_app/src/features/onboarding/domain/protocol_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/repositories/protocols_repository.dart';

/// First-run onboarding flow for disclaimer, notifications, and setup.
class OnboardingFlow extends StatefulWidget {
  /// Creates the onboarding flow.
  const OnboardingFlow({
    required this.hasExistingProtocols,
    required this.launchRepository,
    required this.protocolsRepository,
    required this.requestNotificationPermissions,
    required this.onCompleted,
    super.key,
  });

  /// Whether the user already has saved protocols.
  final bool hasExistingProtocols;

  /// Repository used to persist onboarding progress.
  final AppLaunchRepository launchRepository;

  /// Repository used to save the first routine.
  final ProtocolsRepository protocolsRepository;

  /// Callback that requests notification permissions.
  final Future<void> Function() requestNotificationPermissions;

  /// Callback invoked when onboarding completes successfully.
  final Future<void> Function() onCompleted;

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _stepIndex = 0;
  bool _acceptedDisclaimer = false;
  bool _isSaving = false;

  final _formKey = GlobalKey<FormState>();
  final _protocolNameController = TextEditingController();
  final _compoundLabelController = TextEditingController();

  @override
  void dispose() {
    _protocolNameController.dispose();
    _compoundLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Easy Peptide Tracker')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: switch (_stepIndex) {
                0 => _WelcomeStep(onContinue: _goToDisclaimer),
                1 => _DisclaimerStep(
                  accepted: _acceptedDisclaimer,
                  onToggleAccepted: _toggleAccepted,
                  onContinue: _continueFromDisclaimer,
                ),
                2 => _NotificationsStep(
                  onContinue: _continueFromNotifications,
                  hasExistingProtocols: widget.hasExistingProtocols,
                ),
                _ => _CreateFirstRoutineStep(
                  formKey: _formKey,
                  protocolNameController: _protocolNameController,
                  compoundLabelController: _compoundLabelController,
                  isSaving: _isSaving,
                  onSave: _saveFirstRoutine,
                ),
              },
            ),
          ),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }

  void _goToDisclaimer() {
    setState(() => _stepIndex = 1);
  }

  void _toggleAccepted(bool? value) {
    setState(() => _acceptedDisclaimer = value ?? false);
  }

  Future<void> _continueFromDisclaimer() async {
    if (!_acceptedDisclaimer) {
      return;
    }

    await widget.launchRepository.acceptDisclaimer(
      version: currentDisclaimerVersion,
    );

    if (!mounted) {
      return;
    }

    setState(() => _stepIndex = 2);
  }

  Future<void> _continueFromNotifications() async {
    await widget.requestNotificationPermissions();
    await widget.launchRepository.markNotificationsPromptSeen();

    if (!mounted) {
      return;
    }

    if (widget.hasExistingProtocols) {
      await widget.onCompleted();
      return;
    }

    setState(() => _stepIndex = 3);
  }

  Future<void> _saveFirstRoutine() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    final draft = ProtocolEditorDraft(
      protocolName: _protocolNameController.text.trim(),
      compoundName: _compoundLabelController.text.trim(),
      compoundCategory: CompoundCategory.glp1,
      unitLabel: 'mg',
      plannedAmount: 0.25,
      scheduleType: ProtocolScheduleType.everyNDays,
      intervalDays: 7,
      reminderMinutesAfterMidnight: 9 * 60,
      startDate: DateTime.now().toUtc(),
      isActive: true,
      notes: '',
    );

    final result = await widget.protocolsRepository.saveDraft(draft).run();

    await result.match(
      (failure) async {
        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (_) async {
        await widget.launchRepository.saveFirstProtocol(
          ProtocolDraft(
            name: draft.protocolName,
            compoundLabel: draft.compoundName,
            category: draft.compoundCategory.label,
            scheduleSummary: 'Every ${draft.intervalDays ?? 7} days',
            startDate: draft.startDate,
            plannedAmount: draft.plannedAmount?.toString(),
            unitLabel: draft.unitLabel,
            reminderTime: '09:00 AM',
            notes: draft.notes,
          ),
        );

        if (!mounted) {
          return;
        }

        await widget.onCompleted();
      },
    );

    if (!mounted) {
      return;
    }

    setState(() => _isSaving = false);
  }
}

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Private peptide and GLP-1 tracker',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Track routines, reminders, and history in one private app.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'No account is required for the MVP, and your records stay on '
              'this device.',
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onContinue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DisclaimerStep extends StatelessWidget {
  const _DisclaimerStep({
    required this.accepted,
    required this.onToggleAccepted,
    required this.onContinue,
  });

  final bool accepted;
  final ValueChanged<bool?> onToggleAccepted;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medical and safety notice',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'This app is for record-keeping, reminders, and informational '
              'calculations based on values you enter.',
            ),
            const SizedBox(height: 8),
            const Text(
              'It does not provide medical advice, diagnosis, treatment '
              'guidance, or personalized dose recommendations.',
            ),
            const SizedBox(height: 8),
            const Text(
              'Always use your own judgment and consult a qualified '
              'healthcare professional for medical decisions.',
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: accepted,
              onChanged: onToggleAccepted,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'I understand this app is a tracking tool and not medical '
                'advice.',
              ),
            ),
            const SizedBox(height: 8),
            const Text('You can review this notice again later in Settings.'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onContinue,
              child: Text(accepted ? 'I understand' : 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsStep extends StatelessWidget {
  const _NotificationsStep({
    required this.onContinue,
    required this.hasExistingProtocols,
  });

  final VoidCallback onContinue;
  final bool hasExistingProtocols;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reminder intro',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text(
              'Reminders help you keep track of routines you create.',
            ),
            const SizedBox(height: 8),
            const Text(
              'Reminders are based on your entries and are not treatment '
              'guidance.',
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onContinue,
              child: Text(hasExistingProtocols ? 'Go to tracker' : 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateFirstRoutineStep extends StatelessWidget {
  const _CreateFirstRoutineStep({
    required this.formKey,
    required this.protocolNameController,
    required this.compoundLabelController,
    required this.isSaving,
    required this.onSave,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController protocolNameController;
  final TextEditingController compoundLabelController;
  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create first routine',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              const Text(
                'Create a routine to organize your own schedule and records.',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: protocolNameController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Protocol name',
                ),
                validator: _requiredFieldValidator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: compoundLabelController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Compound label',
                ),
                validator: _requiredFieldValidator,
              ),
              const SizedBox(height: 12),
              const Text('Schedule: Every 7 days'),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: isSaving ? null : onSave,
                child: Text(isSaving ? 'Saving...' : 'Save routine'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _requiredFieldValidator(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Required';
    }
    return null;
  }
}
