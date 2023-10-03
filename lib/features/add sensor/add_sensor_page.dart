import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sdl_v2/Models/room.dart';
import 'package:sdl_v2/core/common/custom_btn.dart';
import 'package:sdl_v2/core/common/custom_input.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/qr_screen.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/add%20sensor/add_sensor_controller.dart';
import 'package:sdl_v2/main_page.dart';

import '../../Models/device.dart';
import '../../core/common/room_item.dart';

class AddSensorPage extends ConsumerStatefulWidget {
  const AddSensorPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSensorPageState();
}

class _AddSensorPageState extends ConsumerState<AddSensorPage> {
  TextEditingController deviceNameTc = TextEditingController();
  TextEditingController descritionTc = TextEditingController();

  GlobalKey<FormState> sensorKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      ref.read(qrDataProvider.notifier).update((state) => "TS2354");
    });
  }

  @override
  void dispose() {
    super.dispose();
    deviceNameTc.dispose();
    descritionTc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: SvgPicture.asset(
            AssetConst.menuIcon,
            height: 15,
          ),
          onPressed: () {},
        ),
        title: const Text("New Sensor"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: sensorKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Pallete.inputBg,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      CustomInput(
                        title: "Device name",
                        hint: "Motion Sensor",
                        controller: deviceNameTc,
                      ),
                      CustomInput(
                        title: "Description",
                        hint: "For Light",
                        controller: descritionTc,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 30,
                          right: 25,
                          left: 27,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                String? deviceId = ref.watch(qrDataProvider);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Device ID : $deviceId",
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Device Type : ${DeviceType.getDeviceType(deviceId)}",
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QrScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "QR",
                                style: TextStyle(
                                    color: Pallete.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Select Room",
                    style: TextStyle(
                      color: Pallete.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final List<Room> rooms = ref.watch(roomsProvider);
                        final int selectedIndex =
                            ref.watch(selectedRoomProvider);
                        return ListView.builder(
                          itemCount: rooms.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => RoomItem(
                            isActive: index == selectedIndex,
                            name: rooms[index].name,
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Consumer(builder: (context, ref, child) {
                  final isLoading = ref.watch(deviceLoadingProvider);
                  return isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Pallete.primaryColor,
                          ),
                        )
                      : CustomBtn(
                          text: "Done",
                          margin: 20,
                          onTap: () {
                            String? deviceId = ref.read(qrDataProvider);
                            final List<Room> rooms = ref.watch(roomsProvider);
                            final int selectedIndex =
                                ref.watch(selectedRoomProvider);
                            if (sensorKey.currentState!.validate()) {
                              if (deviceId != null) {
                                ref
                                    .read(addSensorNotifierProvider.notifier)
                                    .addSensor(
                                      Device(
                                        id: deviceId,
                                        name: deviceNameTc.text,
                                        descrition: descritionTc.text,
                                        swittch: false,
                                        deviceType:
                                            DeviceType.getDeviceType(deviceId)!,
                                        auto: false,
                                        schedule: false,
                                        isSensor: true,
                                        roomId: rooms[selectedIndex].id,
                                        scheduleStartTime: '',
                                        scheduleEndTime: '',
                                        trigerId: '',
                                        triggerName: '',
                                        trigerAction: '',
                                        triggerDelay: 0,
                                        triggerValue: 0,
                                        value1: 0,
                                        value2: 0,
                                      ),
                                      context,
                                    );
                              } else {
                                toast("Device Id is null.", Colors.orange);
                              }
                            }
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
