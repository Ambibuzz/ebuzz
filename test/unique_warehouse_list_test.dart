import 'package:erpapp/widgets/unique_warehouse_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('unique warehouse test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: UniqueWarehouseList(
      warehouseName: ['A'],
      warehouseQty: [100],
    )));
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Quantity'), findsOneWidget);
  });
}
