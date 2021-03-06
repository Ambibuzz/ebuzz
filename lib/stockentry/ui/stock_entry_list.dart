import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/stockentry/service/stock_entry_service.dart';
import 'package:ebuzz/stockentry/ui/stock_entry_detail.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/stockentry/model/stockentry.dart';

//StockEntryList class contains ui of list of stock entries
class StockEntryList extends StatefulWidget {
  @override
  _StockEntryListState createState() => _StockEntryListState();
}

class _StockEntryListState extends State<StockEntryList> {
  List<StockEntryModel> list = [];
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _loading = true;
    });
    list = await StockEntryService().getStockEntryList(context);
    setState(() {
      _loading = false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: Text('Stock Entry List', style: TextStyle(color: whiteColor)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
      ),
      body: _loading
          ? CircularProgress()
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        pushScreen(
                          context,
                          StockEntryDetail(
                            name: list[index].name!,
                            stockEntryModelData: list[index],
                          ),
                        );
                      },
                      child: StockEntryTileUi(
                        seData: list[index],
                      ),
                    );
                  }),
            ),
    );
  }
}

class StockEntryTileUi extends StatelessWidget {
  final StockEntryModel seData;
  const StockEntryTileUi({required this.seData});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.99,
      height: 90,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type : ' + seData.stockEntryType!,
                      style: TextStyle(fontSize: 14, color: blackColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Posting Date : ' + seData.postingDate!,
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
                      color: seData.workflowState == 'Submitted'
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
