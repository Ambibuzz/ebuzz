import 'package:flutter/material.dart';
import 'package:ebuzz/common/colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.label,
    this.labelStyle,
    this.required = false,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.style,
    this.validator,
    this.onEditingComplete,
    this.focusNode,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.onChanged,
    this.initialValue,
  });

  final String? label;
  final bool? required;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry padding;
  final InputDecoration? decoration;
  final TextStyle? labelStyle;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final void Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
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
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            focusNode: focusNode,
            obscureText: obscureText,
            onChanged: onChanged,
            style: style,
            validator: validator,
            initialValue: initialValue,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            decoration: decoration,
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}
