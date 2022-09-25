class ResponseError {
  final String message;
  final int statusCode;

  ResponseError(this.message, this.statusCode);

  ResponseError.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        statusCode = json['statusCode'];

  Map<String, dynamic> toJson() =>
      {'message': message, 'statusCode': statusCode};
}

class StatusCode {
  static const int ok = 200;
  static const int internalServerError = 500;
  static const int invalidData = 400;
}

class ServiceValidationException implements Exception {
  final String msg;
  const ServiceValidationException(this.msg);

  @override
  String toString() => 'Validation: $msg';
}
