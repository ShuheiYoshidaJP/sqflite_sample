import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/other/constants.dart';
import 'package:sqflite_sample/pages/home/home_provider.dart';
import 'package:sqflite_sample/pages/register_customer/register_customer_view.dart';
import 'package:sqflite_sample/sub_view/home_list_tile.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(ref),
      body: _buildBody(ref),
      floatingActionButton: _buildFloatButton(context),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    final isShowingTextField =
        ref.watch(homeProvider.select((value) => value.isShowingTextField));
    return SafeArea(
      child: Column(
        children: [
          if (isShowingTextField) _buildSearchField(ref),
          _buildCustomerListView(ref)
        ],
      ),
    );
  }

  Widget _buildCustomerListView(WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    return homeState.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Flexible(
            child: ListView.builder(
                itemCount: homeState.customers.length,
                itemBuilder: (context, index) {
                  return HomeListTile(homeState.customers[index]);
                }),
          );
  }

  Widget _buildSearchField(WidgetRef ref) {
    final homeNotifier = ref.watch(homeProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: Constants.searchCustomer,
          suffixIcon: IconButton(
            onPressed: homeNotifier.tappedTextFieldClearButton,
            icon: const Icon(Icons.clear),
          ),
        ),
        onSubmitted: homeNotifier.onSubmitted,
        onChanged: homeNotifier.onChanged,
      ),
    );
  }

  Widget _buildFloatButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RegisterCustomerView()));
      },
      child: const Icon(Icons.add),
    );
  }

  PreferredSizeWidget? _buildAppBar(WidgetRef ref) {
    final isShowingTextField =
        ref.watch(homeProvider.select((value) => value.isShowingTextField));
    final homeNotifier = ref.watch(homeProvider.notifier);
    return isShowingTextField
        ? null
        : AppBar(
            actions: [
              IconButton(
                onPressed: homeNotifier.showTextField,
                icon: const Icon(Icons.search),
              )
            ],
          );
  }
}
