import 'package:flutter/material.dart';

//It contains reusable function which can be used for navigation purpose by reducing boiler plate code
pushScreen(BuildContext context, Widget route) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}

pushReplacementScreen(BuildContext context, Widget route) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}
