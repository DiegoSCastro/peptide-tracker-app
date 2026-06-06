import 'package:flutter/material.dart';
import 'package:peptide_tracker_app/src/core/reminders/protocol_reminder_schedule.dart';
import 'package:peptide_tracker_app/src/features/calculator/presentation/view/calculator_page.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_draft.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';
import 'package:peptide_tracker_app/src/features/history/domain/repositories/log_entries_repository.dart';
import 'package:peptide_tracker_app/src/features/onboarding/data/app_launch_repository.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/repositories/protocols_repository.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    required this.launchSnapshot,
    required this.logEntriesRepository,
    required this.protocolsRepository,
    required this.now,
    super.key,
  });

  final LaunchSnapshot launchSnapshot;
  final LogEntriesRepository logEntriesRepository;
  final ProtocolsRepository protocolsRepository;
  final DateTime Function() now;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final destinations = const [
      NavigationDestination(icon: Icon(Icons.today_outlined), label: 'Today'),
      NavigationDestination(
        icon: Icon(Icons.medication_outlined),
        label: 'Protocols',
      ),
      NavigationDestination(
        icon: Icon(Icons.calculate_outlined),
        label: 'Calculator',
      ),
      NavigationDestination(
        icon: Icon(Icons.history_outlined),
        label: 'History',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        label: 'Settings',
      ),
    ];

    final pages = [
      _TodayPage(
        logEntriesRepository: widget.logEntriesRepository,
        now: widget.now,
        onOpenHistory: () => setState(() => _selectedIndex = 3),
        onOpenProtocols: () => setState(() => _selectedIndex = 1),
        protocolsRepository: widget.protocolsRepository,
      ),
      _ProtocolsPage(protocolsRepository: widget.protocolsRepository),
      const CalculatorPage(),
      _HistoryPage(
        logEntriesRepository: widget.logEntriesRepository,
        onBackToToday: () => setState(() => _selectedIndex = 0),
      ),
      _SettingsPage(snapshot: widget.launchSnapshot),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: destinations,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}

class _TodayPage extends StatelessWidget {
  const _TodayPage({
    required this.logEntriesRepository,
    required this.now,
    required this.onOpenHistory,
    required this.onOpenProtocols,
    required this.protocolsRepository,
  });

