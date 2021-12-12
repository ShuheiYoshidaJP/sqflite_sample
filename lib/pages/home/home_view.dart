import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/pages/home/home_provider.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_view.dart';
import 'package:sqflite_sample/sub_view/home_list_tile.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(),
      body: homeState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(itemCount: homeState.customers.length,
          itemBuilder: (context, index) {
            return HomeListTile(homeState.customers[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RegisterCustomerView()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
