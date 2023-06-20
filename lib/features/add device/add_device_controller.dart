// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/core/constants.dart';

import 'package:sdl_v2/features/add%20device/add_device_repo.dart';
import 'package:sdl_v2/features/add%20sensor/add_sensor_controller.dart';
import 'package:sdl_v2/features/home/home_controller.dart';
import 'package:sdl_v2/main_page.dart';

final addDeviceNotifierProvider =
    StateNotifierProvider<AddDeviceNotifier, bool>((ref) {
  return AddDeviceNotifier(
    addDeviceRepo: ref.read(addDeviceProvider),
    ref: ref,
  );
});

class AddDeviceNotifier extends StateNotifier<bool> {
  final AddDeviceRepo addDeviceRepo;
  final Ref ref;
  AddDeviceNotifier({
    required this.addDeviceRepo,
    required this.ref,
  }) : super(false);

  editSchedule(String id, String key, String time, BuildContext context) async {
    final res = await addDeviceRepo.editSchedule(id, key, time);

    res.fold(
      (l) {
        toast(l.messege, Colors.red);
      },
      (r) {
        toast("successfully edited.", Colors.green);
        Navigator.pop(context);
      },
    );
  }

  deleteDevice(String id, BuildContext context) async {
    ref.read(deleteLoadingProvider.notifier).update((state) => true);

    final res = await addDeviceRepo.deleteDevice(id);

    res.fold((l) {
      ref.read(deleteLoadingProvider.notifier).update((state) => false);
      toast(l.messege, Colors.red);
      Navigator.pop(context);
    }, (r) {
      ref.read(deleteLoadingProvider.notifier).update((state) => false);
      toast("Device is deleted", Colors.green);
      Navigator.pop(context);
    });
  }

  addDevice(Device device, BuildContext context) async {
    ref.read(deviceLoadingProvider.notifier).update((state) => true);

    final res = await addDeviceRepo.addDevice(device);

    res.fold(
      (l) {
        ref.read(deviceLoadingProvider.notifier).update((state) => false);
        toast(l.messege, Colors.red);
      },
      (r) {
        ref.read(deviceLoadingProvider.notifier).update((state) => false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const MainPage(),
          ),
          (route) => false,
        );
      },
    );
  }

  updateDevice(Device device, BuildContext context) async {
    ref.read(deviceLoadingProvider.notifier).update((state) => true);

    final res = await addDeviceRepo.updateDevice(device);

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
