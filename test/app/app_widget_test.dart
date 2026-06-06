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
  testWidgets('returning users can open the calculator from the main shell', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferences.setMockInitialValues({
      'legal.acceptedDisclaimerVersion': currentDisclaimerVersion,
      'legal.acceptedAt': DateTime.utc(2026, 6, 5).toIso8601String(),
      'protocols.firstProtocol': '{"name":"Morning routine"}',
    });

    final repository = _InMemoryProtocolsRepository(
      initialItems: [
        _managedProtocol(name: 'Morning routine', compoundName: 'Semaglutide'),
      ],
    );
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

    expect(find.text('Today'), findsWidgets);

    await tester.ensureVisible(find.text('Calculator').last);
    await tester.tap(find.text('Calculator').last);
    await settleApp();

    expect(find.text('User-input calculator'), findsOneWidget);
    expect(find.text('Enter values manually'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Vial amount'),
      '10',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Dilution volume'),
      '2',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Desired amount'),
      '0.25',
    );

    await tester.ensureVisible(find.text('Calculate'));
    await tester.tap(find.text('Calculate'));
    await settleApp();

    expect(find.text('Volume to draw: 0.05 mL'), findsOneWidget);
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
