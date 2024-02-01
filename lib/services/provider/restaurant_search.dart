import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:submisi_2/services/network/api_client.dart';
import 'package:submisi_2/services/helper/result_state.dart';

class RestaurantSearchProvider with ChangeNotifier {
  final RestaurantApiClient _apiClient = RestaurantApiClient();
  final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  List<RestaurantList> _searchRestaurant = [];
  List<RestaurantList> get searchResult => _searchRestaurant;

  ResultState _state = ResultState.loading;
  String _message = '';

  String _query = '';
  String get queries => _query;

  String get message => _message;

  ResultState get state => _state;

  void updateQuery(String value) {
    _query = value;
    notifyListeners();
    _fetchSearchRestaurant();
  }

  Future<void> _fetchSearchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data =
          await _apiClient.fetchRestaurants('$_baseUrl/search?q=$_query');
      _searchRestaurant = (data as List<dynamic>)
          .map((data) => RestaurantList.fromJson(data))
          .toList();

      if (_searchRestaurant.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'No results found for $_query';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error: $e';
    }
  }
}
