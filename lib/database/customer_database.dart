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

  Future<void> insert(Customer customer) async {
    await _base.insert(Customer.tableKey, customer.toMap,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
