import 'package:ebuzz/bom/service/bom_api_service.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/widgets/custom_card.dart';
import 'package:ebuzz/widgets/custom_typeahead_formfield.dart';
import 'package:ebuzz/widgets/typeahead_widgets.dart';
import 'package:ebuzz/widgets/unique_warehouse_list.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/bom/model/bom_model.dart';

List<BomModel> _bomItemCodeAndNameList = [];

//Bom class consists of ui which displays list of warehouse name and quantity based on the itemcode or itemname inputted by user
class BomUi extends StatefulWidget {
  @override
  _BomUiState createState() => _BomUiState();
}

class _BomUiState extends State<BomUi> {
  List<String> listItemCode = [];
  List<String>? warehouseName = [];
  List<double>? warehouseQuantity = [];
  TextEditingController searchController = TextEditingController();
  BomApiService _bomApiService = BomApiService();
  bool _loading = false;
  bool loading = false;
  bool apicall = false;

  @override
  void initState() {
    super.initState();
    getItemCodeList();
  }

  getItemCodeList() async {
    setState(() {
      loading = true;
    });
    listItemCode = await CommonService().getItemCodeList(context);
    print(listItemCode.length);
    setState(() {
      loading = false;
    });
    if (!mounted) return;
    setState(() {});
  }

  //For getting list of itemcode and names for particular entry of bom
  bomListData() async {
    _bomItemCodeAndNameList.clear();
    if (!mounted) return;
    setState(() {
      _loading = true;
    });
    _bomItemCodeAndNameList = await _bomApiService.getBomItemCodeAndNameList(
        searchController.text, context);
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
    if (!mounted) return;
    setState(() {});
  }

  search() async {
    if (searchController.text.isNotEmpty) {
      bomListData();
    }
    if (searchController.text.isEmpty) {
      fluttertoast(
          whiteColor, blueAccent, 'Search field should not be empty  ');
    }
    // apicall is set to true here for doing api call once search button is pressed and text is not empty
    apicall = true;
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemCodeWidget = _bomItemCodeAndNameList
        .map<Widget>((item) => ItemCodes(
              itemCode: item.itemCode,
              itemName: item.name,
            ))
        .toList();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: Text('BOM', style: TextStyle(color: whiteColor)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
      ),
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    searchField(),
                    SizedBox(
                      height: 15,
                    ),
                    searchButton(),
                    apicall
                        ? _loading
                            ? Container(
                                height: displayHeight(context) * 0.55,
                                child: CircularProgress())
                            : Column(children: itemCodeWidget)
                        : Container()
                  ],
                ),
              ),
            ),
    );
  }

  Widget searchButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        width: displayWidth(context),
        height: 50,
        child: RoundButton(
          child:
              Text('Search', style: TextStyle(fontSize: 16, color: whiteColor)),
          onPressed: _loading ? null : search,
          primaryColor: blueAccent,
          onPrimaryColor: whiteColor,
        ),
      ),
    );
  }

  Widget searchField() {
    return CustomTypeAheadFormField(
      controller: searchController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Search',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        searchController.text = suggestion;
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, listItemCode);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) =>
          val == '' || val == null ? 'Search field should not be empty' : null,
    );
  }
}

class ItemCodes extends StatefulWidget {
  final String? itemCode;
  final String? itemName;
  ItemCodes({this.itemCode, this.itemName});
  @override
  _ItemCodesState createState() => _ItemCodesState();
}

class _ItemCodesState extends State<ItemCodes> {
  List<String> warehouseName = [];
  List<double> warehouseQuantity = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    warehouseName =
        await CommonService().getWareHouseNameData(widget.itemCode!, context);
    warehouseQuantity =
        await CommonService().getWareHouseQtyData(widget.itemCode!, context);
    setState(() {
      loading = false;
    });
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgress()
        : (_bomItemCodeAndNameList.length == 0
            ? Center(
                child: Text('No Data',
                    style: TextStyle(fontSize: 16, color: whiteColor)),
              )
            : CustomCard(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Code : ' + widget.itemCode!,
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Item Name : ' + widget.itemName!,
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                      SizedBox(height: 5),
                      UniqueWarehouseList(
                        warehouseName: warehouseName,
                        warehouseQty: warehouseQuantity,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