  final LogEntriesRepository logEntriesRepository;
  final DateTime Function() now;
  final VoidCallback onOpenHistory;
  final VoidCallback onOpenProtocols;
  final ProtocolsRepository protocolsRepository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Today')),
      body: StreamBuilder<List<ManagedProtocol>>(
        stream: protocolsRepository.watchAll(),
        builder: (context, snapshot) {
          final protocols = snapshot.data ?? const <ManagedProtocol>[];
          final currentTime = now();
          final activeProtocols = protocols
              .where((item) => item.protocol.isActive)
              .toList(growable: false);
          final reminderEntries =
              activeProtocols
                  .map(
                    (item) => _TodayReminderEntry.fromManagedProtocol(
                      item,
                      currentTime,
                    ),
                  )
                  .whereType<_TodayReminderEntry>()
                  .toList(growable: false)
                ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
          final dueTodayEntries = reminderEntries
              .where((entry) => _isSameDate(entry.scheduledAt, currentTime))
              .toList(growable: false);
          final upcomingEntries = reminderEntries
              .where((entry) => !_isSameDate(entry.scheduledAt, currentTime))
              .take(3)
              .toList(growable: false);
          final nextReminder = reminderEntries.isEmpty
              ? null
              : reminderEntries.first;

          return StreamBuilder<List<LogEntry>>(
            stream: logEntriesRepository.watchRecent(limit: 3),
            builder: (context, historySnapshot) {
              final recentEntries = historySnapshot.data ?? const <LogEntry>[];

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Today', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(
                    _formatDayLabel(currentTime),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text('Tap + Log when you want to save a record.'),
                  const SizedBox(height: 16),
                  if (activeProtocols.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('No routines yet'),
                            SizedBox(height: 8),
                            Text(
                              'Create your first routine to see reminders and quick logging here.',
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${dueTodayEntries.length} due today',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              nextReminder == null
                                  ? 'No upcoming reminders scheduled.'
                                  : 'Next reminder at ${_formatReminderDateTime(nextReminder.scheduledAt, currentTime)}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Essential status',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _DashboardStatChip(
                                  label: 'Active routines',
                                  value: activeProtocols.length.toString(),
                                ),
                                _DashboardStatChip(
                                  label: 'Due today',
                                  value: dueTodayEntries.length.toString(),
                                ),
                                _DashboardStatChip(
                                  label: 'Recent logs',
                                  value: recentEntries.length.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Quick actions', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () => _openQuickLogSheet(
                            context,
                            activeProtocols: activeProtocols,
                            initialProtocolId: nextReminder?.item.protocol.id,
                          ),
                          icon: const Icon(Icons.add_task_outlined),
                          label: const Text('Open quick log'),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: onOpenHistory,
                          icon: const Icon(Icons.history_outlined),
                          label: const Text('View all history'),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: onOpenProtocols,
                          icon: const Icon(Icons.medication_outlined),
                          label: const Text('Manage routines'),
                        ),
                      ],
                    ),
                    if (recentEntries.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Card(
                        child: ListTile(
                          title: const Text('Latest activity'),
                          subtitle: Text(
                            recentEntries.first.note.isNotEmpty
                                ? recentEntries.first.note
                                : 'Logged ${recentEntries.first.protocolNameSnapshot}',
                          ),
                          trailing: TextButton(
                            onPressed: onOpenHistory,
                            child: const Text('History'),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Text('Due today', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    if (dueTodayEntries.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Nothing is due today yet.'),
                        ),
                      )
                    else
                      ...dueTodayEntries.map(
                        (entry) => Card(
                          child: ListTile(
                            title: Text(entry.item.protocol.name),
                            subtitle: Text(
                              '${entry.item.compound.name} • ${entry.item.scheduleSummary}',
                            ),
                            leading: Chip(
                              label: Text(
                                entry.scheduledAt.isAfter(currentTime)
                                    ? 'Later today'
                                    : 'Due now',
                              ),
                            ),
                            trailing: FilledButton(
                              onPressed: () => _openQuickLogSheet(
                                context,
                                activeProtocols: activeProtocols,
                                initialProtocolId: entry.item.protocol.id,
                              ),
                              child: const Text('Log'),
                            ),
                          ),
                        ),
                      ),
                    if (upcomingEntries.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text('Upcoming', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      ...upcomingEntries.map(
                        (entry) => Card(
                          child: ListTile(
                            title: Text(entry.item.protocol.name),
                            subtitle: Text(
                              '${entry.item.compound.name} • ${_formatReminderDateTime(entry.scheduledAt, currentTime)}',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                  const SizedBox(height: 24),
                  Text('Recent activity', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (recentEntries.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'No saved records yet. Use Log to create your first history entry.',
                        ),
                      ),
                    )
                  else
                    ...recentEntries.map(
                      (entry) => Card(
                        child: ListTile(
                          title: Text('Logged ${entry.protocolNameSnapshot}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${entry.compoundNameSnapshot} • ${entry.status.label} • ${entry.amountLabel}',
                              ),
                              if (entry.note.isNotEmpty) Text(entry.note),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openQuickLogSheet(
    BuildContext context, {
    required List<ManagedProtocol> activeProtocols,
    String? initialProtocolId,
  }) async {
    if (activeProtocols.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Create a routine before saving logs.')),
      );
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _QuickLogSheet(
        activeProtocols: activeProtocols,
        initialProtocolId: initialProtocolId,
        logEntriesRepository: logEntriesRepository,
        now: now,
      ),
    );
  }
}

class _QuickLogSheet extends StatefulWidget {
  const _QuickLogSheet({
    required this.activeProtocols,
    required this.logEntriesRepository,
    required this.now,
    this.initialProtocolId,
  });

  final List<ManagedProtocol> activeProtocols;
  final LogEntriesRepository logEntriesRepository;
  final DateTime Function() now;
  final String? initialProtocolId;

  @override
  State<_QuickLogSheet> createState() => _QuickLogSheetState();
}

class _QuickLogSheetState extends State<_QuickLogSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedProtocolId;
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  var _status = LogEntryStatus.done;
  var _isSaving = false;

  ManagedProtocol get _selectedProtocol => widget.activeProtocols.firstWhere(
    (item) => item.protocol.id == _selectedProtocolId,
  );

  @override
  void initState() {
    super.initState();
    _selectedProtocolId =
        widget.initialProtocolId ?? widget.activeProtocols.first.protocol.id;
    _amountController = TextEditingController(
      text: _selectedProtocol.protocol.plannedAmount?.toString() ?? '',
    );
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick log',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedProtocolId,
              decoration: const InputDecoration(labelText: 'Protocol'),
              items: widget.activeProtocols
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item.protocol.id,
                      child: Text(item.protocol.name),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _selectedProtocolId = value;
                  _amountController.text =
                      _selectedProtocol.protocol.plannedAmount?.toString() ??
                      '';
                });
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Amount'),
              validator: _validateAmount,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Done'),
                  selected: _status == LogEntryStatus.done,
                  onSelected: (_) =>
                      setState(() => _status = LogEntryStatus.done),
                ),
                ChoiceChip(
                  label: const Text('Skipped'),
                  selected: _status == LogEntryStatus.skipped,
                  onSelected: (_) =>
                      setState(() => _status = LogEntryStatus.skipped),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _noteController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Note (optional)'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSaving ? null : _save,
                child: Text(_isSaving ? 'Saving...' : 'Save log'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    final result = await widget.logEntriesRepository
        .create(
          LogEntryDraft(
            protocolId: _selectedProtocol.protocol.id,
            loggedAt: widget.now().toUtc(),
            amount: _parseAmount(_amountController.text),
            status: _status,
            note: _noteController.text.trim(),
            createdFromReminder: false,
            unitLabel: _selectedProtocol.protocol.unitLabel,
          ),
        )
        .run();

    if (!mounted) {
      return;
    }

    result.match(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failure.message)),
      ),
      (_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Log saved')),
        );
      },
    );

    if (!mounted) {
      return;
    }

    setState(() => _isSaving = false);
  }

  String? _validateAmount(String? value) {
    final raw = (value ?? '').trim();
    if (raw.isEmpty) {
      return null;
    }

    return double.tryParse(raw) == null ? 'Enter a valid number' : null;
  }

  double? _parseAmount(String raw) {
    final normalized = raw.trim();
    if (normalized.isEmpty) {
      return null;
    }

    return double.tryParse(normalized);
  }
}

class _ProtocolsPage extends StatelessWidget {
  const _ProtocolsPage({required this.protocolsRepository});

  final ProtocolsRepository protocolsRepository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Protocols')),
      body: StreamBuilder<List<ManagedProtocol>>(
        stream: protocolsRepository.watchAll(),
        builder: (context, snapshot) {
          final protocols = snapshot.data ?? const <ManagedProtocol>[];
          final activeProtocols = protocols
              .where((item) => item.protocol.isActive)
              .toList(growable: false);
          final inactiveProtocols = protocols
              .where((item) => !item.protocol.isActive)
              .toList(growable: false);
          final hasFreeTierLimitReached = activeProtocols.isNotEmpty;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Protocols', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              if (hasFreeTierLimitReached) ...[
                Text('${activeProtocols.length} of 1 free routines used'),
                const SizedBox(height: 8),
                const Text(
                  'Upgrade to add more routines, remove ads, and unlock advanced organization.',
                ),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  onPressed: () => _showFreeTierIntercept(context),
                  child: const Text('Upgrade'),
                ),
              ] else ...[
                const Text('Your routines'),
                const SizedBox(height: 8),
                const Text('Organize schedules, reminders, and records.'),
              ],
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: protocols.isEmpty
                    ? FilledButton.icon(
                        onPressed: () => _openEditor(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Create routine'),
                      )
                    : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _openEditor(context),
                            icon: const Icon(Icons.add),
                            label: const Text('Add another routine'),
                          ),
                          if (hasFreeTierLimitReached)
                            TextButton(
                              onPressed: () => _showFreeTierIntercept(context),
                              child: const Text('New protocol'),
                            ),
                        ],
                      ),
              ),
              const SizedBox(height: 16),
              if (protocols.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No routines yet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Create a routine to organize your schedule and reminders.',
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                if (activeProtocols.isNotEmpty) ...[
                  Text('Active', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...activeProtocols.map(
                    (item) => _ProtocolCard(
                      item: item,
                      onEdit: () => _openEditor(
                        context,
                        initialDraft: item.toEditorDraft(),
                      ),
                      onView: () => _openProtocolDetails(context, item),
                    ),
                  ),
                ],
                if (inactiveProtocols.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('Inactive', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...inactiveProtocols.map(
                    (item) => _ProtocolCard(
                      item: item,
                      onEdit: () => _openEditor(
                        context,
                        initialDraft: item.toEditorDraft(),
                      ),
                      onView: () => _openProtocolDetails(context, item),
                    ),
                  ),
                ],
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _openEditor(
    BuildContext context, {
    ProtocolEditorDraft? initialDraft,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _ProtocolEditorDialog(
        protocolsRepository: protocolsRepository,
        initialDraft: initialDraft,
      ),
    );
  }

  Future<void> _openProtocolDetails(
    BuildContext context,
    ManagedProtocol item,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _ProtocolDetailsPage(
          protocolId: item.protocol.id,
          protocolsRepository: protocolsRepository,
        ),
      ),
    );
  }

  Future<void> _showFreeTierIntercept(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Free includes 1 active routine'),
        content: const Text(
          'Upgrade later to add more routines and unlock advanced organization.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Keep current routine'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Upgrade to Pro'),
          ),
        ],
      ),
    );
  }
}

class _ProtocolCard extends StatelessWidget {
  const _ProtocolCard({
    required this.item,
    required this.onEdit,
    required this.onView,
  });

  final ManagedProtocol item;
  final VoidCallback onEdit;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.protocol.name),
        subtitle: Text('${item.compound.name} • ${item.scheduleSummary}'),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
            ),
            TextButton(
              onPressed: onView,
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProtocolDetailsPage extends StatelessWidget {
  const _ProtocolDetailsPage({
    required this.protocolId,
    required this.protocolsRepository,
  });

  final String protocolId;
  final ProtocolsRepository protocolsRepository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ManagedProtocol>>(
      stream: protocolsRepository.watchAll(),
      builder: (context, snapshot) {
        final protocols = snapshot.data ?? const <ManagedProtocol>[];
        final item = protocols
            .where((candidate) => candidate.protocol.id == protocolId)
            .firstOrNull;

        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Routine details')),
            body: const Center(child: Text('Routine not found.')),
          );
        }

        return _ProtocolDetailsView(
          item: item,
          protocolsRepository: protocolsRepository,
        );
      },
    );
  }
}

