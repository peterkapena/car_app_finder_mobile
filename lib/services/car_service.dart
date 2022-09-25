import 'dart:convert';
import 'package:car_app_finder_mobile/models/car.dart';
import 'package:car_app_finder_mobile/models/response_error.dart';
import 'package:car_app_finder_mobile/services/api_backend.dart';
import 'package:http/http.dart' as http;

class CarApiService extends ApiService {
  final String _carUrl = "api/car/";

  Future<Car> addCar(Car car) async {
    var url = "$baseUrl$_carUrl";
    var body = json.encode(car);

    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    if (response.statusCode == StatusCode.ok) {
      return Car.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == StatusCode.invalidData) {
      throw ServiceValidationException(
          ResponseError.fromJson(jsonDecode(response.body)).message);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future deleteCar(String trackerSerialNumber) async {
    var url = "$baseUrl$_carUrl$trackerSerialNumber";

    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode != 200) throw Exception(response.reasonPhrase);
  }

  Future<List<Car>> getCars(String userId) async {
    if (userId.isEmpty) return [];

    var url = "$baseUrl${_carUrl}getcars/$userId";

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Car> cars = List<Car>.from(l.map((model) => Car.fromJson(model)));
      return cars;
    } else if (response.statusCode == StatusCode.invalidData) {
      throw ServiceValidationException(
          ResponseError.fromJson(jsonDecode(response.body)).message);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
