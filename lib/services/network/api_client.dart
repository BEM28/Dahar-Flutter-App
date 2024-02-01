import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class RestaurantApiClient {
  Future fetchRestaurants(String api) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return [];
    }
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      return [];
    }
  }

  Future postReview(String api, String id, String name, String review) async {
    await http.post(
      Uri.parse(api),
      body: {'id': id, 'name': name, 'review': review},
    );
  }

  Future fetchRestaurantDetail(String api) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return {};
    }

    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('restaurant')) {
        return data['restaurant'];
      } else {
        return {};
      }
    } else {
      return {};
    }
  }
}
