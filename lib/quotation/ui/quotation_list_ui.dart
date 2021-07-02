import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
import 'package:ebuzz/quotation/model/quotation.dart';
import 'package:ebuzz/quotation/model/quotation_item.dart';
import 'package:ebuzz/quotation/service/quotation_service.dart';
import 'package:ebuzz/quotation/ui/quotation_detail.dart';
import 'package:flutter/material.dart';

class QuotationListUi extends StatefulWidget {
  @override
  _QuotationListUiState createState() => _QuotationListUiState();
}

class _QuotationListUiState extends State<QuotationListUi> {
  List<Quotation> quotations = [];
  QuotationService _quotationService = QuotationService();

  void fetchQuotations() async {
    quotations = await _quotationService.getQuotationList(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchQuotations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: Text('Quotations List', style: TextStyle(color: whiteColor)),
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: quotations.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Quotation quotation = quotations[index];
                  return GestureDetector(
                    onTap: () async {
                      List<QuotationItem> qoItems = await _quotationService
                          .getQuotationItemsList(quotation.name, context);
                      pushScreen(
                          context,
                          QuotationDetail(
                            quotation: quotations[index],
                            quotationItems: qoItems,
                          ));
                    },
                    child: QuotationTileUi(
                      quotation: quotation,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class QuotationTileUi extends StatelessWidget {
  final Quotation quotation;
  const QuotationTileUi({required this.quotation});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.99,
      height: 90,
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name : ' + quotation.name,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Date : ' + quotation.date,
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: quotation.status == 'Submitted'
                          ? greenColor
                          : blackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
