import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:peptide_tracker_app/app/app.dart';
import 'package:peptide_tracker_app/src/core/failures/app_failure.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/compound.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/managed_protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/entities/protocol_editor_draft.dart';
import 'package:peptide_tracker_app/src/features/protocols/domain/repositories/protocols_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../test_support/noop_log_entries_repository.dart';

void main() {
  testWidgets(
    'requires explicit disclaimer acceptance before creating the first'
    ' protocol',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final repository = _InMemoryProtocolsRepository();
      addTearDown(repository.dispose);

      Future<void> settleApp() async {
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pumpWidget(
        App(
          protocolsRepository: repository,
          logEntriesRepository: const NoopLogEntriesRepository(),
        ),
      );
      await settleApp();

      expect(find.text('Private peptide and GLP-1 tracker'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);

      await tester.tap(find.text('Continue'));
      await settleApp();

      expect(find.text('Medical and safety notice'), findsOneWidget);
      expect(
        find.text(
          'I understand this app is a tracking tool and not medical advice.',
        ),
        findsOneWidget,
      );
      expect(find.text('I understand'), findsNothing);

      await tester.tap(find.text('Continue'));
      await settleApp();

      expect(find.text('Create first routine'), findsNothing);

      await tester.tap(find.byType(CheckboxListTile));
      await settleApp();

      await tester.tap(find.text('I understand'));
      await settleApp();

      expect(find.text('Reminder intro'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      await settleApp();

      expect(find.text('Create first routine'), findsOneWidget);
      expect(
        find.text(
          'Create a routine to organize your own schedule and records.',
        ),
        findsOneWidget,
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Protocol name'),
        'Morning routine',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Compound label'),
        'Semaglutide',
      );

      await tester.ensureVisible(find.text('Save routine'));
      await tester.tap(find.text('Save routine'));
      await settleApp();
      await settleApp();

      expect(find.text('Today'), findsWidgets);
      expect(find.text('Open quick log'), findsOneWidget);
      expect(
        find.text('Tap + Log when you want to save a record.'),
        findsOneWidget,
      );
    },
  );
}

class _InMemoryProtocolsRepository implements ProtocolsRepository {
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
    return TaskEither.tryCatch(() async {
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
    }, (_, _) => const StorageFailure());
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
    return TaskEither.right(unit);
  }

  Future<void> dispose() async {
    await _changes.close();
  }
}
