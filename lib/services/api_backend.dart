import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class ApiService {
  final String baseUrl = kDebugMode
      ?
      // "http://10.0.2.2:5068/"
      "https://carappfinder1.azurewebsites.net/"
      : "https://carappfinder1.azurewebsites.net/";

  final Map<String, String>? headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
}
