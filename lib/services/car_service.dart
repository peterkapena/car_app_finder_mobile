import 'dart:convert';
import 'dart:io';
import 'package:car_app_finder_mobile/models/car.dart';
import 'package:car_app_finder_mobile/services/api_backend.dart';
import 'package:http/http.dart' as http;

class CarApiService extends ApiService {
  final String carUrl = "api/car/";

  Future<Car> addCar(Car car) async {
    var url = "$baseUrl$carUrl";
    var body = json.encode(car);

    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Car.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Car>> getCars(String userId) async {
    if (userId.isEmpty) return [];

    var url = "$baseUrl${carUrl}getcars/$userId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Car> cars = List<Car>.from(l.map((model) => Car.fromJson(model)));
      return cars;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
