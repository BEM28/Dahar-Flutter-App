import 'package:flutter/foundation.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:submisi_2/services/network/api_client.dart';
import 'package:submisi_2/services/helper/result_state.dart';

class RestaurantListProvider with ChangeNotifier {
  final RestaurantApiClient _apiClient = RestaurantApiClient();

  final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  List<RestaurantList> _restaurants = [];
  List<RestaurantList> get restaurants => _restaurants;

  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;

  RestaurantListProvider() {
    fetchRestauranAll();
  }

  Future<void> fetchRestauranAll() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final data = await _apiClient.fetchRestaurants('$_baseUrl/list');

      _restaurants = (data as List<dynamic>)
          .map((data) => RestaurantList.fromJson(data))
          .toList();

      if (_restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }
}
