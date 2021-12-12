import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/database/customer_database.dart';
import 'package:sqflite_sample/model/customer.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_state.dart';
import 'package:uuid/uuid.dart';

class RegisterCustomerStateNotifier extends StateNotifier<RegisterCustomerState> {
  RegisterCustomerStateNotifier(RegisterCustomerState state) : super(state);

  final _database = CustomerDatabase();

  final _uuid = const Uuid();

  void updateFirstName(String value) {
    state = state.copyWith(firstName: value);
  }

  void updateLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  void updateLastVisit(String value) {
    state = state.copyWith(lastVisit: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: int.parse(value));
  }

  void updateCustomerNumber(String value) {
    state = state.copyWith(customerNumber: int.parse(value));
  }

  Future<void> register() async {
    var id = state.isNew ? _uuid.v1() : state.id;
    var createdAt = state.isNew ? DateTime.now() : state.createdAt;
    var lastVisit = DateTime.now();
    var customer = Customer(
        id: id,
        firstName: state.firstName ?? '',
        lastName: state.lastName ?? '',
        lastVisit: lastVisit.toString(),
        createdAt: createdAt.toString(),
        phoneNumber: state.phoneNumber ?? 0,
        customerNumber: state.customerNumber ?? 0);
    _database.insert(customer);
  }
}