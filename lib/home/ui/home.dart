import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/item/ui/item_ui.dart';
import 'package:ebuzz/leavebalance/ui/leave_balance_ui.dart';
import 'package:ebuzz/logout/service/logout_api_service.dart';
import 'package:ebuzz/purchaseorder/ui/purchase_order_ui.dart';
import 'package:ebuzz/qualityinspection/ui/quality_inspection_list_ui.dart';
import 'package:ebuzz/quotation/ui/quotation_list_ui.dart';
import 'package:ebuzz/salesorder/ui/sales_order_list_ui.dart';
import 'package:ebuzz/settings/ui/settings.dart';
import 'package:ebuzz/stockentry/ui/stock_entry_list.dart';
import 'package:ebuzz/util/doctype_names.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:ebuzz/workorder/ui/workorder_ui.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/bom/ui/bom_ui.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/leavelist/ui/leave_list_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//Home class displays ui of different functionalities in form of cards
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  LogOutApiService _logOutApiProvider = LogOutApiService();

  String? apiurl;
  String? name;
  bool loading = false;
  Choice _selectedChoice = choices[0];
  var storage = FlutterSecureStorage();
  List<String> modules = [];
  List<String> labels = [];
  List<LabelList> widgetsList = [];
  List<LabelList> widgetsHiddenList = [];

  //List of choices when user clicks on menu button in top right
  static List<Choice> choices = <Choice>[
    Choice(title: 'Settings', icon: Icons.settings),
    Choice(title: 'Logout', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();
    //check login status
    // HomeService().checkLoginStatus('11019', context);
    CommonService().getItemList(context);
    getData();
    WidgetsBinding.instance?.addObserver(this);
    // WidgetsBinding.instance?.addPostFrameCallback((_) async {
    //   String? cartSave = await storage.read(key: Constants.cartKey);
    //   if (cartSave != null && cartSave.isNotEmpty) {
    //     final listCart = json.decode(cartSave) as List<dynamic>;
    //     final listCartParsed =
    //         listCart.map((model) => Cart.fromJson(model)).toList();
    //     if (listCartParsed.isNotEmpty && listCartParsed.length > 0) {
    //       context.read(cartListProvider).state = listCartParsed;
    //     }
    //   }
    // });
    getPrefs();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    modules = await CommonService().getModulesList(context);
    labels = await CommonService().getLabelsList(context, modules);
    setState(() {
      loading = false;
    });
    // labels.forEach((label) {
    //   print(label);
    // });
    print(labels.length);
    addLabelListToWidgetList();
  }

  addLabelListToWidgetList() async {
    if (labels.contains(DoctypeNames.item) && labels.contains(DoctypeNames.bom))
      widgetsList.add(LabelList(label: 'BOM', route: BomUi()));

    if (labels.contains(DoctypeNames.item) &&
        labels.contains(DoctypeNames.stockLedger))
      widgetsList.add(LabelList(label: 'Item', route: ItemUi()));
    if (labels.contains(DoctypeNames.purchaseOrder) &&
        labels.contains(DoctypeNames.purchaseReceipt))
      widgetsList
          .add(LabelList(label: 'Purchase Order', route: PurchaseOrderUi()));
    // if(labels.contains(DoctypeNames.leaveLedgerEntry))
    widgetsList.add(LabelList(label: 'Leave Balance', route: LeaveUi()));
    if (labels.contains(DoctypeNames.leaveApplication))
      widgetsList.add(LabelList(
          label: 'Leave List', route: EmployeeLeaveUi(name: name ?? '')));
    if (labels.contains(DoctypeNames.workOrder))
      widgetsList.add(LabelList(label: 'Work Order', route: WorkOrderUi()));
    if (labels.contains(DoctypeNames.qualityInspection) &&
        labels.contains(DoctypeNames.qualityInspectionTemplate) &&
        labels.contains(DoctypeNames.salesInvoice) &&
        labels.contains(DoctypeNames.purchaseInvoice) &&
        labels.contains(DoctypeNames.deliveryNote) &&
        labels.contains(DoctypeNames.item) &&
        labels.contains(DoctypeNames.batch))
      widgetsList.add(LabelList(
          label: 'Quality Inspection', route: QualityInspectionListUi()));
    if (labels.contains(DoctypeNames.stockEntry))
      widgetsList.add(LabelList(label: 'Stock Entry', route: StockEntryList()));
    if (labels.contains(DoctypeNames.item) &&
        labels.contains(DoctypeNames.salesOrder) &&
        labels.contains(DoctypeNames.company) &&
        labels.contains(DoctypeNames.customer) &&
        labels.contains(DoctypeNames.warehouse))
      widgetsList
          .add(LabelList(label: 'Sales Order', route: SalesOrderListUi()));
    // widgetsList
    //     .add(LabelList(label: 'Evaluasi Staff', route: EvaluasiStaffFormUi()));
    // if (labels.contains(DoctypeNames.item) &&
    //     labels.contains(DoctypeNames.itemGroup) &&
    //     labels.contains(DoctypeNames.brand) &&
    //     labels.contains(DoctypeNames.quotation))
    //   widgetsList.add(LabelList(label: 'Catalogue', route: ItemsUi()));
    // if (labels.contains(DoctypeNames.customer) &&
    //     labels.contains(DoctypeNames.lead) &&
    //     labels.contains(DoctypeNames.company) &&
    //     labels.contains(DoctypeNames.currency) &&
    //     labels.contains(DoctypeNames.quotation) &&
    //     labels.contains(DoctypeNames.bom) &&
    //     labels.contains(DoctypeNames.territory) &&
    //     labels.contains(DoctypeNames.uom) &&
    //     labels.contains(DoctypeNames.item) &&
    //     labels.contains(DoctypeNames.itemGroup) &&
    //     labels.contains(DoctypeNames.customerGroup)) //global defaults
    //   widgetsList.add(LabelList(label: 'Price Discovery', route: NewBom()));
    if (labels.contains(DoctypeNames.quotation))
      widgetsList
          .add(LabelList(label: 'Quotation List', route: QuotationListUi()));
    print(widgetsList.length);
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // HomeService().checkLoginStatus('11019', context);
      CommonService().getItemList(context);
    }
  }

  getPrefs() async {
    apiurl = await getApiUrl();
    name = await getName();
    setState(() {});
  }

  logout(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await _logOutApiProvider.logOut(context, apiurl ?? '');
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
                style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Are you sure you wan\'t to logout',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);
                    await logout(context);
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(fontSize: 16, color: blueAccent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text(
                    'Cancel',
                    style:TextStyle(fontSize: 16, color: blueAccent),
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
          preferredSize: Size.fromHeight(55),
          child: CustomAppBar(
            title: Text('Ebuzz', style: TextStyle(color: whiteColor)),
            actions: [
              PopupMenuButton<Choice>(
                icon: Icon(
                  Icons.more_vert,
                  color: whiteColor,
                ),
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
        body: loading ? CircularProgress() : _gridViewUi());
  }

  //For displaying cards in gridview having row column count as 2
  Widget _gridViewUi() {
    return Padding(
      padding: EdgeInsets.all( 8),
      child: GridView.builder(
          itemCount: widgetsList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 16 / 11,
            crossAxisSpacing:  5,
            mainAxisSpacing:  5,
          ),
          itemBuilder: (context, i) {
            return cardUi(widgetsList[i].label, widgetsList[i].route);
          }),
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
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blueAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

class LabelList {
  final String label;
  final Widget route;

  LabelList({required this.label, required this.route});
}
