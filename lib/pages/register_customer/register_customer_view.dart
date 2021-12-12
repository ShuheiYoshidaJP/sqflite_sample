import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/database/customer_database.dart';
import 'package:sqflite_sample/model/customer.dart';
import 'package:sqflite_sample/other/constants.dart';
import 'package:sqflite_sample/pages/home/home_provider.dart';
import 'package:sqflite_sample/sub_view/wide_width_button.dart';
import 'package:uuid/uuid.dart';

class RegisterCustomerView extends HookConsumerWidget {
  RegisterCustomerView({Key? key, this.editingCustomer})
      : super(key: key);

  final _database = CustomerDatabase();

  final _uuid = const Uuid();

  /// this value is null if new registering,
  /// is not null if updating.
  final Customer? editingCustomer;

  Customer get _initializedCustomer {
    var isNew = editingCustomer == null;
    return isNew ? Customer.init() : editingCustomer!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firstNameController =
        TextEditingController(text: _initializedCustomer.firstName);
    final _lastNameController =
        TextEditingController(text: _initializedCustomer.lastName);
    final _phoneController = TextEditingController(
        text: _initializedCustomer.phoneNumber.toString());
    final _customerController = TextEditingController(
        text: _initializedCustomer.customerNumber.toString());
    final homeNotifier = ref.watch(homeProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextForms(
                _firstNameController,
                _lastNameController,
                _phoneController,
                _customerController,
              ),
              _buildSaveButton(() async {
                await register(
                  _firstNameController,
                  _lastNameController,
                  _phoneController,
                  _customerController,
                );
                Navigator.of(context).pop();
                homeNotifier.fetch();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextForms(
      TextEditingController firstName,
      TextEditingController lastName,
      TextEditingController phoneNumber,
      TextEditingController customerNumber) {
    return Column(
      children: [
        _buildForm(Customer.firstNamePlaceholder,
          firstName,
          TextInputType.text,),
        _buildForm(
          Customer.lastNamePlaceholder,
          lastName,
          TextInputType.text,
        ),
        _buildForm(
          Customer.phoneNumberTitle,
          phoneNumber,
          TextInputType.number,
        ),
        _buildForm(
          Customer.customerNumberTitle,
          customerNumber,
          TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildForm(
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
          keyboardType: keyboardType,
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

  Future<void> register(
      TextEditingController firstName,
      TextEditingController lastName,
      TextEditingController phoneNumber,
      TextEditingController customerNumber) async {
    var customerIsNew = editingCustomer == null;
    var id = customerIsNew ? _uuid.v1() : _initializedCustomer.id;
    var createdAt = customerIsNew ? DateTime.now() : _initializedCustomer.createdAt;
    var lastVisit = DateTime.now();
    var customer = Customer(
        id: id,
        firstName: firstName.text,
        lastName: lastName.text,
        lastVisit: lastVisit.toString(),
        createdAt: createdAt.toString(),
        phoneNumber: int.parse(phoneNumber.text),
        customerNumber: int.parse(customerNumber.text));
    _database.insert(customer);
  }

}
