import 'package:ebuzz/app.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? login=false;
  login = await getLoggedIn();
  runApp(App(login: login));
}


