//Storing shared preferences values

import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getApiUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('apiUrl');
}

Future<List<String>?> getBaseUrlList() async {
  List<String>? list =[];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  list= prefs.getStringList('url');
  return list;
}

Future<String?> getCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('cookie');
}

Future<String?> getCompany() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('company');
}

Future<String?> getCurrency() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('currency');
}

Future<String?> getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('name');
}

Future<bool?> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('loggedIn');
}

Future<String?> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}

setApiUrl(String apiurl) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('apiUrl', apiurl);
}

setBaseUrlList(List<String> apiurl) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('url', apiurl);
}

setCookie(String cookie) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('cookie', cookie);
}

setCompany(String company) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('company', company);
}

setCurrency(String currency) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('currency', currency);
}

setName(String fullname) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', fullname);
}

setLoggedIn(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('loggedIn', value);
}

setUserName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', name);
}

removeApiUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('apiUrl');
}

removeCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('cookie');
}

removeCompany() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('company');
}

removeCurrency() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('currency');
}

removeName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('name');
}

removeLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('loggedIn');
}

removeUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('username');
}
