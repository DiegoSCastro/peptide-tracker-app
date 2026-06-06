import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/app/app.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/onboarding/data/app_launch_repository.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound_category.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_schedule_type.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/repositories/protocols_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_support/noop_log_entries_repository.dart';

void main() {
  Future<void> pumpAppWithAcceptedDisclaimer(
    WidgetTester tester,
    ProtocolsRepository repository,
  ) async {
    SharedPreferences.setMockInitialValues({
      'legal.acceptedDisclaimerVersion': currentDisclaimerVersion,
      'legal.acceptedAt': DateTime.utc(2026, 6, 5).toIso8601String(),
      'settings.notificationsPromptSeen': true,
      'protocols.firstProtocol': '{"name":"Morning routine"}',
    });

    await tester.pumpWidget(
      App(
        protocolsRepository: repository,
        logEntriesRepository: const NoopLogEntriesRepository(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
  }

  group('Protocols management flow', () {
    testWidgets(
      'shows a free-tier intercept when a second active routine is attempted',
      (
        tester,
      ) async {
        final repository = _InMemoryProtocolsRepository(
          initialItems: [
            _managedProtocol(
              name: 'Morning routine',
              compoundName: 'Compound A',
            ),
          ],
        );
        addTearDown(repository.dispose);

        await pumpAppWithAcceptedDisclaimer(tester, repository);

        await tester.tap(find.text('Protocols').last);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200));

        expect(find.text('1 of 1 free routines used'), findsOneWidget);
        expect(find.text('Morning routine'), findsOneWidget);

        await tester.tap(find.text('New protocol'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200));

        expect(find.text('Free includes 1 active routine'), findsOneWidget);
        expect(find.text('Upgrade to Pro'), findsOneWidget);
        expect(find.text('Keep current routine'), findsOneWidget);
      },
    );

    testWidgets('allows editing, pausing, and deleting the current routine', (
      tester,
    ) async {
      final repository = _InMemoryProtocolsRepository(
        initialItems: [
          _managedProtocol(name: 'Morning routine', compoundName: 'Compound A'),
        ],
      );
      addTearDown(repository.dispose);

      await pumpAppWithAcceptedDisclaimer(tester, repository);

      await tester.tap(find.text('Protocols').last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      await tester.tap(find.text('View'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Compound A • GLP-1'), findsOneWidget);

      await tester.tap(find.text('Edit'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Protocol name'),
        'Paused routine',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Compound label'),
        'Compound X',
      );

      await tester.tap(find.text('Save routine'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Paused routine'), findsWidgets);
      expect(find.text('Compound X • GLP-1'), findsOneWidget);

      await tester.tap(find.text('Pause routine'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Routine paused'), findsOneWidget);
      expect(find.text('Inactive'), findsOneWidget);

      await tester.tap(find.text('Delete routine'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.tap(find.text('Delete'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('No routines yet'), findsOneWidget);
      expect(
        find.text('Create a routine to organize your schedule and reminders.'),
        findsOneWidget,
      );
    });
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
      notes: 'Weekly tracker',
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
    return TaskEither.tryCatch(
      () async {
        final activeProtocols = _items.where((item) {
          return item.protocol.isActive && item.protocol.id != draft.protocolId;
        }).length;
        if (draft.isActive && activeProtocols >= 1) {
          throw const ProtocolLimitReachedFailure();
        }

        final now = DateTime.now().toUtc();
        final protocolId = draft.protocolId ?? 'pro-${_items.length + 1}';
        final compoundId = draft.compoundId ?? 'cmp-${_items.length + 1}';

        final item = ManagedProtocol(
          protocol: Protocol(
            id: protocolId,
            compoundId: compoundId,
            name: draft.protocolName,
            plannedAmount: draft.plannedAmount,
            unitLabel: draft.unitLabel,
            scheduleType: draft.scheduleType,
            intervalDays: draft.intervalDays,
            reminderMinutesAfterMidnight: draft.reminderMinutesAfterMidnight,
            startDate: draft.startDate,
            isActive: draft.isActive,
            notes: draft.notes,
            createdAt: now,
            updatedAt: now,
          ),
          compound: Compound(
            id: compoundId,
            name: draft.compoundName,
            category: draft.compoundCategory,
            defaultUnit: draft.unitLabel,
            notes: draft.notes,
            isArchived: false,
            createdAt: now,
            updatedAt: now,
          ),
        );

        final existingIndex = _items.indexWhere(
          (entry) => entry.protocol.id == protocolId,
        );
        if (existingIndex == -1) {
          _items.add(item);
        } else {
          _items[existingIndex] = item;
        }
        _changes.add(List.unmodifiable(_items));
        return unit;
      },
      (error, _) {
        if (error is AppFailure) {
          return error;
        }
        return const StorageFailure();
      },
    );
  }

  @override
  TaskEither<AppFailure, Unit> delete(String protocolId) {
    return TaskEither.tryCatch(() async {
      _items.removeWhere((entry) => entry.protocol.id == protocolId);
      _changes.add(List.unmodifiable(_items));
      return unit;
    }, (_, _) => const StorageFailure());
  }

  @override
  TaskEither<AppFailure, Unit> setActive({
    required String protocolId,
    required bool isActive,
  }) {
    return TaskEither.tryCatch(
      () async {
        final index = _items.indexWhere(
          (entry) => entry.protocol.id == protocolId,
        );
        if (index == -1) {
          return unit;
        }

        if (isActive &&
            _items.any(
              (entry) =>
                  entry.protocol.isActive && entry.protocol.id != protocolId,
            )) {
          throw const ProtocolLimitReachedFailure();
        }

        final current = _items[index];
        _items[index] = ManagedProtocol(
          protocol: Protocol(
            id: current.protocol.id,
            compoundId: current.protocol.compoundId,
            name: current.protocol.name,
            plannedAmount: current.protocol.plannedAmount,
            unitLabel: current.protocol.unitLabel,
            scheduleType: current.protocol.scheduleType,
            intervalDays: current.protocol.intervalDays,
            reminderMinutesAfterMidnight:
                current.protocol.reminderMinutesAfterMidnight,
            startDate: current.protocol.startDate,
            isActive: isActive,
            notes: current.protocol.notes,
            createdAt: current.protocol.createdAt,
            updatedAt: DateTime.now().toUtc(),
          ),
          compound: current.compound,
        );
        _changes.add(List.unmodifiable(_items));
        return unit;
      },
      (error, _) {
        if (error is AppFailure) {
          return error;
        }
        return const StorageFailure();
      },
    );
  }

  Future<void> dispose() async {
    await _changes.close();
  }
}
