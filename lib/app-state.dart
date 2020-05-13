import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';

class AppState with ChangeNotifier {
  AppState();

  var items = new List<Item>();

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(items));
  }

  void add(var textCtrl) {
    if (textCtrl.text.isEmpty) {
      return;
    }

    items.add(
      Item(title: textCtrl.text, done: false),
    );

    notifyListeners();

    textCtrl.clear();
    save();
  }

  void remove(int index) {
    items.removeAt(index);

    notifyListeners();
    save();
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((i) => Item.fromJson(i)).toList();

      items = result;

      notifyListeners();
    }
  }
}