class _ProtocolDetailsView extends StatefulWidget {
  const _ProtocolDetailsView({
    required this.item,
    required this.protocolsRepository,
  });

  final ManagedProtocol item;
  final ProtocolsRepository protocolsRepository;

  @override
  State<_ProtocolDetailsView> createState() => _ProtocolDetailsViewState();
}

class _ProtocolDetailsViewState extends State<_ProtocolDetailsView> {
  var _isUpdatingStatus = false;
  var _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final theme = Theme.of(context);
    final nextReminder = ProtocolReminderSchedule.nextReminderAfter(
      item.protocol,
      DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(item.protocol.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(item.protocol.name, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('${item.compound.name} • ${item.compound.category.label}'),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.protocol.isActive ? 'Active' : 'Inactive',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(_scheduleWithReminder(item)),
                  const SizedBox(height: 4),
                  Text('Started ${_formatDate(item.protocol.startDate)}'),
                  if (nextReminder != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Next reminder: ${_formatReminderDateTime(nextReminder, DateTime.now())}',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('Log now'),
              ),
              FilledButton(
                onPressed: () => _openEditor(context, item.toEditorDraft()),
                child: const Text('Edit'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Danger zone', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _isUpdatingStatus ? null : _toggleStatus,
            child: Text(
              _isUpdatingStatus
                  ? 'Saving...'
                  : item.protocol.isActive
                  ? 'Pause routine'
                  : 'Resume routine',
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: _isDeleting ? null : _confirmDelete,
            child: Text(_isDeleting ? 'Deleting...' : 'Delete routine'),
          ),
        ],
      ),
    );
  }

  Future<void> _openEditor(
    BuildContext context,
    ProtocolEditorDraft initialDraft,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _ProtocolEditorDialog(
        protocolsRepository: widget.protocolsRepository,
        initialDraft: initialDraft,
      ),
    );
  }

