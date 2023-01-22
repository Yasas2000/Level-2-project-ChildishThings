class User{
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;

  User({required this.id,required this.firstName,required this.lastName,required this.email,required this.phoneNumber,required this.password});

  factory User.fromJson(Map < String, dynamic > json){
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneno'],
      password: json['password'],
    );
  }
}