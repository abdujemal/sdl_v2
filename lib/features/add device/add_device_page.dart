import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/Models/room.dart';
import 'package:sdl_v2/Models/trigger.dart';
import 'package:sdl_v2/core/common/custom_btn.dart';
import 'package:sdl_v2/core/common/room_item.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/qr_screen.dart';
import 'package:sdl_v2/features/add%20device/add_device_controller.dart';
import 'package:sdl_v2/features/add%20device/widget/add_triger_dialog.dart';
import 'package:sdl_v2/features/add%20device/widget/trigger_display.dart';
import 'package:sdl_v2/features/add%20sensor/add_sensor_controller.dart';

import '../../core/common/custom_input.dart';
import '../../core/theme.dart';
import '../../main_page.dart';

class AddDevicePage extends ConsumerStatefulWidget {
  final Device? device;
  const AddDevicePage({this.device, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends ConsumerState<AddDevicePage> {
  TextEditingController deviceNameTc = TextEditingController();
  TextEditingController descriptionTc = TextEditingController();

  GlobalKey<FormState> deviceKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    deviceNameTc = TextEditingController();
    descriptionTc = TextEditingController();

    deviceKey = GlobalKey<FormState>();

    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   ref.read(qrDataProvider.notifier).update((state) => "SS2354");
    // });
    if (widget.device != null) {
      deviceNameTc.text = widget.device!.name;
      descriptionTc.text = widget.device!.descrition;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        ref.read(qrDataProvider.notifier).update((state) => widget.device!.id);

        if (widget.device!.trigerId != '') {
          ref.read(trigerProvider.notifier).update(
                (state) => Trigger(
                  action: widget.device!.trigerAction,
                  id: widget.device!.id,
                  name: widget.device!.triggerName,
                  delay: widget.device!.triggerDelay.toDouble(),
                  deviceId: widget.device!.id,
                  value: widget.device!.triggerValue.toDouble(),
                ),
              );
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        ref.read(qrDataProvider.notifier).update((state) => "SS2354");
        ref.read(trigerProvider.notifier).update((state) => null);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    deviceNameTc.dispose();
    descriptionTc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Trigger? trigger = ref.watch(trigerProvider);
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
        title: Text(widget.device != null ? "Edit Device" : "New Device"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: deviceKey,
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
                        hint: "Light Bulb",
                        controller: deviceNameTc,
                      ),
                      CustomInput(
                        title: "Description",
                        hint: "Corner Light",
                        controller: descriptionTc,
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
                  height: 20,
                ),
                if (trigger != null && !trigger.isNull())
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ref
                            .read(trigerProvider.notifier)
                            .update((state) => null);
                      },
                      child: const Text(
                        "Remove trigger",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                trigger != null && !trigger.isNull()
                    ? TriggerDisplay(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const AddTrigerDialog(),
                          );
                        },
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const AddTrigerDialog(),
                            );
                          },
                          child: const Text(
                            "Add trigger",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 25,
                ),
                Consumer(
                  builder: (context, ref, child) {
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
                              final Trigger? trigger = ref.read(trigerProvider);
                              if (deviceKey.currentState!.validate()) {
                                if (deviceId != null) {
                                  if (widget.device != null) {
                                    //updateing
                                    if (trigger != null && !trigger.isNull()) {
                                      ref
                                          .read(addDeviceNotifierProvider
                                              .notifier)
                                          .updateDevice(
                                            widget.device!.copyWith(
                                              name: deviceNameTc.text,
                                              descrition: descriptionTc.text,
                                              deviceType:
                                                  DeviceType.getDeviceType(
                                                      deviceId)!,
                                              roomId: rooms[selectedIndex].id,
                                              trigerId: trigger.id,
                                              triggerName: trigger.name,
                                              trigerAction: trigger.action,
                                              triggerDelay:
                                                  trigger.delay.toInt(),
                                              triggerValue:
                                                  trigger.value.toInt(),
                                            ),
                                            context,
                                          );
                                    } else {
                                      ref
                                          .read(addDeviceNotifierProvider
                                              .notifier)
                                          .updateDevice(
                                            widget.device!.copyWith(
                                              name: deviceNameTc.text,
                                              descrition: descriptionTc.text,
                                              deviceType:
                                                  DeviceType.getDeviceType(
                                                      deviceId)!,
                                              roomId: rooms[selectedIndex].id,
                                              trigerId: '',
                                              triggerName: '',
                                              trigerAction: '',
                                              triggerDelay: 0,
                                              triggerValue: 0,
                                            ),
                                            context,
                                          );
                                    }
                                  } else {
                                    //adding

                                    if (trigger != null && !trigger.isNull()) {
                                      ref
                                          .read(addDeviceNotifierProvider
                                              .notifier)
                                          .addDevice(
                                            Device(
                                              id: deviceId,
                                              name: deviceNameTc.text,
                                              descrition: descriptionTc.text,
                                              swittch: false,
                                              isSensor: false,
                                              deviceType:
                                                  DeviceType.getDeviceType(
                                                      deviceId)!,
                                              auto: false,
                                              schedule: false,
                                              roomId: rooms[selectedIndex].id,
                                              scheduleStartTime: '',
                                              scheduleEndTime: '',
                                              trigerId: trigger.id!,
                                              triggerName: trigger.name!,
                                              trigerAction: trigger.action!,
                                              triggerDelay:
                                                  trigger.delay.toInt(),
                                              triggerValue:
                                                  trigger.value.toInt(),
                                            ),
                                            context,
                                          );
                                    } else {
                                      ref
                                          .read(addDeviceNotifierProvider
                                              .notifier)
                                          .addDevice(
                                            Device(
                                              id: deviceId,
                                              name: deviceNameTc.text,
                                              descrition: descriptionTc.text,
                                              swittch: false,
                                              deviceType:
                                                  DeviceType.getDeviceType(
                                                      deviceId)!,
                                              auto: false,
                                              isSensor: false,
                                              schedule: false,
                                              roomId: rooms[selectedIndex].id,
                                              scheduleStartTime: '',
                                              scheduleEndTime: '',
                                              trigerId: '',
                                              triggerName: '',
                                              trigerAction: '',
                                              triggerDelay: 0,
                                              triggerValue: 0,
                                            ),
                                            context,
                                          );
                                    }
                                  }
                                } else {
                                  toast("Device Id is null.", Colors.orange);
                                }
                              }
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
