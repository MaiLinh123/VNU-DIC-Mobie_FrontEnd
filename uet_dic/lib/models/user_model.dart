class User {
  String email;
  String username;
  List words;

  User({this.username, this.email, this.words}) {
    print('Create user successful : ${this.username}');
  }

  factory User.fromJson(Map<String, dynamic> partedJson) {
    print(partedJson.toString());
    return User(
        username: partedJson['username'],
        email : partedJson['email'],
        words: partedJson['words']
    );
  }
  String userInformation() {
    return 'email: ${this.email} \n username: ${this.username} \n words: ${this.words}';
  }
}