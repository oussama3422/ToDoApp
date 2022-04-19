import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? db;
  static  int version = 1;
  static  String tabelName = 'tasks';

  static Future<void> initDb() async {
    if (db != null) {
      debugPrint('No null db');
    } else {
      try {
        // String path = await getDatabasesPath() + 'task.db';
        db = await openDatabase('task.db', version: version,
            onCreate: (Database db2, int version2) async {
          await db!.execute('CREATE TABLE $tabelName(id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING ,note TEXT, date STRING,startTime STRING, endTime STRING ,remind INTEGER, repeat STRING, color INTEGER,isComplted INTEGER');
               debugPrint('The DB Was Created');
        });
      } catch (e) {
        print('Somthing Went Wrong');
      }
    }
  }

  static insert(Task task) async {
    print('Insert Opreation');

    return await db!.insert(tabelName, task.toJson());
  }

  static delete(Task task) async {
    print('delete Opreation');

    return await db!.delete(tabelName, where: 'id = ? ', whereArgs: [task.id]);
  }

  static update(int id) async {
    print('Update Opreation');

    return await db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, id]);
  }

  static Future<List<Map<String,Object?>>> query() async {
    print('Query Opreation');
    return await db!.query(tabelName);
  }
}
