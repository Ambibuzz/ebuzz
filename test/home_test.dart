import 'package:erpapp/home/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Check if homepage contains all widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    expect(find.text('BOM'), findsOneWidget);
    expect(find.text('Item'), findsOneWidget);
    expect(find.text('Purchase Order'), findsOneWidget);
    expect(find.text('Leave Balance'), findsOneWidget);
  });
}
