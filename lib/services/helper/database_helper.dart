import 'package:submisi_2/services/local/sqlite_client.dart';
import 'package:submisi_2/services/model/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<void> saveRestaurantList(RestaurantList restaurantList) async {
    final Database db = await RestaurantLocalClient.instance.database;
    await db.insert(
      'restaurant_favorite',
      restaurantList.toJson(), // Adjust as needed
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeRestaurant(String restaurantId) async {
    final Database db = await RestaurantLocalClient.instance.database;
    await db.delete(
      'restaurant_favorite',
      where: 'id = ?',
      whereArgs: [restaurantId],
    );
  }

  Future<List<RestaurantList>> getRestaurantList() async {
    final Database db = await RestaurantLocalClient.instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('restaurant_favorite');
    return List.generate(maps.length, (i) {
      return RestaurantList.fromJson(maps[i]); // Adjust as needed
    });
  }

  Future<void> saveSchedulingStatus(bool isScheduled) async {
    final Database db = await RestaurantLocalClient.instance.database;
    await db.update(
      'scheduling_status',
      {'isScheduled': isScheduled ? 1 : 0},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<bool?> getSchedulingStatus() async {
    final Database db = await RestaurantLocalClient.instance.database;
    final result = await db.query('scheduling_status',
        columns: ['isScheduled'], where: 'id = ?', whereArgs: [1]);
    if (result.isNotEmpty) {
      final int isScheduledValue = result.first['isScheduled'] as int;
      return isScheduledValue == 1;
    } else {
      return null;
    }
  }
}
