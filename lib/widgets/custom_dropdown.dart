import 'package:flutter/material.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    this.alignment = CrossAxisAlignment.center,
    this.decoration,
    this.label,
    this.required,
    this.labelStyle,
    this.onChanged,
    this.value,
    this.elevation = 1,
    this.focusNode,
    this.dropdownColor,
    this.focusColor,
    this.hint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 25,
    this.items,
    this.margin=EdgeInsets.zero,
    this.padding=EdgeInsets.zero,
  });

  final String? label;
  final bool? required;
  final TextStyle? labelStyle;
  final void Function(String?)? onChanged;
  final String? value;
  final int elevation;
  final FocusNode? focusNode;
  final Color? dropdownColor;
  final Color? focusColor;
  final Widget? hint;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final List<DropdownMenuItem<String>>? items;
  final Decoration? decoration;
  final CrossAxisAlignment alignment;
  final EdgeInsetsGeometry? margin;
    final EdgeInsetsGeometry padding;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          children: [
            Text(
              label!,
              style: labelStyle,
            ),
            SizedBox(width: 8),
            required == true
                ? Text(
                    '*',
                    style: TextStyle(color: redColor),
                  )
                : Container()
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: decoration,
          margin: margin,
          width: displayWidth(context),
          child: Padding(
            padding: padding,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                elevation: elevation,
                onChanged: onChanged,
                focusNode: focusNode,
                dropdownColor: dropdownColor,
                focusColor: focusColor,
                hint: hint,
                icon: icon,
                iconDisabledColor: iconDisabledColor,
                iconEnabledColor: iconEnabledColor,
                iconSize: iconSize,
                items: items,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