  Future<void> _toggleStatus() async {
    setState(() => _isUpdatingStatus = true);

    final item = widget.item;
    final nextIsActive = !item.protocol.isActive;
    final result = await widget.protocolsRepository
        .setActive(protocolId: item.protocol.id, isActive: nextIsActive)
        .run();

    if (!mounted) {
      return;
    }

    result.match(
      (failure) => _showSnackBar(failure.message),
      (_) => _showSnackBar(nextIsActive ? 'Routine resumed' : 'Routine paused'),
    );

    if (!mounted) {
      return;
    }

    setState(() => _isUpdatingStatus = false);
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete routine?'),
        content: const Text(
          'This removes the routine and its linked compound from the MVP tracker.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    setState(() => _isDeleting = true);

    final result = await widget.protocolsRepository
        .delete(widget.item.protocol.id)
        .run();

    if (!mounted) {
      return;
    }

    result.match(
      (failure) => _showSnackBar(failure.message),
      (_) {
        _showSnackBar('Routine deleted');
        Navigator.of(context).pop();
      },
    );

    if (!mounted) {
      return;
    }

    setState(() => _isDeleting = false);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _ProtocolEditorDialog extends StatefulWidget {
  const _ProtocolEditorDialog({
    required this.protocolsRepository,
    this.initialDraft,
  });

  final ProtocolsRepository protocolsRepository;
  final ProtocolEditorDraft? initialDraft;

  @override
  State<_ProtocolEditorDialog> createState() => _ProtocolEditorDialogState();
}

class _ProtocolEditorDialogState extends State<_ProtocolEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _protocolNameController;
  late final TextEditingController _compoundLabelController;
  late bool _reminderEnabled;
  late int _reminderTimeMinutes;
  var _isSaving = false;

  @override
  void initState() {
    super.initState();
    _protocolNameController = TextEditingController(
      text: widget.initialDraft?.protocolName ?? '',
    );
    _compoundLabelController = TextEditingController(
      text: widget.initialDraft?.compoundName ?? '',
    );
    _reminderEnabled =
        widget.initialDraft?.reminderMinutesAfterMidnight != null;
    _reminderTimeMinutes =
        widget.initialDraft?.reminderMinutesAfterMidnight ?? 9 * 60;
  }

  @override
  void dispose() {
    _protocolNameController.dispose();
    _compoundLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.initialDraft == null ? 'Create routine' : 'Edit routine',
      ),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _protocolNameController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Protocol name'),
                validator: _requiredFieldValidator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _compoundLabelController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Compound label'),
                validator: _requiredFieldValidator,
              ),
              const SizedBox(height: 12),
              const Text('Schedule: Every 7 days'),
              const SizedBox(height: 12),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                value: _reminderEnabled,
                onChanged: (value) => setState(() => _reminderEnabled = value),
                title: const Text('Reminder enabled'),
                subtitle: const Text(
                  'Reminders help you keep track of routines you create.',
                ),
              ),
              if (_reminderEnabled) ...[
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _pickReminderTime,
                  icon: const Icon(Icons.schedule_outlined),
                  label: Text(
                    'Reminder time: ${_formatReminderMinutes(_reminderTimeMinutes)}',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _save,
          child: Text(_isSaving ? 'Saving...' : 'Save routine'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    final baseDraft = widget.initialDraft ?? ProtocolEditorDraft.initial();
    final result = await widget.protocolsRepository
        .saveDraft(
          baseDraft.copyWith(
            protocolName: _protocolNameController.text.trim(),
            compoundName: _compoundLabelController.text.trim(),
            compoundCategory: CompoundCategory.glp1,
            scheduleType: ProtocolScheduleType.everyNDays,
            intervalDays: 7,
            reminderMinutesAfterMidnight: _reminderEnabled
                ? _reminderTimeMinutes
                : null,
          ),
        )
        .run();

    if (!mounted) {
      return;
    }

    result.match(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (_) {
        Navigator.of(context).pop();
      },
    );

    if (!mounted) {
      return;
    }

    setState(() => _isSaving = false);
  }

  Future<void> _pickReminderTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: (_reminderTimeMinutes ~/ 60) % 24,
        minute: _reminderTimeMinutes % 60,
      ),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _reminderTimeMinutes = selected.hour * 60 + selected.minute;
    });
  }

  String? _requiredFieldValidator(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Required';
    }
    return null;
  }
}

