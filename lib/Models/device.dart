// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Device {
  final String? id;
  final String name;
  final String descrition;
  final bool swittch;
  final String deviceId;
  final String deviceType;
  final bool auto;
  final bool schedule;
  final bool isSensor;
  final String roomId;
  final String scheduleStartTime;
  final String scheduleEndTime;
  final String trigerId;
  final String trigerAction;
  final int triggerDelay; // min: 1  and max: 60
  final int triggerValue;
  Device({
    this.id,
    required this.name,
    required this.descrition,
    required this.swittch,
    required this.deviceId,
    required this.deviceType,
    required this.auto,
    required this.schedule,
    required this.isSensor,
    required this.roomId,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.trigerId,
    required this.trigerAction,
    required this.triggerDelay,
    required this.triggerValue,
  });
  

  Device copyWith({
    String? id,
    String? name,
    String? descrition,
    bool? swittch,
    String? deviceId,
    String? deviceType,
    bool? auto,
    bool? schedule,
    bool? isSensor,
    String? roomId,
    String? scheduleStartTime,
    String? scheduleEndTime,
    String? trigerId,
    String? trigerAction,
    int? triggerDelay,
    int? triggerValue,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      descrition: descrition ?? this.descrition,
      swittch: swittch ?? this.swittch,
      deviceId: deviceId ?? this.deviceId,
      deviceType: deviceType ?? this.deviceType,
      auto: auto ?? this.auto,
      schedule: schedule ?? this.schedule,
      isSensor: isSensor ?? this.isSensor,
      roomId: roomId ?? this.roomId,
      scheduleStartTime: scheduleStartTime ?? this.scheduleStartTime,
      scheduleEndTime: scheduleEndTime ?? this.scheduleEndTime,
      trigerId: trigerId ?? this.trigerId,
      trigerAction: trigerAction ?? this.trigerAction,
      triggerDelay: triggerDelay ?? this.triggerDelay,
      triggerValue: triggerValue ?? this.triggerValue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'descrition': descrition,
      'swittch': swittch,
      'deviceId': deviceId,
      'deviceType': deviceType,
      'auto': auto,
      'schedule': schedule,
      'isSensor': isSensor,
      'roomId': roomId,
      'scheduleStartTime': scheduleStartTime,
      'scheduleEndTime': scheduleEndTime,
      'trigerId': trigerId,
      'trigerAction': trigerAction,
      'triggerDelay': triggerDelay,
      'triggerValue': triggerValue,
    };
  }

  factory Device.fromMap(Map<dynamic, dynamic> map) {
    return Device(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      descrition: map['descrition'] as String,
      swittch: map['swittch'] as bool,
      deviceId: map['deviceId'] as String,
      deviceType: map['deviceType'] as String,
      auto: map['auto'] as bool,
      schedule: map['schedule'] as bool,
      isSensor: map['isSensor'] as bool,
      roomId: map['roomId'] as String,
      scheduleStartTime: map['scheduleStartTime'] as String,
      scheduleEndTime: map['scheduleEndTime'] as String,
      trigerId: map['trigerId'] as String,
      trigerAction: map['trigerAction'] as String,
      triggerDelay: map['triggerDelay'] as int,
      triggerValue: map['triggerValue'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DeviceType {
  static const String smartSwitch = 'Smart Switch';
  static const String smartPlug = "Smart Plug";
  static const String motionDetector = "Motion Detector";
  static const String smokeDetector = "Smoke Detector";
  static const String tempSensor = "Temprature Sensor";
  static const String distanceSensor = "Distance Sensor";
  static const String moistureSensor = "Moisture Sensor";

  static String? getDeviceType(String? id) {
    if (id == null) {
      return null;
    } else {
      switch (id.substring(0, 2)) {
        case 'SS':
          return smartSwitch;
        case 'SP':
          return smartPlug;
        case "MD":
          return motionDetector;
        case "SD":
          return smokeDetector;
        case "TS":
          return tempSensor;
        case "DS":
          return distanceSensor;
        case "MS":
          return moistureSensor;
        default:
          return "";
      }
    }
  }

  static String? getSensorKey(String? id) {
    if (id == null) {
      return null;
    } else {
      switch (id.substring(0, 2)) {
        case "MD":
          return "Sensitivity";
        case "SD":
          return "Sensitivity";
        case "TS":
          return "Temp";
        case "DS":
          return "Distanse";
        case "MS":
          return "Sensitivity";
        default:
          return "";
      }
    }
  }

  static String? getSensorUnit(String? id) {
    if (id == null) {
      return null;
    } else {
      switch (id.substring(0, 2)) {
        case "MD":
          return "";
        case "SD":
          return "";
        case "TS":
          return "degree";
        case "DS":
          return "m";
        case "MS":
          return "";
        default:
          return "";
      }
    }
  }

  static List<String> getSensors() {
    return [
      moistureSensor,
      motionDetector,
      smokeDetector,
      distanceSensor,
      tempSensor,
    ];
  }
}

class TrigerActions {
  static const String switchOn = "Switch On";
  static const String alarm = "Alarm";
  static const String switchOff = "Switch Off";

  static const List<String> list = [
    switchOff,
    switchOn,
    alarm,
  ];
}
