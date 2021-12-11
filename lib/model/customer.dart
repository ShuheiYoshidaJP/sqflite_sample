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
  static int phoneNumberInitial = 0;
  static int customerNumberInitial = 1000;

  final int phoneNumber, customerNumber;
  final String id, firstName, lastName, createdAt, lastVisit;

  static const _uuid = Uuid();

  String get fullName => '$firstName $lastName';

  Map<String, Object?> get toMap {
    //var uuid = Uuid();
    //TODO:- introduce uuid
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
      required this.firstName,
      required this.lastName,
      required this.lastVisit,
      required this.createdAt,
      required this.phoneNumber,
      required this.customerNumber});

  Customer.init()
      : id = _uuid.v1(),
        firstName = firstNamePlaceholder,
        lastName = lastNamePlaceholder,
        lastVisit = lastVisitPlaceholder,
        createdAt = createdAtPlaceholder,
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
