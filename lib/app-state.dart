import 'package:flutter/material.dart';
import 'models/item.dart';

class AppState with ChangeNotifier {
  AppState();

  var items = new List<Item>();
}
