class Customer {
  static String tableKey = 'customers';
  static String idKey = 'id';
  static String firstNameKey = 'firstName';
  static String lastNameKey = 'lastName';
  static String kanaFirstNameKey = 'kanaFirstName';
  static String kanaLastNameKey = 'kanaLastName';
  static String lastVisitKey = 'lastVisit';
  static String createdAtKey = 'createdAt';
  static String phoneNumberKey = 'phoneNumber';
  static String customerNumberKey = 'customerNumber';

  final int id;
  final String firstName, lastName;
  final String? kanaFirstName, kanaLastName, lastVisit, createdAt;
  final int? phoneNumber, customerNumber;

  String get fullName => '$firstName $lastName';

  Map<String, Object?> get toMap {
    return {
      Customer.idKey: id,
      Customer.firstNameKey: firstName,
      Customer.lastNameKey: lastName,
      Customer.kanaFirstNameKey: kanaFirstName,
      Customer.kanaLastNameKey: kanaLastName,
      Customer.lastVisitKey: lastVisit,
      Customer.createdAtKey: createdAt,
      Customer.phoneNumberKey: phoneNumber,
      Customer.customerNumberKey: customerNumber,
    };
  }

  Customer.init(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.kanaFirstName,
      this.kanaLastName,
      this.lastVisit,
      this.createdAt,
      this.phoneNumber,
      this.customerNumber});

  Customer.fromMap(Map<String, dynamic> map)
      : this.init(
          id: map[Customer.idKey],
          firstName: map[Customer.firstNameKey],
          lastName: map[Customer.lastNameKey],
          kanaFirstName: map[Customer.kanaFirstNameKey],
          kanaLastName: map[Customer.kanaLastNameKey],
          lastVisit: map[Customer.lastVisitKey],
          createdAt: map[Customer.createdAtKey],
          phoneNumber: map[Customer.phoneNumberKey],
          customerNumber: map[Customer.customerNumberKey],
        );
}
