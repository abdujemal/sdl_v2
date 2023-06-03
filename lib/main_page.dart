import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/add%20device/add_device_page.dart';
import 'package:sdl_v2/features/add%20sensor/add_sensor_page.dart';
import 'package:sdl_v2/features/home/widgets/add_room_sheet.dart';

import 'Models/room.dart';
import 'core/common/custom_bottom_nav.dart';
import 'features/camera/camera_page.dart';
import 'features/doorLock/door_loack_page.dart';
import 'features/home/home_page.dart';

final roomsProvider = StateProvider<List<Room>>((ref) {
  return [];
});

final sensorsProvider = StateProvider<List<Device>>((ref) {
  return [];
});

final devicesProvider = StateProvider<List<Device>>((ref) {
  return [];
});

final selectedRoomProvider = StateProvider<int>((ref) {
  return 0;
});

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final List<Widget> tabs = [
    const HomePage(),
    const CameraPage(),
    const DoorLockPage(),
  ];

  Stream<DatabaseEvent> roomsStream =
      FirebaseDatabase.instance.ref().child("Rooms").onValue;

  Stream<DatabaseEvent> sensorStream =
      FirebaseDatabase.instance.ref().child("Devices").onValue;

  Stream<DatabaseEvent> deviceStream =
      FirebaseDatabase.instance.ref().child("Devices").onValue;

  @override
  void initState() {
    super.initState();

    roomsStream.listen((dbevent) {
      if (dbevent.snapshot.exists) {
        final data = dbevent.snapshot.value as Map;
        List<Room> myRooms = [];
        for (var e in data.values) {
          myRooms.add(Room.fromMap(e));
        }
        ref.read(roomsProvider.notifier).update((state) => myRooms);
      }
    });

    sensorStream.listen((dbevent) {
      if (dbevent.snapshot.exists) {
        final data = dbevent.snapshot.value as Map;
        List<Device> sensors = [];
        for (var e in data.values) {
          if (e['isSensor'] as bool == true) {
            sensors.add(Device.fromMap(e));
          }
        }
        ref.read(sensorsProvider.notifier).update((state) => sensors);
      }
    });

    deviceStream.listen((dbevent) {
      if (dbevent.snapshot.exists) {
        final data = dbevent.snapshot.value as Map;
        List<Device> devices = [];
        for (var e in data.values) {
          devices.add(Device.fromMap(e));
        }
        ref.read(devicesProvider.notifier).update((state) => devices);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int selectedRoomIndex = ref.watch(selectedRoomProvider);
    final List<Room> rooms = ref.watch(roomsProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            AssetConst.menuIcon,
            height: 15,
          ),
          onPressed: () {},
        ),
        actions: [
          DropdownButton(
            value: "",
            items: ["", "Add Device", "Add Sensor"]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
            underline: const SizedBox(),
            onChanged: (v) {
              switch (v) {
                case "Add Device":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDevicePage(),
                    ),
                  );
                  break;
                case "Add Sensor":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddSensorPage(),
                    ),
                  );
                  break;
              }
            },
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                  rooms.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: InkWell(
                        onTap: () {
                          ref
                              .read(selectedRoomProvider.notifier)
                              .update((state) => index);
                        },
                        child: Ink(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Center(
                            child: Text(
                              rooms[index].name,
                              style: TextStyle(
                                fontSize: 23,
                                color: selectedRoomIndex == index
                                    ? Pallete.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddRoomSheet(),
                    );
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final index = ref.watch(currentTabProvider);
              return Expanded(child: tabs[index]);
            },
          )
        ],
      ),
    );
  }
}
