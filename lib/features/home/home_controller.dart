import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/features/home/home_repo.dart';

final homeLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, bool>((ref) {
  return HomeNotifier(ref: ref, homeRepo: ref.read(homeRepoProvider));
});

class HomeNotifier extends StateNotifier<bool> {
  final Ref ref;
  final HomeRepo homeRepo;
  HomeNotifier({
    required this.ref,
    required this.homeRepo,
  }) : super(false);

  addRoom(String roomName, BuildContext context) async {
    ref.read(homeLoadingProvider.notifier).update((state) => true);

    final res = await homeRepo.addRoom(roomName);

    res.fold((l) {
      ref.read(homeLoadingProvider.notifier).update((state) => false);
      toast(l.messege, Colors.red);
      Navigator.pop(context);
    }, (r) {
      ref.read(homeLoadingProvider.notifier).update((state) => false);
      toast("Room is added", Colors.green);
      Navigator.pop(context);
    });
  }

  toggleDeviceSwitch(bool val, String id) async {
    final res = await homeRepo.toggleDeviceSwitch(val, id);

    res.fold(
      (l) {
        toast(l.messege, Colors.red);
      },
      (r) {},
    );
  }

  toggleDeviceSchedule(bool val, String id) async {
    final res = await homeRepo.toggleDeviceSchedule(val, id);

    res.fold(
      (l) {
        toast(l.messege, Colors.red);
      },
      (r) {},
    );
  }

  toggleDeviceAuto(bool val, String id) async {
    final res = await homeRepo.toggleDeviceAuto(val, id);

    res.fold(
      (l) {
        toast(l.messege, Colors.red);
      },
      (r) {},
    );
  }
}
