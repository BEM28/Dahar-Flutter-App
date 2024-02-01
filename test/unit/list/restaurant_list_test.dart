import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:submisi_2/services/network/client_api_data.dart';
import 'restaurant_list_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetch Restaurants', () {
    test('returns a list of restaurants on success', () async {
      final client = MockClient();

      // Mock a successful response with the expected data
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"restaurants": [{"id": "1", "name": "Restaurant 1", "description": "Description 1", "pictureId": "1", "city": "City 1", "rating": 4.5}, {"id": "2", "name": "Restaurant 2", "description": "Description 2", "pictureId": "2", "city": "City 2", "rating": 4.0}]}',
              200));

      final restaurants = await RestaurantClient().fetchRestaurantsData(client);

      expect(restaurants, isA<List<RestaurantList>>());
      expect(restaurants.length, 2);
    });

    test('throws an exception on API error', () {
      final client = MockClient();

      // Mock an error response
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Error', 500));

      expect(RestaurantClient().fetchRestaurantsData(client), throwsException);
    });
  });
}
