import 'package:erpapp/settings/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('settings test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Settings()));
    expect(find.text('Settings'), findsOneWidget);
  });
}
