import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constans/variables.dart';
import '../models/restaurant_detail_response.dart';
import '../models/restaurant_list_response.dart';

class ApiService {
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("${Variables.baseUrl}/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response =
        await http.get(Uri.parse("${Variables.baseUrl}/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantListResponse> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse("${Variables.baseUrl}/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}
