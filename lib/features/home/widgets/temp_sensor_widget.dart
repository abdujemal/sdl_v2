import 'package:flutter/material.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/home/widgets/custom_progress.dart';

class TempSensorWidget extends StatelessWidget {
  final Device device;
  const TempSensorWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 15,),
      decoration: BoxDecoration(
          boxShadow: shadow,
          color: Pallete.cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    "Current temp",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '${device.value1.toString()}\u2103',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  const Text(
                    "Humidity",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '${device.value2!.toInt().toString()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  )
                ],
              )
            ],
          ),
          CustomProgress(value: device.value1!)
        ],
      ),
    );
  }
}
