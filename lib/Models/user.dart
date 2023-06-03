import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;
  final int fingerPrint;
  final String rfid;
  final String code;
  User({
    required this.name,
    required this.fingerPrint,
    required this.rfid,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'fingerPrint': fingerPrint,
      'rfid': rfid,
      'code': code,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      fingerPrint: map['fingerPrint'] as int,
      rfid: map['rfid'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? name,
    int? fingerPrint,
    String? rfid,
    String? code,
  }) {
    return User(
      name: name ?? this.name,
      fingerPrint: fingerPrint ?? this.fingerPrint,
      rfid: rfid ?? this.rfid,
      code: code ?? this.code,
    );
  }
}

