import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_customer_state.freezed.dart';

@freezed
class RegisterCustomerState with _$RegisterCustomerState {
  const factory RegisterCustomerState({
    required String id,
    required String firstName,
    required String lastName,
    required String lastVisit,
    required String createdAt,
    required int phoneNumber,
    required int customerNumber,
  }) = _RegisterCustomerState;
}
