import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/model/customer.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_notifier.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_state.dart';

final registerCustomerStateProvider = StateNotifierProvider.family<
    RegisterCustomerStateNotifier,
    RegisterCustomerState,
    Customer>((ref, customer) => RegisterCustomerStateNotifier(customer));
