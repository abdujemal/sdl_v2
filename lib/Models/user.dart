import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;
  final int id; //same with the fingerprint id  final String rfid;
  final String code;
  final bool rfid;
  User({
    required this.name,
    required this.id,
    required this.code,
    required this.rfid,
  });

  User copyWith({
    String? name,
    int? id,
    String? code,
    bool? rfid,
  }) {
    return User(
      name: name ?? this.name,
      id: id ?? this.id,
      code: code ?? this.code,
      rfid: rfid ?? this.rfid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'code': code,
      'rfid': rfid,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      code: map['code'] ?? '',
      rfid: map['rfid'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, id: $id, code: $code, rfid: $rfid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.id == id &&
      other.code == code &&
      other.rfid == rfid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      id.hashCode ^
      code.hashCode ^
      rfid.hashCode;
  }
}
