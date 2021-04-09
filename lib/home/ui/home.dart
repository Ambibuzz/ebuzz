import 'dart:convert';
import 'dart:io';
import 'package:ebuzz/b2b/cart/model/cart.dart';
import 'package:ebuzz/b2b/cart/state/state_manager.dart';
import 'package:ebuzz/b2b/items/ui/items_ui.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/navigations.dart';
// import 'package:ebuzz/fileupload/file_upload.dart';
import 'package:ebuzz/home/service/home_service.dart';
import 'package:ebuzz/item/ui/item_ui.dart';
import 'package:ebuzz/leavebalance/ui/leave_balance_ui.dart';
import 'package:ebuzz/logout/service/logout_api_service.dart';
import 'package:ebuzz/purchaseorder/ui/purchase_order_ui.dart';
import 'package:ebuzz/qualityinspection/ui/quality_inspection_list_ui.dart';
import 'package:ebuzz/salesorder/ui/sales_order_list_ui.dart';
import 'package:ebuzz/settings/ui/settings.dart';
import 'package:ebuzz/stockentry/ui/stock_entry_list.dart';
import 'package:ebuzz/util/constants.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:ebuzz/workorder/ui/workorder_ui.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/bom/ui/bom.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/leavelist/ui/leave_list_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Home class displays ui of different functionalities in form of cards
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  LogOutApiService _logOutApiProvider = LogOutApiService();

  String apiurl;
  String cookie;
  String name;
  bool loading = false;
  Choice _selectedChoice = choices[0];
  var storage = FlutterSecureStorage();

  //List of choices when user clicks on menu button in top right
  static List<Choice> choices = <Choice>[
    Choice(title: 'Settings', icon: Icons.settings),
    Choice(title: 'Logout', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String cartSave = await storage.read(key: cartKey);
      if (cartSave != null && cartSave.isNotEmpty) {
        final listCart = json.decode(cartSave) as List<dynamic>;
        final listCartParsed =
            listCart.map((model) => Cart.fromJson(model)).toList();
        if (listCartParsed != null && listCartParsed.length > 0) {
          context.read(cartListProvider).state = listCartParsed;
        }
      }
    });
    getPrefs();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      HomeService().checkLoginStatus('11019');
    }
  }

  getPrefs() async {
    apiurl = await getApiUrl();
    cookie = await getCookie();
    name = await getName();
    setState(() {});
  }


  logout(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await _logOutApiProvider.logOut(context, apiurl);
    setState(() {
      loading = false;
    });
  }

  //function for selecting choice of user and performing action based on their choice
  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
      if (_selectedChoice == choices[0]) {
        pushScreen(context, Settings());
      }
      if (_selectedChoice == choices[1]) {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: Text(
                'LogOut?',
                style: displayWidth(context) > 600
                    ? TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                    : TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Are you sure you wan\'t to logout',
                style: displayWidth(context) > 600
                    ? TextStyle(fontSize: 26)
                    : TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);
                    await logout(context);
                  },
                  child: Text(
                    'Ok',
                    style: displayWidth(context) > 600
                        ? TextStyle(fontSize: 26, color: blueAccent)
                        : TextStyle(fontSize: 16, color: blueAccent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text(
                    'Cancel',
                    style: displayWidth(context) > 600
                        ? TextStyle(fontSize: 26, color: blueAccent)
                        : TextStyle(fontSize: 16, color: blueAccent),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: displayWidth(context) > 600 ? 20 : 0),
            child: Text(
              'Ebuzz',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor,
                  fontSize: displayWidth(context) > 600 ? 30 : 20),
            ),
          ),
          elevation: Platform.isAndroid ? 1 : 0,
          centerTitle: Platform.isAndroid ? false : true,
          backgroundColor: blueAccent,
          actions: [
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          choice.icon,
                          color: Colors.grey[700],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          choice.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
      body: loading ? CircularProgress() : _gridViewUi(),
    );
  }

  //For displaying cards in gridview having row column count as 2
  Widget _gridViewUi() {
    return Padding(
      padding: EdgeInsets.all(displayWidth(context) > 600 ? 20 : 8),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 11,
          crossAxisSpacing: displayWidth(context) > 600 ? 15 : 5,
          mainAxisSpacing: displayWidth(context) > 600 ? 15 : 5,
        ),
        children: [
          cardUi('BOM', Bom()),
          cardUi('Item', ItemUi()),
          cardUi('Purchase Order', PurchaseOrderUi()),
          cardUi('Leave Balance', LeaveUi()),
          cardUi('Leave List', EmployeeLeaveUi(name: name)),
          cardUi('Work Order', WorkOrderUi()),
          cardUi('Quality Inspection', QualityInspectionListUi()),
          cardUi('Stock Entry', StockEntryList()),
          cardUi('Sales Order', SalesOrderListUi()),
          // cardUi('File Upload', FileUpload()),
          cardUi('Catalogue', ItemsUi()),
        ],
      ),
    );
  }

  //ui of particular card which is reusable
  Widget cardUi(String text, Widget routeScreen) {
    return GestureDetector(
      onTap: () {
        pushScreen(context, routeScreen);
      },
      child: Container(
        width: displayWidth(context) * 0.45,
        height: displayWidth(context) * 0.45,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blueAccent,
                      fontSize: displayWidth(context) > 600 ? 34 : 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget slidingPanel() {
  //   return SlidingUpPanel(
  //     minHeight: displayHeight(context) * 0.035,
  //     maxHeight: displayHeight(context),
  //     borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //     panel: Column(
  //       children: [],
  //     ),
  //   );
  // }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}
