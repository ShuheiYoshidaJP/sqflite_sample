import 'package:uuid/uuid.dart';

class Customer {
  static String tableKey = 'Customer';
  static String idKey = 'id';
  static String firstNameKey = 'firstName';
  static String lastNameKey = 'lastName';
  static String lastVisitKey = 'lastVisit';
  static String createdAtKey = 'createdAt';
  static String phoneNumberKey = 'phoneNumber';
  static String customerNumberKey = 'customerNumber';

  static String firstNamePlaceholder = 'FirstName';
  static String lastNamePlaceholder = 'LastName';
  static String lastVisitPlaceholder = 'Last Visit';
  static String createdAtPlaceholder = 'Created At';
  static String phoneNumberTitle = 'Phone Number';
  static String customerNumberTitle = 'Customer Number';
  static String phoneNumberInitial = '0';
  static String customerNumberInitial = '1000';

  final String id;
  final String? firstName,
      lastName,
      createdAt,
      lastVisit,
      phoneNumber,
      customerNumber;

  static const _uuid = Uuid();

  String get fullName => '$firstName $lastName';

  Map<String, Object?> get toMap {
    return {
      Customer.idKey: id,
      Customer.firstNameKey: firstName,
      Customer.lastNameKey: lastName,
      Customer.lastVisitKey: lastVisit,
      Customer.createdAtKey: createdAt,
      Customer.phoneNumberKey: phoneNumber,
      Customer.customerNumberKey: customerNumber,
    };
  }

  Customer(
      {required this.id,
      this.firstName,
      this.lastName,
      this.lastVisit,
      this.createdAt,
      this.phoneNumber,
      this.customerNumber});

  Customer.init()
      : id = _uuid.v1(),
        firstName = null,
        lastName = null,
        lastVisit = null,
        createdAt = null,
        phoneNumber = phoneNumberInitial,
        customerNumber = customerNumberInitial;

  Customer.fromMap(Map<String, dynamic> map)
      : this(
          id: map[Customer.idKey],
          firstName: map[Customer.firstNameKey],
          lastName: map[Customer.lastNameKey],
          createdAt: map[Customer.createdAtKey],
          lastVisit: map[Customer.lastVisitKey],
          phoneNumber: map[Customer.phoneNumberKey],
          customerNumber: map[Customer.customerNumberKey],
        );
}
