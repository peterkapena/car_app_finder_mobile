import 'dart:convert';
import 'dart:io';
import 'package:car_app_finder_mobile/models/response_error.dart';
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
      headers: headers,
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == StatusCode.invalidData) {
      throw ServiceValidationException(
          ResponseError.fromJson(jsonDecode(response.body)).message);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
