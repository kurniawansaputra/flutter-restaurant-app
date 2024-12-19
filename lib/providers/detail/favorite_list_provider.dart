import 'package:flutter/material.dart';

import '../../data/models/restaurant.dart';

class FavoriteListProvider extends ChangeNotifier {
  final List<Restaurant> _favoriteList = [];

  List<Restaurant> get favoriteList => _favoriteList;

  void addFavorite(Restaurant value) {
    _favoriteList.add(value);
    notifyListeners();
  }

  void removeFavorite(Restaurant value) {
    _favoriteList.removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  bool checkItemFavorite(Restaurant value) {
    final restaurantInList =
        _favoriteList.where((element) => element.id == value.id);
    return restaurantInList.isNotEmpty;
  }
}
