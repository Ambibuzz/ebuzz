import 'package:ebuzz/b2b/quotationplaced/quotation_placed.dart';
import 'package:ebuzz/home/ui/home.dart';
import 'package:ebuzz/login/ui/login.dart';
import 'package:ebuzz/util/linear_gradients.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool login = await getLoggedIn();
  bool loggedIn;
  loggedIn = login == null ? false : login;
  runApp(
    ProviderScope(
      child: GetMaterialApp(
        home: loggedIn == true ? Home() : Login(),
      ),
    ),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ebuzz',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          //  QuotationPlaced()
          Login(),
    );
  }
}
