import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/login/service/login_api_service.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//Login class contains ui of login form
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = true;
  bool loading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController apiBaseUrlController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  LoginApiService _loginApiProvider = LoginApiService();
  var _formKey = GlobalKey<FormState>();
  List<String> list = [];

  login() async {
    setState(() {
      loading = true;
    });
    await _loginApiProvider.login(
      baseUrl: apiBaseUrlController.text,
      context: context,
      password: passwordController.text,
      username: usernameController.text,
    );
    setState(() {
      loading = false;
    });
  }

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item,
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyle(color: greyDarkColor, fontSize: 16)),
    );
  }

  @override
  void initState() {
    super.initState();
    baseUrlList();
  }

  baseUrlList() async {
    list = await getBaseUrlList();
    setState(() {});
  }

  List<String> _getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
              child: Column(
                children: [
                  loginHeader(),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: displayWidth(context) > 600 ? 32 : 16,
                        vertical: displayWidth(context) > 600 ? 40 : 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          list == null || list == []
                              ? baseUrlTextField()
                              : baseUrlAutoCompleteTextField(),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          usernameTextField(),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          passwordTextField(),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          loginButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget baseurlTextField() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: apiBaseUrlController,
        style: displayWidth(context) > 600
            ? TextStyle(fontSize: 28, color: blackColor)
            : TextStyle(color: blackColor, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: blackColor, width: 1, style: BorderStyle.solid),
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600 ? 30 : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          labelText: 'Enter Base url of api',
        ),
      ),
      onSuggestionSelected: (suggestion) {
        apiBaseUrlController.text = suggestion;
      },
      itemBuilder: (context, item) {
        return itemUi(item);
      },
      suggestionsCallback: (pattern) {
        return _getSuggestions(pattern);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) => val.isEmpty ? 'Please enter baseurl...' : null,
    );
  }

  Widget loginHeader() {
    return Container(
      color: skyColor,
      height: displayHeight(context) * 0.35,
      width: displayWidth(context),
      child: Padding(
        padding: EdgeInsets.only(
            left: displayWidth(context) > 600 ? 32 : 16,
            bottom: displayHeight(context) * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Login  ',
              style: displayWidth(context) > 600
                  ? TextStyle(
                      color: blackColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)
                  : TextStyles.t24BlackBold,
            ),
            Text(
              'Please sign in to continue',
              style: displayWidth(context) > 600
                  ? TextStyle(
                      color: blackColor,
                      fontSize: 30,
                    )
                  : TextStyles.t18Black,
            ),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      height: displayWidth(context) > 600 ? 80 : 50,
      width: displayWidth(context) > 600 ? 170 : 120,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: blueAccent,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            login();
          }
        },
        child: Text(
          'Login',
          style: displayWidth(context) > 600
              ? TextStyle(
                  color: whiteColor,
                  fontSize: 30,
                )
              : TextStyles.t20White,
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      key: Key('password-field'),
      controller: passwordController,
      validator: (password) {
        if (password.length == 0) {
          return 'Password should not be empty';
        }
        return null;
      },
      obscureText: obscureText,
      style: displayWidth(context) > 600
          ? TextStyle(fontSize: 28, color: blackColor)
          : TextStyles.t16Black,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: blackColor,
            size: displayWidth(context) > 600 ? 33 : 25,
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600
                  ? 30
                  : displayWidth(context) < 380
                      ? 15
                      : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          suffixIcon: IconButton(
            icon: obscureText
                ? Icon(
                    Icons.visibility,
                    color: blackColor,
                    size: displayWidth(context) > 600 ? 33 : 25,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: blackColor,
                    size: displayWidth(context) > 600 ? 33 : 25,
                  ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blackColor, width: 1),
          ),
          labelText: 'Password'),
    );
  }

  Widget baseUrlTextField() {
    return TextFormField(
      key: Key('baseurl-field'),
      controller: apiBaseUrlController,
      validator: (url) {
        if (url.length == 0) {
          return 'Baseurl should not be empty';
        }
        return null;
      },
      style: displayWidth(context) > 600
          ? TextStyle(fontSize: 28, color: blackColor)
          : TextStyles.t16Black,
      decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600
                  ? 30
                  : displayWidth(context) < 380
                      ? 15
                      : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blackColor, width: 1),
          ),
          labelText: 'Enter Base url of api'),
    );
  }

  Widget usernameTextField() {
    return TextFormField(
      key: Key('username-field'),
      controller: usernameController,
      validator: (username) {
        if (username.length == 0) {
          return 'Username or email should not be empty';
        }
        return null;
      },
      style: displayWidth(context) > 600
          ? TextStyle(fontSize: 28, color: blackColor)
          : TextStyles.t16Black,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.supervised_user_circle,
            color: blackColor,
            size: displayWidth(context) > 600 ? 33 : 25,
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600
                  ? 30
                  : displayWidth(context) < 380
                      ? 15
                      : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blackColor, width: 1),
          ),
          labelText: 'Username or Email'),
    );
  }

  Widget baseUrlAutoCompleteTextField() {
    return AutoCompleteTextField<String>(
      controller: apiBaseUrlController,
      itemSubmitted: (item) {
        apiBaseUrlController.text = item;
      },
      onFocusChanged: (hasFocus) {},
      key: key,
      clearOnSubmit: false,
      style: displayWidth(context) > 600
          ? TextStyle(fontSize: 28, color: blackColor)
          : TextStyle(color: blackColor, fontSize: 18),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: blackColor, width: 1, style: BorderStyle.solid),
        ),
        labelStyle: TextStyle(
          fontSize: displayWidth(context) > 600 ? 28 : 16,
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: displayWidth(context) > 600 ? 30 : 20,
            horizontal: displayWidth(context) > 600 ? 20 : 10),
        labelText: 'Enter Base url of api',
      ),
      suggestions: list,
      itemBuilder: (context, item) {
        return itemUi(item);
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
    );
  }
}
