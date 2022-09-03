class Tracker {
  final String id;
  final String position;

  Tracker(this.id, this.position);

  Tracker.fromJson(Map<String, dynamic> json, this.id)
      : position = json['position'];

  Map<String, dynamic> toJson() => {
        'position': position,
      };
}

enum TrackerQuery { trackerId }
