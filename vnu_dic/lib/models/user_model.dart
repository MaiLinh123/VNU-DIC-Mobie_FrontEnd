import 'dart:convert';

class User {
  String email;
  String password;
  Map information;

  User({this.email, this.password, this.information}) {
    print('=====> Create user successful : ${this.information['name']}');
  }

  factory User.fromJson(Map<String, dynamic> partedJson) {
    return User(
        email : partedJson['email'],
        password: partedJson['password'],
        information: partedJson['information']
    );
  }
  void userInformation() {
    print('email: ${this.email}');
    print('password: ${this.password}');
    print('information: ${this.information}');
  }
}