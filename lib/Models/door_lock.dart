import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sdl_v2/Models/activity.dart';

class DoorLock {
  final String deviceId;
  final int enroll; 
  //0: is static, 
  //1: is start inrolling: put your finger, 
  //2: is processing: pick your finger,
  //3: is processing: put your finger again,
  //4: is success 
  //5: is error;
  final String errorMsg;
  final int enrollId;
  final int open; // 0 or 1
  final List<Activity> activities;
  final List<String> code;
  DoorLock({
    required this.deviceId,
    required this.enroll,
    required this.errorMsg,
    required this.enrollId,
    required this.open,
    required this.activities,
    required this.code,
  });


  DoorLock copyWith({
    String? deviceId,
    int? enroll,
    String? errorMsg,
    int? enrollId,
    int? open,
    List<Activity>? activities,
    List<String>? code,
  }) {
    return DoorLock(
      deviceId: deviceId ?? this.deviceId,
      enroll: enroll ?? this.enroll,
      errorMsg: errorMsg ?? this.errorMsg,
      enrollId: enrollId ?? this.enrollId,
      open: open ?? this.open,
      activities: activities ?? this.activities,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'enroll': enroll,
      'errorMsg': errorMsg,
      'enrollId': enrollId,
      'open': open,
      'activities': activities.map((x) => x.toMap()).toList(),
      'code': code,
    };
  }

  factory DoorLock.fromMap(Map<String, dynamic> map) {
    return DoorLock(
      deviceId: map['deviceId'] ?? '',
      enroll: map['enroll']?.toInt() ?? 0,
      errorMsg: map['errorMsg'] ?? '',
      enrollId: map['enrollId']?.toInt() ?? 0,
      open: map['open']?.toInt() ?? 0,
      activities: List<Activity>.from(map['activities']?.map((x) => Activity.fromMap(x))),
      code: List<String>.from(map['code']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoorLock.fromJson(String source) => DoorLock.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DoorLock(deviceId: $deviceId, enroll: $enroll, errorMsg: $errorMsg, enrollId: $enrollId, open: $open, activities: $activities, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DoorLock &&
      other.deviceId == deviceId &&
      other.enroll == enroll &&
      other.errorMsg == errorMsg &&
      other.enrollId == enrollId &&
      other.open == open &&
      listEquals(other.activities, activities) &&
      listEquals(other.code, code);
  }

  @override
  int get hashCode {
    return deviceId.hashCode ^
      enroll.hashCode ^
      errorMsg.hashCode ^
      enrollId.hashCode ^
      open.hashCode ^
      activities.hashCode ^
      code.hashCode;
  }
}