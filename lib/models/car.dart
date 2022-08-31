class Car {
  final String name;
  final String trackerId;
  final String userId;

  Car({required this.name, required this.trackerId, required this.userId});

  Car.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        trackerId = json['trackerId'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'trackerId': trackerId,
        'userId': userId,
      };
}
