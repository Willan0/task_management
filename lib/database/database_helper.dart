import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/data/vos/task_vo.dart';

class DatabaseHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'task';
  static Future<void> intDb() async {
    if (_db != null) {
      return;
    }
    try {
      var dataPath = await getDatabasesPath();
      String path = join(dataPath, 'tasks.db');
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING,note TEXT,date STRING,startTime STRING,endTime STRING,remind INTEGER,repeat STRING,color INTEGER,isCompleted INTEGER)');
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertData(TaskVO? taskVO) async {
    return await _db?.insert(_tableName, taskVO!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static Future<int> deleteData(int id) async {
    return await _db?.delete(_tableName, where: 'id=?', whereArgs: [id]) ?? 1;
  }

  static Future<int> updateData(int id) async {
    return await _db?.rawUpdate('''
    UPDATE $_tableName
    SET isCompleted = ?
    WHERE id = ?
''', [1, id]) ?? 1;
  }
}
