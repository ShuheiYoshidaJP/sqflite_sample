import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/model/customer.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_notifier.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_state.dart';

final registerCustomerStateProvider = StateNotifierProvider.autoDispose.family<
    RegisterCustomerStateNotifier,
    RegisterCustomerState,
    Customer?>((ref, customer) {
      var isNew = customer == null;
      var editingCustomer = isNew ? Customer.init() : customer!;
      var state = RegisterCustomerState(
          isNew: isNew,
          id: editingCustomer.id,
          firstName: editingCustomer.firstName,
          lastName: editingCustomer.lastName,
          lastVisit: editingCustomer.lastVisit,
          createdAt: editingCustomer.createdAt,
          phoneNumber: editingCustomer.phoneNumber,
          customerNumber: editingCustomer.customerNumber);
      return RegisterCustomerStateNotifier(state);
});
