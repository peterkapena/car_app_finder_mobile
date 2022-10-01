import 'dart:io';

abstract class ApiService {
  final String baseUrl =
      // "http://10.0.2.2:5068/";
      "https://carappfinder.azurewebsites.net/";

  final Map<String, String>? headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
}
