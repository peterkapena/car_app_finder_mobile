import 'dart:convert';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:car_app_finder_mobile/services/api_backend.dart';
import 'package:http/http.dart' as http;

class UserApiService extends ApiService {
  final String userUrl = "api/user/";

  Future<User> login(XUser user) async {
    var url = "$baseUrl$userUrl";
    var body = json.encode(user);

    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }
}

class XUser {
  final String? id;
  final String? email;
  final String? password;
  String? tokenForAnonymous = "XXXXXXXXXXXXXXX";

  XUser({this.id, this.email, this.password, this.tokenForAnonymous});
}
