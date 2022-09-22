class User {
  final String? email;
  final String? password;
  final String? id;
  final String? token;
  String? get tokenForAnonymous => token;

  User({this.email, this.password, this.token, this.id});
  // User({this.id, this.email, this.passWord, this.token});

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['passWord'],
        id = json['id'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'passWord': password,
        'id': id,
        'token': token,
      };
}
