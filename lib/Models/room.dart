import 'dart:convert';

class Room {
  final String id;
  final String name;
  Room({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Room.fromMap(Map<dynamic, dynamic> map) {
    return Room(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) => Room.fromMap(json.decode(source) as Map<String, dynamic>);
}
