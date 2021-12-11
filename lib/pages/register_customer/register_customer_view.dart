import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/model/customer.dart';
import 'package:sqflite_sample/other/constants.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_provider.dart';
import 'package:sqflite_sample/pages/home/home_provider.dart';
import 'package:sqflite_sample/sub_view/wide_width_button.dart';

class RegisterCustomerView extends HookConsumerWidget {
  RegisterCustomerView({Key? key, this.editingCustomer}) : super(key: key) {
    _customer = editingCustomer ?? Customer.init();
  }

  final Customer? editingCustomer;
  late final Customer _customer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
        ref.watch(registerCustomerStateProvider(_customer).notifier);
    final homeNotifier = ref.watch(homeProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextForms(ref),
              _buildSaveButton(() async {
                await notifier.register();
                Navigator.of(context).pop();
                homeNotifier.fetch();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextForms(WidgetRef ref) {
    final state = ref.watch(registerCustomerStateProvider(_customer));
    return Column(
      children: [
        _buildForm(Customer.firstNamePlaceholder, state.firstName,
            TextInputType.text, (value) => state.copyWith(firstName: value)),
        _buildForm(Customer.lastNamePlaceholder, state.lastName,
            TextInputType.text, (value) => state.copyWith(lastName: value)),
        _buildForm(
            Customer.lastVisitPlaceholder,
            state.lastVisit,
            TextInputType.datetime,
            (value) => state.copyWith(lastVisit: value)),
        _buildForm(
            Customer.createdAtPlaceholder,
            state.createdAt,
            TextInputType.datetime,
            (value) => state.copyWith(createdAt: value)),
        _buildForm(
            Customer.phoneNumberTitle,
            state.phoneNumber.toString(),
            TextInputType.number,
            (value) => state.copyWith(phoneNumber: int.parse(value))),
        _buildForm(
            Customer.customerNumberTitle,
            state.customerNumber.toString(),
            TextInputType.number,
            (value) => state.copyWith(customerNumber: int.parse(value))),
      ],
    );
  }

  Widget _buildForm(
    String label,
    String? initialText,
    TextInputType keyboardType,
    void Function(String)? onSubmitted,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        TextField(
          controller: TextEditingController(text: initialText),
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          keyboardType: keyboardType,
          onSubmitted: onSubmitted,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _buildSaveButton(void Function() onTap) {
    return WideWidthButton(
        text: Constants.save,
        textColor: Colors.white,
        backgroundColor: Colors.green,
        tapped: onTap);
  }
}
