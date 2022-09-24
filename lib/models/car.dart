class Car {
  final String trackerSerialNumber;
  final String name;
  final String userId;

  Car(
      {required this.trackerSerialNumber,
      required this.name,
      required this.userId});

  Car.fromJson(Map<String, dynamic> json)
      : trackerSerialNumber = json['trackerSerialNumber'],
        name = json['name'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'trackerSerialNumber': trackerSerialNumber,
        'userId': userId,
      };
}
