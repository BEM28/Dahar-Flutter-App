import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:submisi_2/services/model/restaurant_detail.dart';
import 'package:submisi_2/services/helper/result_state.dart';
import 'package:submisi_2/services/network/api_client.dart';

class RestaurantDetailProvider with ChangeNotifier {
  final RestaurantApiClient _apiClient = RestaurantApiClient();
  final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  RestaurantDetail? _restaurantDetail;
  RestaurantDetail? get restaurantDetail => _restaurantDetail;

  List<CustomerReview> _customerReview = [];
  List<CustomerReview> get customerReview => _customerReview;

  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;

  void getRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      final data =
          await _apiClient.fetchRestaurantDetail('$_baseUrl/detail/$id');
      notifyListeners();
      _state = ResultState.hasData;
      _restaurantDetail = RestaurantDetail.fromJson(data);
    } catch (error) {
      _state = ResultState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getRestaurantReview(String id) async {
    try {
      _state = ResultState.loading;

      final data =
          await _apiClient.fetchRestaurantDetail('$_baseUrl/detail/$id');
      notifyListeners();

      if (data.isEmpty) {
        _customerReview = [];
      } else {
        final reviewer = RestaurantDetail.fromJson(data);
        _customerReview = reviewer.customerReviews;
      }
      _state = ResultState.hasData;
      notifyListeners();
    } catch (error) {
      _state = ResultState.error;
      _message = 'Error: $error';
      notifyListeners();
    }
  }

  Future<void> addReview(String id, String name, String review) async {
    try {
      await _apiClient.postReview('$_baseUrl/review', id, name, review);
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    } catch (error) {
      _state = ResultState.error;
      _message = 'Error: $error';
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });

      rethrow;
    }
  }
}
