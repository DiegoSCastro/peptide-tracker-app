import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_tracker_app/src/features/calculator/presentation/view/calculator_page.dart';

void main() {
  Future<void> pumpCalculator(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CalculatorPage()),
    );
    await tester.pumpAndSettle();
  }

  TextFormField fieldByLabel(WidgetTester tester, String label) {
    return tester.widget<TextFormField>(
      find.widgetWithText(TextFormField, label),
    );
  }

  List<EditableText> editableFields(WidgetTester tester) {
    return tester.widgetList<EditableText>(find.byType(EditableText)).toList();
  }

  group('CalculatorPage', () {
    testWidgets('shows compliance-safe framing with empty manual inputs', (
      tester,
    ) async {
      await pumpCalculator(tester);

      expect(find.text('User-input calculator'), findsOneWidget);
      expect(find.text('Simple calculator'), findsOneWidget);
      expect(
        find.text('For user-input math only. Not a dose recommendation.'),
        findsOneWidget,
      );
      expect(find.text('Enter values manually'), findsOneWidget);
      expect(find.text('No result yet'), findsOneWidget);

      expect(fieldByLabel(tester, 'Vial amount').controller!.text, isEmpty);
      expect(fieldByLabel(tester, 'Dilution volume').controller!.text, isEmpty);
      expect(fieldByLabel(tester, 'Desired amount').controller!.text, isEmpty);
    });

    testWidgets('makes manual entry fast with keyboard-friendly fields', (
      tester,
    ) async {
      await pumpCalculator(tester);

      final fields = editableFields(tester);

      expect(fields, hasLength(3));
      expect(fields[0].autofocus, isTrue);
      expect(fields[0].textInputAction, TextInputAction.next);
      expect(fields[1].textInputAction, TextInputAction.next);
      expect(fields[2].textInputAction, TextInputAction.done);
    });

    testWidgets('calculates from manual input and keeps disclaimer visible', (
      tester,
    ) async {
      await pumpCalculator(tester);

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
      await tester.pumpAndSettle();

      expect(find.text('Volume to draw: 0.05 mL'), findsOneWidget);
      expect(
        find.text('For user-input math only. Not a dose recommendation.'),
        findsOneWidget,
      );
      expect(
        find.text('Double-check your entries before using this result.'),
        findsOneWidget,
      );
    });
  });
}
