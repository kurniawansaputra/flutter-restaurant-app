import 'package:flutter/material.dart';

import '../../core/static/restaurant_search_result_state.dart';
import '../../data/api/api_service.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService _apiServices;

  RestaurantSearchProvider(
    this._apiServices,
  );

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  Future<void> searchRestaurant(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.searchRestaurant(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}
