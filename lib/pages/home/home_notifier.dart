import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/database/customer_database.dart';

import 'home_state.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final _database = CustomerDatabase();

  HomeStateNotifier() : super(const HomeState()) {
    fetch();
  }

  void showTextField() {
    state = state.copyWith(isShowingTextField: true);
  }

  void tappedTextFieldClearButton() {
    state = state.copyWith(isShowingTextField: false);
    fetch();
  }

  Future<void> fetch() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    var customerList = await _database.all();
    state = state.copyWith(isLoading: false, customers: customerList);
  }

  void onSubmitted(String text) {
    state = state.copyWith(isShowingTextField: false);
  }

  Future<void> onChanged(String text) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    var customerList = await _database.searchName(text);
    state = state.copyWith(
      isLoading: false,
      customers: customerList,
    );
  }

  void _sortByNumber() {
    state.customers.sort((customer1, customer2) {
      var comparable = customer1.hasNumber && customer2.hasNumber;
      if (comparable) {
        return state.listIsAsc
            ? customer1.customerNumber!.compareTo(customer2.customerNumber!)
            : customer2.customerNumber!.compareTo(customer1.customerNumber!);
      } else {
        return 1;
      }
    });
  }

  void toggleSortNumberButton() {
    state = state.copyWith(listIsAsc: !state.listIsAsc);
    _sortByNumber();
  }
}
