import 'package:erpapp/leavebalance/ui/leave_balance_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('work order test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LeaveUi()));
    expect(find.text('Leave Balance'), findsOneWidget);
    expect(find.text('Privilege Leave'), findsOneWidget);
    expect(find.text('Concessional Leave'), findsOneWidget);
    expect(find.text('Leave Without Pay'), findsOneWidget);
    expect(find.text('Compensatory Off'), findsOneWidget);
  });
}
