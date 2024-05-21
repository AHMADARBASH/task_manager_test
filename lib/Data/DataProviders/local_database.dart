import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _instance;
  static Database get instance => _instance;

  static Future<void> createDatabase() async {
    await openDatabase(
      'taskmanager.db',
      version: 1,
      onCreate: (db, version) async {
        await db
            .execute(
                'CREATE TABLE todo (id INTEGER,todo TEXT,completed INTEGER,userId INTEGER)')
            .catchError((error) {});
      },
      onOpen: (db) => _instance = db,
    );
  }

  static Future<void> insertIntoDatabase(
      {required String tableName, required Map<String, dynamic> data}) async {
    await _instance.insert(tableName, data);
  }

  static Future<List<Map<String, dynamic>>> getDatafromDatabase(
      {required String tableName}) async {
    return await _instance.rawQuery('Select * from $tableName');
  }

  static Future<void> deletefromDatabase(
      {required int id, required String tableName}) async {
    await _instance.delete(
      tableName,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<void> updateItem(
      {required Map<String, dynamic> data, required String tableName}) async {
    await _instance
        .update(tableName, data, where: 'id=?', whereArgs: [data['id']]);
  }
}
