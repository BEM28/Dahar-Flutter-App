import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RestaurantLocalClient {
  static const String _databaseName = 'restaurant.db';
  static const String _tableName = 'restaurant_favorite';

  RestaurantLocalClient._privateConstructor();
  static final RestaurantLocalClient instance =
      RestaurantLocalClient._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      pictureId TEXT,
      city TEXT,
      rating REAL
    )
  ''');
  }
}
