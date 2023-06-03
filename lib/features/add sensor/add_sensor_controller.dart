import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/features/add%20sensor/add_sensor_repo.dart';


final deviceLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final addSensorNotifierProvider =
    StateNotifierProvider<AddSensorNotifier, bool>(
  (ref) {
    return AddSensorNotifier(
      addSensorRepo: ref.read(AddSensorProvider),
      ref: ref,
    );
  },
);

class AddSensorNotifier extends StateNotifier<bool> {
  final AddSensorRepo addSensorRepo;
  final Ref ref;
  AddSensorNotifier({
    required this.addSensorRepo,
    required this.ref,
  }) : super(false);

  addSensor(Device sensor, BuildContext context) async {
    ref.read(deviceLoadingProvider.notifier).update((state) => true);

    final res = await addSensorRepo.addSensor(sensor);

    res.fold(
      (l) {
        ref.read(deviceLoadingProvider.notifier).update((state) => false);
        toast(l.messege, Colors.red);
      },
      (r) {
        ref.read(deviceLoadingProvider.notifier).update((state) => false);
        Navigator.pop(context);
      },
    );
  }
}
