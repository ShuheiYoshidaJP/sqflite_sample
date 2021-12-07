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

  int id;
  String firstName, lastName;
  String? kanaFirstName, kanaLastName, lastVisit, createdAt;
  int? phoneNumber, customerNumber;

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
}
