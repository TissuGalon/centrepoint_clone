import 'package:policy_centrepoint/SQLiteTEST/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'items_database.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE $tableItem (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnName TEXT NOT NULL)
        ''');
    });
  }

  Future<Item> insertItem(Item item) async {
    final db = await database;
    item.id = await db.insert(tableItem, item.toMap());
    return item;
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    List<Map<String, Object?>> maps = await db.query(tableItem);

    return maps.isNotEmpty
        ? maps.map((item) => Item.fromMap(item)).toList()
        : [];
  }

  Future<int> updateItem(Item item) async {
    final db = await database;
    return await db.update(tableItem, item.toMap(),
        where: '$columnId = ?', whereArgs: [item.id]);
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(tableItem, where: '$columnId = ?', whereArgs: [id]);
  }

  Future close() async => (await database).close();
}
