import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_tracker_app/app/app.dart';

void main() {
  testWidgets('renders peptide tracker home', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Peptide Tracker'), findsOneWidget);
    expect(
      find.text('A simple MVVM starter for a peptide tracking app.'),
      findsOneWidget,
    );
    expect(find.text('GLP-1 Overview'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('Next MVP steps'), findsOneWidget);
  });
}
