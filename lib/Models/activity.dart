import 'dart:convert';

class Activity {
  final String id;
  final String time; // the key of the map
  final int type;
  Activity({
    required this.id,
    required this.time,
    required this.type,
  });

  Activity copyWith({
    String? id,
    String? time,
    int? type,
  }) {
    return Activity(
      id: id ?? this.id,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'type': type,
    };
  }

  String getType() {
    switch (type) {
      case 1:
        return "Finger Print";
      case 2:
        return "Code";
      default:
        return "RFID";
    }
  }

  factory Activity.fromMap(Map<dynamic, dynamic> map) {
    return Activity(
      id: map['id'] ?? "",
      time: map['time'] ?? '',
      type: map['type']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source));

  @override
  String toString() => 'Activity(id: $id, time: $time, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.id == id &&
        other.time == time &&
        other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ time.hashCode ^ type.hashCode;
}
