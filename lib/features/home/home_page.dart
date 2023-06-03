import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/Models/room.dart';
import 'package:sdl_v2/features/home/widgets/device_card.dart';
import 'package:sdl_v2/features/home/widgets/song.dart';
import 'package:sdl_v2/main_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Device> devices = ref.watch(devicesProvider);
    int selectedRoomindex = ref.watch(selectedRoomProvider);
    List<Room> rooms = ref.watch(roomsProvider);

    if (devices.isNotEmpty) {
      devices = devices
          .where(
            (e) => e.roomId == rooms[selectedRoomindex].id,
          )
          .toList();
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: SizedBox(
          height: devices.isEmpty ? 400 : 200 + devices.length.toDouble() * 100,
          child: Column(
            children: [
              const Song(),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 27,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.15 / 1,
                  ),
                  itemCount: devices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DeviceCard(
                      device: devices[index],
                      roomName: rooms[selectedRoomindex].name,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
