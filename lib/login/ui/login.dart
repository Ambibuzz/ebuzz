import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/login/service/login_api_service.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';

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
  LoginApiService _loginApiProvider = LoginApiService();
  var _formKey = GlobalKey<FormState>();
  List<String?>? list;

  late FocusNode _baseUrlFocusNode;
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;

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

  @override
  void initState() {
    super.initState();
    _baseUrlFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    baseUrlList();
  }

  baseUrlList() async {
    list = await getBaseUrlList();
    setState(() {});
  }

  @override
  void dispose() {
    _baseUrlFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: displayHeight(context) * 0.15,
                  ),
                  logo(),
                  // ambibuzzText(),
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // list == null || list == []
                          //     ?
                          baseUrlTextField()

                          // : baseUrlAutoCompleteTextField()
                          ,
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          usernameTextField(),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          passwordTextField(),
                          SizedBox(
                            height: displayHeight(context) * 0.03,
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

  Widget logo() {
    return Image.asset('assets/ambibuzzlogo.png');
  }

  Widget ambibuzzText() {
    return Text(
      'Ambibuzz',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: blueAccent,
          fontSize: 26,
          fontWeight: FontWeight.bold),
    );
  }

  // Widget baseurlTextField() {
  //   return TypeAheadFormField(
  //     hideSuggestionsOnKeyboardHide: false,
  //     textFieldConfiguration: TextFieldConfiguration(
  //       controller: apiBaseUrlController,
  //       style: TextStyle(color: blackColor, fontSize: 18),
  //       decoration: InputDecoration(
  //         disabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide(color: greyColor, width: 1),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide(color: blueAccent, width: 1),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide(color: greyColor, width: 1),
  //         ),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide(color: greyColor, width: 1),
  //         ),
  //         labelStyle: TextStyle(
  //           fontSize: 16,
  //         ),
  //         contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
  //         labelText: 'Enter Base url of api',
  //       ),
  //     ),
  //     onSuggestionSelected: (String suggestion) {
  //       apiBaseUrlController.text = suggestion;
  //     },
  //     itemBuilder: (context, String item) {
  //       return itemUi(item);
  //     },
  //     suggestionsCallback: (pattern) {
  //       return _getSuggestions(pattern);
  //     },
  //     transitionBuilder: (context, suggestionsBox, controller) {
  //       return suggestionsBox;
  //     },
  //     validator: (val) => val == null ? 'Please enter baseurl...' : null,
  //   );
  // }

  Widget loginHeader() {
    return Container(
      color: skyColor,
      height: displayHeight(context) * 0.35,
      width: displayWidth(context),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16, bottom: displayHeight(context) * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Login  ',
              style: TextStyle(
                  fontSize: 24, color: blackColor, fontWeight: FontWeight.bold),
            ),
            Text(
              'Please sign in to continue',
              style: TextStyle(fontSize: 18, color: blackColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: displayWidth(context),
      height: 50,
      child: RoundButton(
        primaryColor: blueAccent,
        onPrimaryColor: whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18, color: whiteColor),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            login();
          }
        },
      ),
    );
  }

  Widget baseUrlTextField() {
    return CustomTextFormField(
      controller: apiBaseUrlController,
      decoration: InputDecoration(
        fillColor: greyColor,
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      focusNode: _baseUrlFocusNode,
      label: 'Base Url',
      labelStyle: TextStyle(color: blackColor),
      onEditingComplete: () => _usernameFocusNode.requestFocus(),
      required: false,
      style: TextStyle(fontSize: 14, color: blackColor),
      validator: (val) =>
          val == '' || val == null ? 'Baseurl should not be empty' : null,
    );
  }

  Widget usernameTextField() {
    return CustomTextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        fillColor: greyColor,
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      focusNode: _usernameFocusNode,
      label: 'Username or Email',
      labelStyle: TextStyle(color: blackColor),
      onEditingComplete: () => _passwordFocusNode.requestFocus(),
      required: false,
      style: TextStyle(fontSize: 14, color: blackColor),
      validator: (val) => val == '' || val == null
          ? 'Username or Email should not be empty'
          : null,
    );
  }

  Widget passwordTextField() {
    return CustomTextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        fillColor: greyColor,
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        suffix: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Text(
            obscureText ? 'SHOW' : 'HIDE',
            style: TextStyle(color: greyDarkColor),
          ),
        ),
      ),
      focusNode: _passwordFocusNode,
      label: 'Password',
      labelStyle: TextStyle(color: blackColor),
      obscureText: obscureText,
      onEditingComplete: () => _passwordFocusNode.unfocus(),
      required: false,
      style: TextStyle(fontSize: 14, color: blackColor),
      textInputAction: TextInputAction.done,
      validator: (val) =>
          val == '' || val == null ? 'Password should not be empty' : null,
    );
  }

}
