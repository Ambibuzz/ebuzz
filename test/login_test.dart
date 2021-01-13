import 'package:erpapp/login/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var usernameField = find.byKey(Key('username-field'));
  var passwordField = find.byKey(Key('password-field'));
  var baseurlField = find.byKey(Key('baseurl-field'));
  var loginButton = find.text('Login');
  testWidgets('login page widgets test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Login())));
    expect(usernameField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);
    // expect(baseurlField, findsOneWidget);
  });

  // testWidgets('check validation', (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(home: Login()));
  //   final login = find.text('Login');
  //   final usernameError= find.text('Username or email should not be empty');
  //   final baseurlError=find.text('Baseurl should not be empty');
  //   final passwordError=find.text('Password should not be empty');
  //   await tester.pumpAndSettle();
  //   await tester.tap(login);
  //   await tester.pump(const Duration(milliseconds: 100)); // add delay
  //   expect(usernameError, findsOneWidget);
  //   expect(baseurlError, findsOneWidget);
  //   expect(passwordError, findsOneWidget);
  // });

  testWidgets(
      'check login method when baseurl and username and password is entered',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));
    // await tester.enterText(baseurlField, 'http://agfsandbox.ambibuzz.com');
    await tester.enterText(usernameField, 'mohit.yadav@ambibuzz.com');
    await tester.enterText(passwordField, 'MohiT_!23');
    await tester.tap(loginButton);
    await tester.pump();
  });
}
