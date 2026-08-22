// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';

void main() {
  testWidgets('TaskFlow opens the dashboard and task list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('TaskFlow'), findsOneWidget);
    expect(find.text('Up next'), findsOneWidget);

    await tester.tap(find.text('See all'));
    await tester.pumpAndSettle();

    expect(find.text('All tasks'), findsOneWidget);
    expect(find.text('Search tasks'), findsOneWidget);
  });
}
