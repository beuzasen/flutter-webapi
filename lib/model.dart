class User {
  final int Id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;

  const User(
      {required this.Id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password});

//user classtan instance yaratıyor parameter json olarak
  factory User.fromJson(Map<String, dynamic> json) => User(
      Id: json['id'] as int ?? 0,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      password: json['password'] as String? ?? '');

  //user objelerini json formatina çevirecek method
  Map<String, dynamic> toJson() => {
        "id": Id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password
      };
}
