import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sample/config/app_config.dart';

//https://github.com/burhanrashid52/WhatTodo/blob/master/lib/db/app_db.dart
class DatabaseProtocol {

  static final DatabaseProtocol _instance = DatabaseProtocol._internal();

  DatabaseProtocol._internal();

  late Database _database;

  static DatabaseProtocol get() {
    return _instance;
  }

  Future<void> initDatabase() async {
    final path = join(
      await getDatabasesPath(),
      AppConfig.databasePath,
    );
    _database = await openDatabase(
      path,
      onCreate: _onCreatingDatabase,
      version: AppConfig.databaseVersion,
    );
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
  }
}
