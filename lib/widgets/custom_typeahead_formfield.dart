import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ebuzz/common/colors.dart';

class CustomTypeAheadFormField extends StatelessWidget {
  const CustomTypeAheadFormField({
    this.autoFlipDirection=true,
    required this.label,
    this.labelStyle,
    this.required = false,
    this.hideSuggestionOnKeyboardHide = false,
    this.controller,
    this.focusNode,
    this.onEditingComplete,
    required this.decoration,
    this.keyboardType = TextInputType.text,
    this.padding = EdgeInsets.zero,
    this.style,
    this.textInputAction = TextInputAction.next,
    this.validator,
    required this.onSuggestionSelected,
    required this.itemBuilder,
    required this.suggestionsCallback,
    this.transitionBuilder,
  });
  final String? label;
  final TextStyle? labelStyle;
  final bool? required;
  final bool hideSuggestionOnKeyboardHide;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(dynamic) onSuggestionSelected;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;
  final dynamic Function(BuildContext, Widget, AnimationController?)?
      transitionBuilder;
  final bool autoFlipDirection;

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
          TypeAheadFormField(
            autoFlipDirection: autoFlipDirection,
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              focusNode: focusNode,
              textInputAction: textInputAction,
              onEditingComplete: onEditingComplete,
              decoration: decoration,
              keyboardType: keyboardType,
              style: style,
            ),
            hideSuggestionsOnKeyboardHide: hideSuggestionOnKeyboardHide,
            onSuggestionSelected: onSuggestionSelected,
            itemBuilder: itemBuilder,
            suggestionsCallback: suggestionsCallback,
            transitionBuilder: transitionBuilder,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
