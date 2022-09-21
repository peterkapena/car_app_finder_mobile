class User {
  final String email;
  final String passWord;
  final String id;
  final String token;

  User(this.email, this.passWord, this.token, this.id);

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        passWord = json['passWord'],
        id = json['id'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'passWord': passWord,
        'id': id,
        'token': token,
      };
}
