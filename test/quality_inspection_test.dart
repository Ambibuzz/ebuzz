import 'package:erpapp/qualityinspection/ui/qiform1.dart';
import 'package:erpapp/qualityinspection/ui/qiform2.dart';
import 'package:erpapp/qualityinspection/ui/qiform3.dart';
import 'package:erpapp/qualityinspection/ui/qiform4.dart';
import 'package:erpapp/qualityinspection/ui/qiform5.dart';
import 'package:erpapp/qualityinspection/ui/quality_inspection_list_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('quality inspection list test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: QualityInspectionListUi()));
    expect(find.text('Quality Inspection'), findsOneWidget);
  });

  testWidgets('quality inspection form1 test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: QiForm1()));
    expect(find.text('Quality Inspection Form'), findsOneWidget);
    expect(find.byKey(Key('date-field-form1')), findsOneWidget);
    expect(find.byKey(Key('inspection-type-field-form1')), findsOneWidget);
    expect(find.byKey(Key('reference-type-field-form1')), findsOneWidget);
  });

  testWidgets('quality inspection form2 test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: QiForm2(
        date: 'a',
        inspectionType: 'a',
        referenceType: 'a',
      ),
    ));
    expect(find.text('Quality Inspection Form'), findsOneWidget);
    expect(find.text('Report Date'), findsOneWidget);
    expect(find.text('Inspection Type'), findsOneWidget);
    expect(find.text('Reference Type'), findsOneWidget);
    expect(find.byKey(Key('reference-name-field-form2')), findsOneWidget);
  });

  testWidgets('quality inspection form3 test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: QiForm3(
        date: 'a',
        inspectionType: 'a',
        referenceType: 'a',
        referenceName: 'a',
      ),
    ));
    expect(find.text('Quality Inspection Form'), findsOneWidget);
    expect(find.text('Report Date'), findsOneWidget);
    expect(find.text('Inspection Type'), findsOneWidget);
    expect(find.text('Reference Type'), findsOneWidget);
    expect(find.text('Reference Name'), findsOneWidget);
    expect(find.byKey(Key('item-name-field-form3')), findsOneWidget);
  });

  testWidgets('quality inspection form4 test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: QiForm4(
          date: 'a',
          inspectionType: 'a',
          referenceType: 'a',
          referenceName: 'a',
          itemCode: 'a',
        ),
      ),
    );
    expect(find.text('Quality Inspection Form'), findsOneWidget);
  });

  testWidgets('quality inspection form5 test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: QiForm5(
        date: 'a',
        inspectionType: 'a',
        referenceType: 'a',
        referenceName: 'a',
        itemCode: 'a',
        itemName: 'a',
        qiTemplate: 'a',
        sampleSize: 0,
        status: 'a',
      ),
    ));
    expect(find.text('Save'), findsOneWidget);
  });
}
