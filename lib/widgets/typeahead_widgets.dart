import 'package:flutter/material.dart';

class TypeAheadWidgets {
  static Widget itemUi(String item) {
    return ListTile(
      title: Text(
        item,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  static List<String> getSuggestions(String query, List<String> list) {
    List<String> matches = [];
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