class _HistoryPage extends StatelessWidget {
  const _HistoryPage({
    required this.logEntriesRepository,
    required this.onBackToToday,
  });

  final LogEntriesRepository logEntriesRepository;
  final VoidCallback onBackToToday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: StreamBuilder<List<LogEntry>>(
        stream: logEntriesRepository.watchRecent(),
        builder: (context, snapshot) {
          final entries = snapshot.data ?? const <LogEntry>[];
          if (entries.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('History is ready for your first saved records.'),
              ),
            );
          }

          final theme = Theme.of(context);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('History timeline', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Recent saved records appear here so you can confirm what was done and when.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.tonalIcon(
                  onPressed: onBackToToday,
                  icon: const Icon(Icons.today_outlined),
                  label: const Text('Back to today'),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(entries.length, (index) {
                final entry = entries[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == entries.length - 1 ? 0 : 8,
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(entry.protocolNameSnapshot),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${entry.compoundNameSnapshot} • ${entry.status.label} • ${entry.amountLabel}',
                          ),
                          Text(
                            _formatHistoryDateTime(entry.loggedAt.toLocal()),
                          ),
                          if (entry.note.isNotEmpty) Text(entry.note),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class _DashboardStatChip extends StatelessWidget {
  const _DashboardStatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: theme.textTheme.titleLarge),
          const SizedBox(height: 2),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage({required this.snapshot});

  final LaunchSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final acceptedAt = snapshot.acceptedAt;
    final acceptedLabel = acceptedAt == null
        ? 'Not recorded'
        : '${acceptedAt.year}-${acceptedAt.month.toString().padLeft(2, '0')}-${acceptedAt.day.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Legal and safety',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'This app is a private tracking and record-keeping tool.',
          ),
          const SizedBox(height: 8),
          const Text(
            'It does not provide medical advice, diagnosis, treatment, or personalized recommendations.',
          ),
          const SizedBox(height: 8),
          const Text(
            'Any calculations shown are generated from values you enter and are provided for informational purposes only.',
          ),
          const SizedBox(height: 16),
          Text(
            'Accepted disclaimer version: ${snapshot.acceptedDisclaimerVersion ?? currentDisclaimerVersion}',
          ),
          const SizedBox(height: 4),
          Text('Accepted on: $acceptedLabel'),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Medical and safety notice'),
                content: const SingleChildScrollView(
                  child: Text(
                    'This app is for record-keeping, reminders, and informational calculations based on values you enter. It does not provide medical advice, diagnosis, treatment guidance, or personalized dose recommendations. Always use your own judgment and consult a qualified healthcare professional for medical decisions.',
                  ),
                ),
              ),
            ),
            child: const Text('Review medical and safety notice'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Privacy',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text('No account required in the MVP.'),
          const SizedBox(height: 8),
          const Text('Your data is stored locally on this device.'),
        ],
      ),
    );
  }
}

