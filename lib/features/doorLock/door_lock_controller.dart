import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/Models/door_lock.dart';
import 'package:sdl_v2/Models/user.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/features/doorLock/door_lock_repo.dart';

final doorLockNotifierProvider =
    StateNotifierProvider<DoorLocckNotifier, bool>((ref) {
  return DoorLocckNotifier(
    doorLockRepo: ref.read(doorLockRepoProvider),
    ref: ref,
  );
});

final userLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class DoorLocckNotifier extends StateNotifier<bool> {
  final DoorLockRepo doorLockRepo;
  final Ref ref;
  DoorLocckNotifier({required this.doorLockRepo, required this.ref})
      : super(false);

  updateDoorLock(DoorLock doorLock) async {
    final res = await doorLockRepo.updateDoorLock(doorLock);

    res.fold(
      (l) {
        toast(l.messege, Colors.red);
      },
      (r) {},
    );
  }

  updateUser(User user, BuildContext context, {noPop = false}) async {
    ref.read(userLoadingProvider.notifier).update((state) => true);
    final res = await doorLockRepo.updateUser(user);

    res.fold(
      (l) {
        ref.read(userLoadingProvider.notifier).update((state) => false);

        toast(l.messege, Colors.red);
      },
      (r) {
          ref.read(userLoadingProvider.notifier).update((state) => false);
        if (!noPop) {

          Navigator.pop(context);
        }
      },
    );
  }
}
