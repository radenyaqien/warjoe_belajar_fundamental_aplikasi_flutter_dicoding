import 'package:sqflite/sqflite.dart';
import 'package:warjoe/data/model/Restaurant.dart';

class DatabaseHelper {
  static late Database _database;

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'restaurants';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/rest.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT,
               description TEXT,
               pictureId TEXT,
               city TEXT,
               rating REAL
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(_tableName, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
