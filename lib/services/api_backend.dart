import 'package:flutter/foundation.dart';

abstract class ApiService {
  final String baseUrl = kDebugMode
      ? "http://10.0.2.2:5068/"
      : "https://carappfinder.azurewebsites.net/";
}
