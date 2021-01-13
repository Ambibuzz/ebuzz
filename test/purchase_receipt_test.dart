import 'package:erpapp/purchasereciept/ui/purchase_reciept_Form_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('purchase receipt test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: PurchaseRecieptFormUi(
      name: 'a',
      supplier: 'a',
    )));
    expect(find.text('Purchase Reciept'), findsOneWidget);
  });

}
