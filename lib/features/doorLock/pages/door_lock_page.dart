import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sdl_v2/Models/door_lock.dart';
import 'package:sdl_v2/Models/user.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/doorLock/door_lock_controller.dart';
import 'package:sdl_v2/features/doorLock/pages/activities_tab.dart';
import 'package:sdl_v2/features/doorLock/pages/users_tab.dart';
import 'package:sdl_v2/features/doorLock/widgets/door_lock_bar.dart';

final doorLockIndexProvider = StateProvider<int?>((ref) {
  return null;
});

final doorLockProvider = StateProvider<DoorLock?>((ref) {
  return null;
});

final usersPrivider = StateProvider<User?>((ref) {
  return null;
});

class DoorLockPage extends ConsumerStatefulWidget {
  const DoorLockPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoorLockPageState();
}

class _DoorLockPageState extends ConsumerState<DoorLockPage> {
  List<IconTab> items = [
    IconTab(assetPath: AssetConst.activityIcon, text: "Activity"),
    IconTab(assetPath: AssetConst.userIcon, text: "Users"),
    IconTab(assetPath: AssetConst.keyIcon, text: "Keys"),
  ];

  List<Widget> tabs = [
    const ActivitiesTab(),
    const UsersTab(),
  ];

  StreamSubscription<DatabaseEvent>? doorLockStream;
  StreamSubscription<DatabaseEvent>? usersStream;

  @override
  void initState() {
    super.initState();

    usersStream =
        FirebaseDatabase.instance.ref().child("Users").onValue.listen((event) {
      if (event.snapshot.exists) {
        print(event.snapshot.value);
      }
    });

    doorLockStream = FirebaseDatabase.instance
        .ref()
        .child("DoorLock")
        .child('DL1234')
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        ref.read(doorLockProvider.notifier).update(
              (state) => DoorLock.fromMap(event.snapshot.value as Map),
            );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    doorLockStream!.cancel();
    usersStream!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedIndex = ref.watch(doorLockIndexProvider);
    DoorLock? doorLock = ref.watch(doorLockProvider);
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != null) {
          ref.read(doorLockIndexProvider.notifier).update((state) => null);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: selectedIndex == null
            ? doorLock == null
                ? const Center(
                    child: Text("Loading..."),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            print('clicked');
                            ref
                                .read(doorLockNotifierProvider.notifier)
                                .updateDoorLock(doorLock.copyWith(open: 1));
                            Future.delayed(const Duration(seconds: 3))
                                .then((value) {
                              ref
                                  .read(doorLockNotifierProvider.notifier)
                                  .updateDoorLock(doorLock.copyWith(open: 0));
                            });
                          },
                          borderRadius: BorderRadius.circular(100),
                          child: Ink(
                            height: 200,
                            width: 200,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Pallete.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  doorLock.open == 1
                                      ? AssetConst.lockIcon
                                      : AssetConst.unlockIcon,
                                  color: Pallete.cardColor,
                                  height: 120,
                                  width: 120,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  doorLock.open == 1 ? "Lock" : "Unlock",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.cardColor,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            : tabs[selectedIndex],
        bottomNavigationBar: DoorLockBar(items),
      ),
    );
  }
}
