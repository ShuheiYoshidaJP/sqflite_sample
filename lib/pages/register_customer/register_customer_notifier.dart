import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/database/customer_database.dart';
import 'package:sqflite_sample/model/customer.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_state.dart';

class RegisterCustomerStateNotifier extends StateNotifier<RegisterCustomerState> {
  RegisterCustomerStateNotifier(Customer customer)
      : super(RegisterCustomerState(
            id: customer.id,
            firstName: customer.firstName,
            lastName: customer.lastName,
            lastVisit: customer.lastVisit,
            createdAt: customer.createdAt,
            phoneNumber: customer.phoneNumber,
            customerNumber: customer.customerNumber));

  final _database = CustomerDatabase();

  Customer get toCustomer => Customer(
      id: state.id,
      firstName: state.firstName,
      lastName: state.lastName,
      lastVisit: state.lastVisit,
      createdAt: state.createdAt,
      phoneNumber: state.phoneNumber,
      customerNumber: state.customerNumber);

  Future<void> register() async {
    var customer = toCustomer;
    _database.insert(customer);
  }
}