import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/database/customer_database.dart';
import 'package:sqflite_sample/model/customer.dart';
import 'package:sqflite_sample/other/constants.dart';
import 'package:sqflite_sample/pages/home/home_provider.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_view.dart';

class HomeListTile extends HookConsumerWidget {
  HomeListTile(this.customer, {Key? key}) : super(key: key);

  final Customer customer;

  final _database = CustomerDatabase();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RegisterCustomerView(
                  editingCustomer: customer,
                )));
      },
      onLongPress: () async {
        await _showDeleteDialog(context, ref);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(customer.fullName),
              Text('TEL: ${customer.phoneNumber}'),
              Text('No. ${customer.customerNumber}'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, WidgetRef ref) async {
    await showDialog(
        context: context,
        builder: (_) {
          final homeNotifier = ref.watch(homeProvider.notifier);
          return AlertDialog(
            title: Text(Constants.caution),
            content: Text(Constants.deleteCustomer),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(Constants.cancel),
              ),
              TextButton(
                onPressed: () async {
                  await _database.delete(customer);
                  Navigator.pop(context);
                  homeNotifier.fetch();
                },
                child: Text(Constants.ok),
              )
            ],
          );
        });
  }
}