class _TodayReminderEntry {
  const _TodayReminderEntry({required this.item, required this.scheduledAt});

  final ManagedProtocol item;
  final DateTime scheduledAt;

  static _TodayReminderEntry? fromManagedProtocol(
    ManagedProtocol item,
    DateTime anchor,
  ) {
    final scheduledAt = ProtocolReminderSchedule.nextReminderAfter(
      item.protocol,
      anchor,
    );
    if (scheduledAt == null) {
      return null;
    }

    return _TodayReminderEntry(item: item, scheduledAt: scheduledAt);
  }
}

bool _isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String _scheduleWithReminder(ManagedProtocol item) {
  final timeLabel = item.protocol.reminderMinutesAfterMidnight == null
      ? null
      : _formatReminderMinutes(item.protocol.reminderMinutesAfterMidnight!);

  if (timeLabel == null) {
    return item.scheduleSummary;
  }

  return '${item.scheduleSummary} at $timeLabel';
}

String _formatReminderMinutes(int minutesAfterMidnight) {
  final hours = (minutesAfterMidnight ~/ 60) % 24;
  final minutes = minutesAfterMidnight % 60;
  final normalizedHour = hours == 0 || hours == 12 ? 12 : hours % 12;
  final suffix = hours >= 12 ? 'PM' : 'AM';
  final minutesLabel = minutes.toString().padLeft(2, '0');
  return '$normalizedHour:$minutesLabel $suffix';
}

String _formatDate(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final month = months[value.month - 1];
  return '$month ${value.day}, ${value.year}';
}

String _formatDayLabel(DateTime value) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final weekday = weekdays[value.weekday - 1];
  final month = months[value.month - 1];
  return '$weekday, $month ${value.day}';
}

String _formatReminderDateTime(DateTime value, DateTime today) {
  final timeLabel = _formatReminderMinutes(value.hour * 60 + value.minute);
  if (_isSameDate(value, today)) {
    return timeLabel;
  }
  return '${_formatDate(value)} at $timeLabel';
}

String _formatHistoryDateTime(DateTime value) {
  final timeLabel = _formatReminderMinutes(value.hour * 60 + value.minute);
  return '${_formatDate(value)} at $timeLabel';
}
