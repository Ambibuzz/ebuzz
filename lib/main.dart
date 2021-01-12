import 'package:ebuzz/home/ui/home.dart';
import 'package:ebuzz/login/ui/login.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool login = await getLoggedIn();
  bool loggedIn;
  loggedIn = login == null ? false : login;
  runApp(GetMaterialApp(home: loggedIn == true ? Home() : Login()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ebuzz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}
