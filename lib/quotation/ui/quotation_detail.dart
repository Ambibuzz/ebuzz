import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
import 'package:ebuzz/quotation/model/quotation.dart';
import 'package:ebuzz/quotation/model/quotation_item.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';

class QuotationDetail extends StatelessWidget {
  final Quotation quotation;
  final List<QuotationItem> quotationItems;

  QuotationDetail({
    required this.quotation,
    required this.quotationItems,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: Text('Quotation Detail', style: TextStyle(color: whiteColor)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: versionText(),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  quotationDetailWidget('Name', quotation.name),
                  SizedBox(height: 15),
                  quotationDetailWidget('Quotation To', quotation.quotationTo),
                  SizedBox(height: 15),
                  quotationDetailWidget(
                      'Customer Name', quotation.customerName),
                  SizedBox(height: 15),
                  quotationDetailWidget('Company', quotation.company),
                  SizedBox(height: 15),
                  quotationDetailWidget('Date', quotation.date),
                  SizedBox(height: 15),
                  quotationDetailWidget('Order Type', quotation.orderType),
                  SizedBox(height: 15),
                  quotationDetailWidget(
                      'Total Quantity', quotation.totalQuantity.toString()),
                  SizedBox(height: 15),
                  quotationDetailWidget(
                      'Total (INR)', quotation.quotationTo.toString()),
                  SizedBox(height: 15),
                  quotationDetailWidget(
                      'Total Net Weight', quotation.totalNetWeight.toString()),
                  SizedBox(height: 15),
                  quotationDetailWidget(
                      'Grand Total', quotation.grandTotal.toString()),
                  SizedBox(height: 15),
                  quotationDetailWidget(
                      'Round Total', quotation.roundedTotal.toString()),
                  SizedBox(height: 15),
                  quotationDetailWidget('In Words', quotation.inWords),
                  SizedBox(height: 15),
                  Column(
                    children: [
                      scrollToViewTableBelow(context),
                      SizedBox(
                        height: 5,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: <DataColumn>[
                            tableColumnText(context, 'Item Code'),
                            tableColumnText(context, 'Item Name'),
                            tableColumnText(context, 'Quantity'),
                            tableColumnText(context, 'Rate'),
                            tableColumnText(context, 'Amount'),
                          ],
                          rows: quotationItems
                              .map((data) => DataRow(cells: <DataCell>[
                                    dataCellText(context, data.itemCode ?? '',
                                        displayWidth(context) * 0.3),
                                    dataCellText(context, data.itemName ?? '',
                                        displayWidth(context) * 0.7),
                                    dataCellText(context, data.qty.toString(),
                                        displayWidth(context) * 0.3),
                                    dataCellText(context, data.rate.toString(),
                                        displayWidth(context) * 0.3),
                                    dataCellText(
                                        context,
                                        data.amount.toString(),
                                        displayWidth(context) * 0.3),
                                  ]))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget quotationDetailWidget(String label, String value) {
    return CustomTextFormField(
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: label,
      readOnly: true,
      initialValue: value,
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }
}
