import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite_sample/model/customer.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<Customer> customers,
    @Default(false) bool isShowingTextField,
    @Default(true) bool listIsAsc,
  }) = _HomeState;
}
