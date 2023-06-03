// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/device%20device/widget/fake_slider.dart';
import 'package:sdl_v2/features/device%20device/widget/time_view.dart';
import 'package:sdl_v2/features/home/home_controller.dart';
import 'package:sdl_v2/main_page.dart';

class DeviceDetailPage extends ConsumerStatefulWidget {
  final String roomName;
  final int index;
  const DeviceDetailPage({
    super.key,
    required this.index,
    required this.roomName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeviceDetailPageState();
}

class _DeviceDetailPageState extends ConsumerState<DeviceDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Device device = ref.watch(devicesProvider)[widget.index];
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black45,
              size: 35,
            ),
          )
        ],
        title: Text(device.name),
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Image.asset(AssetConst.lightBulbImg),
              )),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 280),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Pallete.cardColor,
                          ),
                        ),
                        Text(
                          widget.roomName,
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                              color: Pallete.cardColor,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: Pallete.bgColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Switch",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              "OFF / ON",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CupertinoSwitch(
                              value: device.swittch,
                              activeColor: Pallete.primaryColor,
                              trackColor: device.swittch
                                  ? Pallete.primaryColor
                                  : const Color.fromARGB(255, 207, 207, 207),
                              thumbColor: Pallete.cardColor,
                              onChanged: (v) {
                                ref
                                    .read(homeNotifierProvider.notifier)
                                    .toggleDeviceSwitch(
                                      v,
                                      device.id!,
                                    );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // CupertinoSlider(value: 0.5, onChanged: (v){})
                        const FakeSlider(),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Schedule",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            CupertinoSwitch(
                              value: device.schedule,
                              activeColor: Pallete.primaryColor,
                              trackColor: device.schedule
                                  ? Pallete.primaryColor
                                  : const Color.fromARGB(255, 207, 207, 207),
                              thumbColor: Pallete.cardColor,
                              onChanged: (v) {
                                ref
                                    .read(homeNotifierProvider.notifier)
                                    .toggleDeviceSchedule(
                                      v,
                                      device.id!,
                                    );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Text(
                              "        Auto",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            CupertinoSwitch(
                              value: device.auto,
                              activeColor: Pallete.primaryColor,
                              trackColor: device.auto
                                  ? Pallete.primaryColor
                                  : const Color.fromARGB(255, 207, 207, 207),
                              thumbColor: Pallete.cardColor,
                              onChanged: (v) {
                                ref
                                    .read(homeNotifierProvider.notifier)
                                    .toggleDeviceAuto(
                                      v,
                                      device.id!,
                                    );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TimeView(
                              onTap: () {
                                
                              },
                              time: "12:00",
                              amPm: "pm",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "_____",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TimeView(
                              onTap: (){},
                              time: "12:00",
                              amPm: "pm",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
