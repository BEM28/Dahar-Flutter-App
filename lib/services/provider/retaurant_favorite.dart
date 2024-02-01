import 'package:flutter/foundation.dart';
import 'package:submisi_2/services/helper/result_state.dart';
import 'package:submisi_2/services/helper/database_helper.dart'; // Import the DatabaseHelper
import 'package:submisi_2/services/model/restaurant_list.dart';

class RetaurantFavoriteProvider with ChangeNotifier {
  final DatabaseManager _databaseManager = DatabaseManager();

  List<RestaurantList> _likedRestaurants = [];
  List<RestaurantList> get likedRestaurants => _likedRestaurants;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  String _query = '';
  String get queries => _query;

  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;

  RetaurantFavoriteProvider() {
    loadFavorite();
  }

  void updateQuery(String value) {
    _query = value;
    notifyListeners();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    try {
      _state = ResultState.loading;
      final data = await _databaseManager
          .getRestaurantList(); // Use databaseHelper method

      notifyListeners();
      if (_query.isEmpty) {
        _likedRestaurants = data.toList();
      } else {
        _likedRestaurants = data
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();
      }
      if (_likedRestaurants.isEmpty) {
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

  void onLikeButtonTapped(RestaurantList restaurantList) async {
    if (isLiked) {
      _isLiked = false;
      await _databaseManager.removeRestaurant(restaurantList.id);
    } else {
      _isLiked = true;
      await _databaseManager.saveRestaurantList(restaurantList);
    }
    await loadFavorite();
    notifyListeners();
  }

  Future<void> isRestaurantLiked(String restaurantId) async {
    final data = await _databaseManager.getRestaurantList();
    _isLiked = data.any((restaurant) => restaurant.id == restaurantId);
    notifyListeners();
  }
}
