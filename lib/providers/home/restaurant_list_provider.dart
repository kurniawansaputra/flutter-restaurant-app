import 'package:flutter/material.dart';

import '../../core/static/restaurant_list_result_state.dart';
import '../../data/api/api_service.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiServices;

  RestaurantListProvider(
    this._apiServices,
  );

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }
}
