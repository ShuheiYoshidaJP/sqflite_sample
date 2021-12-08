import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sample/config/app_config.dart';
import 'package:sqflite_sample/model/customer.dart';

//https://github.com/burhanrashid52/WhatTodo/blob/master/lib/db/app_db.dart
class DatabaseBase {
  Future<Database> _open() async {
    final path = join(
      await getDatabasesPath(),
      AppConfig.databasePath,
    );
    return await openDatabase(
      path,
      onCreate: _onCreatingDatabase,
      version: AppConfig.databaseVersion,
    );
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute('CREATE TABLE ${Customer.tableKey}('
        '${Customer.idKey} INTEGER PRIMARY KEY,'
        '${Customer.firstNameKey} TEXT,'
        '${Customer.lastNameKey} TEXT,'
        '${Customer.kanaFirstNameKey} TEXT,'
        '${Customer.kanaLastNameKey} TEXT,'
        '${Customer.lastVisitKey} TEXT,'
        '${Customer.createdAtKey} TEXT,'
        '${Customer.phoneNumberKey} INTEGER,'
        '${Customer.customerNumberKey} INTEGER'
        ')');
  }

  Future<List<Map<String, Object?>>> get(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    var database = await _open();
    return database.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  Future<List<Map<String, Object?>>> getRaw(String sql) async {
    var database = await _open();
    return database.rawQuery(sql);
  }

  Future<int> insert(String table, Map<String, Object?> values,
      {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) async {
    var database = await _open();
    return database.insert(table, values,
        nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
  }

  Future<int> insertRaw(String sql, [List<Object?>? arguments]) async {
    var database = await _open();
    return database.rawInsert(sql, arguments);
  }

  Future<int> update(String table, Map<String, Object?> values,
      {String? where,
      List<Object?>? whereArgs,
      ConflictAlgorithm? conflictAlgorithm}) async {
    var database = await _open();
    return database.update(table, values,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm);
  }

  Future<int> updateRaw(String sql, [List<Object?>? arguments]) async {
    var database = await _open();
    return database.rawUpdate(sql, arguments);
  }

  Future<int> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    var database = await _open();
    return database.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<int> deleteRaw(String sql, [List<Object?>? arguments]) async {
    var database = await _open();
    return database.rawDelete(sql, arguments);
  }

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action,
      {bool? exclusive}) async {
    var database = await _open();
    return database.transaction(action, exclusive: exclusive);
  }
}
