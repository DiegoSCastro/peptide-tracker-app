import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/app/app.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_draft.dart';
import 'package:peptide_tracker_app/src/features/history/domain/entities/log_entry_status.dart';
import 'package:peptide_tracker_app/src/features/history/domain/repositories/log_entries_repository.dart';
import 'package:peptide_tracker_app/src/features/onboarding/data/app_launch_repository.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/repositories/protocols_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<void> pumpAppWithAcceptedDisclaimer(
    WidgetTester tester, {
    required ProtocolsRepository protocolsRepository,
    required LogEntriesRepository logEntriesRepository,
  }) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferences.setMockInitialValues({
      'legal.acceptedDisclaimerVersion': currentDisclaimerVersion,
      'legal.acceptedAt': DateTime.utc(2026, 6, 5).toIso8601String(),
      'settings.notificationsPromptSeen': true,
      'protocols.firstProtocol': '{"name":"Morning routine"}',
    });

    await tester.pumpWidget(
      App(
        protocolsRepository: protocolsRepository,
        logEntriesRepository: logEntriesRepository,
        now: () => DateTime.utc(2026, 6, 8, 9),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
  }

  testWidgets('quick log saves a record visible on Today and History', (
    tester,
  ) async {
    final protocolsRepository = _InMemoryProtocolsRepository(
      initialItems: [
        _managedProtocol(name: 'Morning routine', compoundName: 'Semaglutide'),
      ],
    );
    final logEntriesRepository = _InMemoryLogEntriesRepository();
    addTearDown(protocolsRepository.dispose);
    addTearDown(logEntriesRepository.dispose);

    await pumpAppWithAcceptedDisclaimer(
      tester,
      protocolsRepository: protocolsRepository,
      logEntriesRepository: logEntriesRepository,
    );

    expect(find.text('Today'), findsWidgets);
    expect(find.text('Log Dose'), findsOneWidget);

    await tester.ensureVisible(find.text('Log Dose'));
    await tester.tap(find.text('Log Dose'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Save log'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Note (optional)'),
      'Logged before breakfast',
    );

    await tester.tap(find.text('Save log'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Log saved'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Logged Morning routine'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Logged Morning routine'), findsOneWidget);
    expect(find.text('Logged before breakfast'), findsWidgets);

    await tester.tap(find.text('Progress').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('History timeline'), findsWidgets);
    expect(find.text('Morning routine'), findsOneWidget);
    expect(find.text('Semaglutide • Done • 0.25 mg'), findsOneWidget);
    expect(find.text('Logged before breakfast'), findsOneWidget);
  });

  testWidgets('today dashboard links quick actions and full history view', (
    tester,
  ) async {
    final protocolsRepository = _InMemoryProtocolsRepository(
      initialItems: [
        _managedProtocol(name: 'Morning routine', compoundName: 'Semaglutide'),
      ],
    );
    final logEntriesRepository = _InMemoryLogEntriesRepository();
    addTearDown(protocolsRepository.dispose);
    addTearDown(logEntriesRepository.dispose);

    await logEntriesRepository
        .create(
          LogEntryDraft(
            protocolId: 'pro-1',
            loggedAt: DateTime.utc(2026, 6, 7, 9),
            amount: 0.25,
            status: LogEntryStatus.done,
            note: 'Yesterday check-in',
            createdFromReminder: false,
            unitLabel: 'mg',
          ),
        )
        .run();

    await pumpAppWithAcceptedDisclaimer(
      tester,
      protocolsRepository: protocolsRepository,
      logEntriesRepository: logEntriesRepository,
    );
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Quick actions'), findsOneWidget);
    expect(find.text('Log Dose'), findsOneWidget);
    expect(find.text('View History'), findsOneWidget);

    await tester.ensureVisible(find.text('View History'));
    await tester.tap(find.text('View History'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('History timeline'), findsOneWidget);
    expect(find.text('Yesterday check-in'), findsOneWidget);

    await tester.tap(find.text('Back to today'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    await tester.ensureVisible(find.text('Log Dose'));
    await tester.tap(find.text('Log Dose'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Save log'), findsOneWidget);
  });
}

ManagedProtocol _managedProtocol({
  required String name,
  required String compoundName,
}) {
  final now = DateTime.utc(2026, 6, 5);
  return ManagedProtocol(
    protocol: Protocol(
      id: 'pro-1',
      compoundId: 'cmp-1',
      name: name,
      plannedAmount: 0.25,
      unitLabel: 'mg',
      scheduleType: ProtocolScheduleType.everyNDays,
      intervalDays: 7,
      reminderMinutesAfterMidnight: 9 * 60,
      startDate: DateTime.utc(2026, 6, 8),
      isActive: true,
      notes: '',
      createdAt: now,
      updatedAt: now,
    ),
    compound: Compound(
      id: 'cmp-1',
      name: compoundName,
      category: CompoundCategory.glp1,
      defaultUnit: 'mg',
      notes: '',
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    ),
  );
}

class _InMemoryProtocolsRepository implements ProtocolsRepository {
  _InMemoryProtocolsRepository({List<ManagedProtocol>? initialItems}) {
    if (initialItems != null) {
      _items.addAll(initialItems);
    }
  }

  final _items = <ManagedProtocol>[];
  final _changes = StreamController<List<ManagedProtocol>>.broadcast();

  Stream<List<ManagedProtocol>> _watchItems() async* {
    yield List.unmodifiable(_items);
    yield* _changes.stream;
  }

  @override
  Stream<List<ManagedProtocol>> watchAll() => _watchItems();

  @override
  TaskEither<AppFailure, Unit> saveDraft(ProtocolEditorDraft draft) {
    return TaskEither.right(unit);
  }

  @override
  TaskEither<AppFailure, Unit> delete(String protocolId) {
    return TaskEither.right(unit);
  }

  @override
  TaskEither<AppFailure, Unit> setActive({
    required String protocolId,
    required bool isActive,
  }) {
    return TaskEither.right(unit);
  }

  Future<void> dispose() async {
    await _changes.close();
  }
}

class _InMemoryLogEntriesRepository implements LogEntriesRepository {
  final _entries = <LogEntry>[];
  final _changes = StreamController<List<LogEntry>>.broadcast();

  Stream<List<LogEntry>> _watchEntries() async* {
    yield List.unmodifiable(_entries);
    yield* _changes.stream;
  }

  @override
  TaskEither<AppFailure, Unit> create(LogEntryDraft draft) {
    return TaskEither.tryCatch(() async {
      final now = DateTime.now().toUtc();
      _entries.insert(
        0,
        LogEntry(
          id: 'log-${_entries.length + 1}',
          protocolId: draft.protocolId,
          compoundId: 'cmp-1',
          loggedAt: draft.loggedAt,
          status: draft.status,
          amount: draft.amount,
          unitLabel: draft.unitLabel ?? 'mg',
          note: draft.note,
          createdFromReminder: draft.createdFromReminder,
          protocolNameSnapshot: 'Morning routine',
          compoundNameSnapshot: 'Semaglutide',
          createdAt: now,
          updatedAt: now,
        ),
      );
      _changes.add(List.unmodifiable(_entries));
      return unit;
    }, (_, _) => const StorageFailure());
  }

  @override
  Stream<List<LogEntry>> watchByDateRange(DateTime start, DateTime end) {
    return _watchEntries().map(
      (entries) => entries
          .where((entry) {
            return !entry.loggedAt.isBefore(start) &&
                !entry.loggedAt.isAfter(end);
          })
          .toList(growable: false),
    );
  }

  @override
  Stream<List<LogEntry>> watchByProtocol(String protocolId) {
    return _watchEntries().map(
      (entries) => entries
          .where((entry) => entry.protocolId == protocolId)
          .toList(growable: false),
    );
  }

  @override
  Stream<List<LogEntry>> watchRecent({int limit = 20}) {
    return _watchEntries().map(
      (entries) => entries.take(limit).toList(growable: false),
    );
  }

  Future<void> dispose() async {
    await _changes.close();
  }
}
