// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Device {
  final String id;
  final String? deviceId;
  final String name;
  final String descrition;
  final double? value1;
  final double? value2;
  final bool swittch;
  final String deviceType;
  final bool auto;
  final bool schedule;
  final bool isSensor;
  final String roomId;
  final String scheduleStartTime;
  final String scheduleEndTime;
  final String trigerId;
  final String triggerName;
  final String trigerAction;
  final int triggerDelay; // min: 1  and max: 60
  final int triggerValue;

  Device({
    required this.id,
    required this.name,
    required this.descrition,
    this.deviceId,
    this.value1,
    this.value2,
    required this.swittch,
    required this.deviceType,
    required this.auto,
    required this.schedule,
    required this.isSensor,
    required this.roomId,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.trigerId,
    required this.triggerName,
    required this.trigerAction,
    required this.triggerDelay,
    required this.triggerValue,
  });

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source));

  Device copyWith({
    String? id,
    String? deviceId,
    String? name,
    String? descrition,
    double? value1,
    double? value2,
    bool? swittch,
    String? deviceType,
    bool? auto,
    bool? schedule,
    bool? isSensor,
    String? roomId,
    String? scheduleStartTime,
    String? scheduleEndTime,
    String? trigerId,
    String? triggerName,
    String? trigerAction,
    int? triggerDelay,
    int? triggerValue,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      deviceId: deviceId ?? this.deviceId,
      descrition: descrition ?? this.descrition,
      value1: value1 ?? this.value1,
      value2: value2 ?? this.value2,
      swittch: swittch ?? this.swittch,
      deviceType: deviceType ?? this.deviceType,
      auto: auto ?? this.auto,
      schedule: schedule ?? this.schedule,
      isSensor: isSensor ?? this.isSensor,
      roomId: roomId ?? this.roomId,
      scheduleStartTime: scheduleStartTime ?? this.scheduleStartTime,
      scheduleEndTime: scheduleEndTime ?? this.scheduleEndTime,
      trigerId: trigerId ?? this.trigerId,
      triggerName: triggerName ?? this.triggerName,
      trigerAction: trigerAction ?? this.trigerAction,
      triggerDelay: triggerDelay ?? this.triggerDelay,
      triggerValue: triggerValue ?? this.triggerValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deviceId': deviceId,
      'name': name,
      'descrition': descrition,
      'value1': value1,
      'value2': value2,
      'swittch': swittch,
      'deviceType': deviceType,
      'auto': auto,
      'schedule': schedule,
      'isSensor': isSensor,
      'roomId': roomId,
      'scheduleStartTime': scheduleStartTime,
      'scheduleEndTime': scheduleEndTime,
      'trigerId': trigerId,
      'triggerName': triggerName,
      'trigerAction': trigerAction,
      'triggerDelay': triggerDelay,
      'triggerValue': triggerValue,
    };
  }

  factory Device.fromMap(Map<dynamic, dynamic> map) {
    return Device(
      id: map['id'],
      deviceId: map['deviceId'],
      name: map['name'] ?? '',
      descrition: map['descrition'] ?? '',
      value1: map['value1']?.toDouble(),
      value2: map['value2']?.toDouble(),
      swittch: map['swittch'] ?? false,
      deviceType: map['deviceType'] ?? '',
      auto: map['auto'] ?? false,
      schedule: map['schedule'] ?? false,
      isSensor: map['isSensor'] ?? false,
      roomId: map['roomId'] ?? '',
      scheduleStartTime: map['scheduleStartTime'] ?? '',
      scheduleEndTime: map['scheduleEndTime'] ?? '',
      trigerId: map['trigerId'] ?? '',
      triggerName: map['triggerName'] ?? '',
      trigerAction: map['trigerAction'] ?? '',
      triggerDelay: map['triggerDelay']?.toInt() ?? 0,
      triggerValue: map['triggerValue']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'Device(id: $id, name: $name, descrition: $descrition, value1: $value1, value2: $value2, swittch: $swittch, deviceType: $deviceType, auto: $auto, schedule: $schedule, isSensor: $isSensor, roomId: $roomId, scheduleStartTime: $scheduleStartTime, scheduleEndTime: $scheduleEndTime, trigerId: $trigerId, triggerName: $triggerName, trigerAction: $trigerAction, triggerDelay: $triggerDelay, triggerValue: $triggerValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Device &&
        other.id == id &&
        other.name == name &&
        other.descrition == descrition &&
        other.value1 == value1 &&
        other.value2 == value2 &&
        other.swittch == swittch &&
        other.deviceType == deviceType &&
        other.auto == auto &&
        other.schedule == schedule &&
        other.isSensor == isSensor &&
        other.roomId == roomId &&
        other.scheduleStartTime == scheduleStartTime &&
        other.scheduleEndTime == scheduleEndTime &&
        other.trigerId == trigerId &&
        other.triggerName == triggerName &&
        other.trigerAction == trigerAction &&
        other.triggerDelay == triggerDelay &&
        other.triggerValue == triggerValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        descrition.hashCode ^
        value1.hashCode ^
        value2.hashCode ^
        swittch.hashCode ^
        deviceType.hashCode ^
        auto.hashCode ^
        schedule.hashCode ^
        isSensor.hashCode ^
        roomId.hashCode ^
        scheduleStartTime.hashCode ^
        scheduleEndTime.hashCode ^
        trigerId.hashCode ^
        triggerName.hashCode ^
        trigerAction.hashCode ^
        triggerDelay.hashCode ^
        triggerValue.hashCode;
  }
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
