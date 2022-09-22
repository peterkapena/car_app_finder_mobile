import 'dart:convert';
import 'dart:io';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:car_app_finder_mobile/services/api_backend.dart';
import 'package:http/http.dart' as http;

class UserApiService extends ApiService {
  final String userUrl = "api/user/";

  Future<User?> login(User user) async {
    var url = "$baseUrl$userUrl";
    var body = json.encode(user);

    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
