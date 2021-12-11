import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_sample/database/customer_database.dart';

import 'home_state.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {

  final _database = CustomerDatabase();

  HomeStateNotifier() : super(const HomeState()) {
    fetch();
  }

  Future<void> fetch() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    var customerList = await _database.all();
    state = state.copyWith(isLoading: false, customers: customerList);
  }
}
