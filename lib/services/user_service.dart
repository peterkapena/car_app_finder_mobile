import 'dart:convert';
import 'package:car_app_finder_mobile/models/user.dart';
import 'package:car_app_finder_mobile/services/api_backend.dart';
import 'package:http/http.dart' as http;

class UserApiService extends ApiService {
  final String userUrl = "api/user/";

  Future<User> login() async {
    final response = await http.post(Uri.parse("$baseUrl$userUrl"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}