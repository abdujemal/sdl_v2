import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;
  final int id; //same with the fingerprint id  final String rfid;
  final String code;
  final bool rfid;
  final bool fingerPrint;
  User({
    required this.name,
    required this.id,
    required this.code,
    required this.rfid,
    required this.fingerPrint,
  });

  User copyWith({
    String? name,
    int? id,
    String? code,
    bool? rfid,
    bool? fingerPrint,
  }) {
    return User(
      name: name ?? this.name,
      id: id ?? this.id,
      code: code ?? this.code,
      rfid: rfid ?? this.rfid,
      fingerPrint: fingerPrint ?? this.fingerPrint,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'code': code,
      'rfid': rfid,
      'fingerprint': fingerPrint,
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      name: map['name'] as String,
      id: map['id'] as int,
      code: map['code'] as String,
      rfid: map['rfid'] as bool,
      fingerPrint: map['fingerprint'] as bool,
    );
  }

  getTypes() {
    List<String> types = [];
    if (fingerPrint) {
      types.add("Fingerprint");
    }
    if (rfid) {
      types.add("RFID");
    }
    if (code.isNotEmpty) {
      types.add("Code");
    }
    return types.join(", ");
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, id: $id, code: $code, rfid: $rfid, fingerPrint: $fingerPrint)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.code == code &&
        other.rfid == rfid &&
        other.fingerPrint == fingerPrint;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        code.hashCode ^
        rfid.hashCode ^
        fingerPrint.hashCode;
  }
}
