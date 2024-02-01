import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:submisi_2/services/model/restaurant_list.dart';

class RestaurantClient {
  Future<List<RestaurantList>> fetchRestaurantsData(http.Client client) async {
    final response =
        await client.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body) as Map<String, dynamic>;
      final restaurants = (parsedData['restaurants'] as List)
          .map((restaurantData) => RestaurantList.fromJson(restaurantData))
          .toList();
      return restaurants;
    } else {
      throw Exception('Failed to fetch data restaurants');
    }
  }
}
