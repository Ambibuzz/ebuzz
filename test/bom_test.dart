import 'package:ebuzz/bom/ui/bom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('bom test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Bom()));
    expect(find.text('BOM'), findsOneWidget);
  });
}
