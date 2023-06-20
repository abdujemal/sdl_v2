import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/Models/room.dart';
import 'package:sdl_v2/features/home/widgets/device_card.dart';
import 'package:sdl_v2/features/home/widgets/song.dart';
import 'package:sdl_v2/features/home/widgets/temp_sensor_widget.dart';
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
    Device? tempSensor;
    int selectedRoomindex = ref.watch(selectedRoomProvider);
    List<Room> rooms = ref.watch(roomsProvider);

    print((devices.length/2).ceil());

    if (devices.isNotEmpty && rooms.isNotEmpty) {
      devices = devices
          .where(
            (e) => e.roomId == rooms[selectedRoomindex].id,
          )
          .toList();
      
      final List<Device> tempSensors = devices.where((e) => DeviceType.getDeviceType(e.deviceId) ==
              DeviceType.tempSensor).toList();
      if(tempSensors.isNotEmpty){
        tempSensor = tempSensors[0];        
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: devices.isNotEmpty && rooms.isNotEmpty ? SizedBox(
          width: double.infinity,
          height: devices.isEmpty ? 400 : 91 + 160 + (devices.length/2).ceil() * 158,
          child: Column(
            children: [
              const Song(),
              Expanded(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 27,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
              if(tempSensor != null)
              TempSensorWidget(device: tempSensor)
            ],
          ),
        ): const SizedBox(),
      ),
    );
  }
}
