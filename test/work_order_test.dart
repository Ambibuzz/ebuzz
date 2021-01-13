import 'package:erpapp/workorder/ui/workorder_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('work order test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WorkOrderUi()));
    expect(find.text('Work Order'), findsOneWidget);
  });
}
