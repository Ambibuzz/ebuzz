import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/bom/service/bom_api_service.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/item/service/item_api_service.dart';
import 'package:ebuzz/widgets/unique_warehouse_list.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/bom/model/bom_model.dart';

List<BomModel> _bomItemCodeAndNameList = [];

//Bom class consists of ui which displays list of warehouse name and quantity based on the itemcode or itemname inputted by user
class Bom extends StatefulWidget {
  @override
  _BomState createState() => _BomState();
}

class _BomState extends State<Bom> {
  List<String> listItemCode = [];
  List<String> warehouseName = [];
  List<double> warehouseQuantity = [];
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
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
    List listData = await _bomApiService.getItemCodeList();
    for (int i = 0; i < listData.length; i++) {
      listItemCode.add(listData[i]['item_code']);
    }
    setState(() {
      loading = false;
    });
    if (!mounted) return;
    setState(() {});
  }

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item,
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyle(color: greyDarkColor, fontSize: 16)),
    );
  }

  //For getting list of itemcode and names for particular entry of bom
  bomListData() async {
    _bomItemCodeAndNameList.clear();
    if (!mounted) return;
    setState(() {
      _loading = true;
    });
    _bomItemCodeAndNameList =
        await _bomApiService.getBomItemCodeAndNameList(searchController.text);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'BOM',
        ),
      ),
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
              child: Column(
                children: [
                  searchField(),
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
    );
  }

  Widget searchButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        height: displayWidth(context) > 600 ? 80 : 50,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: blueAccent,
          onPressed: _loading ? null : search,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: displayWidth(context) > 600 ? 29 : 10),
            child: Text(
              'Search',
              style: displayWidth(context) > 600
                  ? TextStyle(fontSize: 28, color: whiteColor)
                  : TextStyles.t16White,
            ),
          ),
        ),
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: AutoCompleteTextField<String>(
        controller: searchController,
        itemSubmitted: (item) {
          searchController.text = item;
        },
        key: key,
        clearOnSubmit: false,
        style: displayWidth(context) > 600
            ? TextStyle(fontSize: 28, color: blackColor)
            : TextStyle(color: greyDarkColor, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: blackColor,
                width: displayWidth(context) > 600 ? 3 : 1,
                style: BorderStyle.solid),
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600 ? 30 : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          labelText: 'Search Item',
        ),
        suggestions: listItemCode,
        itemBuilder: (context, item) {
          return itemUi(item);
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        },
      ),
    );
  }
}

class ItemCodes extends StatefulWidget {
  final String itemCode;
  final String itemName;
  ItemCodes({this.itemCode, this.itemName});
  @override
  _ItemCodesState createState() => _ItemCodesState();
}

class _ItemCodesState extends State<ItemCodes> {
  List<String> warehouseName = [];
  List<double> warehouseQuantity = [];
  ItemApiService _itemApiService = ItemApiService();
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
    warehouseName = await _itemApiService.getWareHouseNameData(widget.itemCode);
    warehouseQuantity =
        await _itemApiService.getWareHouseQtyData(widget.itemCode);
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
                    style: displayWidth(context) > 600
                        ? TextStyle(fontSize: 28, color: whiteColor)
                        : TextStyles.t16White),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Item Code : ' + widget.itemCode,
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 32,
                              color: blackColor,
                              fontWeight: FontWeight.bold)
                          : TextStyles.t18BlackBold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Item Name : ' + widget.itemName,
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 32,
                              color: blackColor,
                              fontWeight: FontWeight.bold)
                          : TextStyles.t18BlackBold,
                    ),
                  ),
                  UniqueWarehouseList(
                    warehouseName: warehouseName,
                    warehouseQty: warehouseQuantity,
                  ),
                ],
              ));
  }
}
