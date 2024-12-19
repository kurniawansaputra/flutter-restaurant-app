import 'package:flutter/material.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavBar = 0;

  int get indexBottomNavBar => _indexBottomNavBar;

  set indexBottomNavBar(int index) {
    _indexBottomNavBar = index;
    notifyListeners();
  }
}
