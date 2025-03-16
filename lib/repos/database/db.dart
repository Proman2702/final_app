import 'dart:developer';
import 'dart:io';

import 'package:final_app/etc/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    //if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final statusStorage = await Permission.storage.status;
    if (!statusStorage.isGranted) {
      await Permission.storage.request();
    }

    final tmpPath = await getExternalStorageDirectory();

    String path = join(tmpPath!.path, 'my_database.db');
    log(path);

    return await openDatabase(
      path,
      version: 3,
      onUpgrade: (db, version, oldVersion) async {
        await db.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            lan REAL NOT NULL,
            lon REAL NOT NULL,
            date TEXT NOT NULL,
            temperature REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertItem(Item item) async {
    final db = await database;
    return await db.insert('items', item.toMap());
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('items');
  }

  Future<int> delItem(Item item) async {
    final db = await database;
    return await db.delete('items',
        where: item.toMap().keys.map((key) => '$key = ?').join(' AND '), whereArgs: item.toMap().values.toList());
  }

  Future<void> copyDbToDownloads() async {
    final appDir = await getExternalStorageDirectory();
    final dbFile = File('${appDir!.path}/my_database.db');

    final targetDir = Directory('/storage/emulated/0/Download/app'); // 👈 тут будет наша папка
    if (!(await targetDir.exists())) {
      await targetDir.create(recursive: true); // 🔧 создаём, если её нет
    }

    final targetPath = join(targetDir.path, 'my_database.db');

    await dbFile.copy(targetPath);
  }
}
