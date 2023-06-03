// ignore_for_file: public_member_api_docs, sort_constructors_first
class Trigger {
  final String? id;
  final String? name;
  final String? action;
  final double delay;
  final String? deviceId;
  final double value;
  Trigger({
    required this.action,
    required this.id,
    required this.name,
    required this.delay,
    required this.deviceId,
    required this.value,
  });

  Trigger copyWith({
    String? id,
    String? name,
    String? action,
    double? delay,
    String? deviceId,
    double? value,
  }) {
    return Trigger(
      id: id ?? this.id,
      name: name ?? this.name,
      action: action ?? this.action,
      delay: delay ?? this.delay,
      deviceId: deviceId ?? this.deviceId,
      value: value ?? this.value,
    );
  }

  bool isNull() {
    if (id == null || name == null || action == null || deviceId == null) {
      return true;
    } else {
      return false;
    }
  }
}
