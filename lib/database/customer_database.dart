import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sample/database/database_base.dart';
import 'package:sqflite_sample/model/customer.dart';

class CustomerDatabase {
  final _base = DatabaseBase();

  Future<List<Customer>> all() async {
    var maps = await _base.get(Customer.tableKey);
    var list =
        List.generate(maps.length, (index) => Customer.fromMap(maps[index]));
    return list;
  }

  Future<List<Customer>> searchName(String text) async {
    var where =
        '${Customer.firstNameKey} LIKE ? OR ${Customer.lastNameKey} LIKE ?';
    var whereArgs = ['%$text%', '%$text%'];
    var maps =
        await _base.get(Customer.tableKey, where: where, whereArgs: whereArgs);
    var list =
        List.generate(maps.length, (index) => Customer.fromMap(maps[index]));
    return list;
  }

  Future<void> insert(Customer customer) async {
    await _base.insert(Customer.tableKey, customer.toMap,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
