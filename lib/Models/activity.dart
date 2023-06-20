import 'dart:convert';

class Activity {
  final int id;
  final String time; // the key of the map
  final int type;
  Activity({
    required this.id,
    required this.time,
    required this.type,
  });

  Activity copyWith({
    int? id,
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

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id']?.toInt() ?? 0,
      time: map['time'] ?? '',
      type: map['type']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source));

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
