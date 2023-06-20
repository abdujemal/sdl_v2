// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/core/common/delete_dialog.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/add%20device/add_device_controller.dart';
import 'package:sdl_v2/features/device%20detail/device_detail_page.dart';
import 'package:sdl_v2/features/home/home_controller.dart';

class DeviceCard extends ConsumerWidget {
  final Device device;
  final String roomName;
  final int index;
  const DeviceCard({super.key, 
    required this.device,
    required this.roomName,
    required this.index,
  });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (_) => DeleteDialog(
            action: () {
              ref.read(addDeviceNotifierProvider.notifier).deleteDevice(
                    device.id!,
                    context,
                  );
            },
            title: device.name,
          ),
        );
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailPage(
              
              roomName: roomName,
              index: index,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: shadow,
          color: device.swittch ? Pallete.cardColor : Pallete.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AssetConst.lightIcon,
                    height: 50,
                    color: device.swittch
                        ? Pallete.primaryColor
                        : Pallete.cardColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 98,
                    child: Text(
                      device.name,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: device.swittch
                            ? Pallete.primaryColor
                            : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      device.descrition,
                      style: TextStyle(
                        fontSize: 13,
                        color: device.swittch
                            ? Pallete.primaryColor
                            : Colors.white70,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: CupertinoSwitch(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
