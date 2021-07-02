import 'package:flutter/material.dart';
import 'package:ebuzz/config/color_palette.dart';
class Palette {
  static Color bgColor = ColorPalette.grey[50]!;
  static Color fieldBgColor = ColorPalette.grey[100]!;
  static Color iconColor = ColorPalette.grey[700]!;
  static Color primaryButtonColor = ColorPalette.blue;
  static Color secondaryButtonColor = ColorPalette.grey[200]!;
  static Color disabledButonColor = ColorPalette.grey;
  static const Color iconColor2 = Color(0xFF1F272E);

  static Color dangerTxtColor = ColorPalette.red[600]!;
  static Color dangerBgColor = ColorPalette.red[100]!;
  static Color warningTxtColor = ColorPalette.orange[600]!;
  static Color warningBgColor = ColorPalette.orange[100]!;
  static Color completeTxtColor = ColorPalette.blue[600]!;
  static Color completeBgColor = ColorPalette.blue[100]!;
  static Color undefinedTxtColor = ColorPalette.grey[600]!;
  static Color undefinedBgColor = ColorPalette.grey[100]!;
  static Color successTxtColor = ColorPalette.darkGreen[600]!;
  static Color successBgColor = ColorPalette.darkGreen[100]!;

  static Color secondaryTxtColor = Color(0xFFB9C0C7);
  static Color newIndicatorColor = Color.fromRGBO(255, 252, 231, 1);

  static EdgeInsets fieldPadding = const EdgeInsets.only(bottom: 24.0);
  static EdgeInsets labelPadding = const EdgeInsets.only(bottom: 6.0);


  static TextStyle secondaryTxtStyle = TextStyle(
    color: Palette.secondaryTxtColor,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static TextStyle altTextStyle = TextStyle(
    fontStyle: FontStyle.italic,
    color: Palette.secondaryTxtColor,
  );


  static InputDecoration formFieldDecoration({
    String? label,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool filled = true,
    String? field,
  }) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      contentPadding: field == "check"
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(
              horizontal: 10,
            ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),
        ),
      ),
      // hintText: label,
      filled: filled,
      fillColor: Palette.fieldBgColor,
    );
  }
}
