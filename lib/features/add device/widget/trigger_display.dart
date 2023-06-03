import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/Models/trigger.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/add%20device/widget/add_triger_dialog.dart';

class TriggerDisplay extends ConsumerWidget {
  final VoidCallback onTap;
  const TriggerDisplay({required this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Trigger? trigger = ref.watch(trigerProvider);

    titles(String t1, String t2) => Row(
          children: [
            Text(
              t1,
              style: const TextStyle(
                color: Pallete.primaryColor,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              t2,
              style: const TextStyle(
                color: Pallete.primaryColor,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

    values(String v1, String v2) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    v1,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    v2,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            )
          ],
        );

    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Pallete.inputBg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              titles(
                "Trigger",
                DeviceType.getSensorKey(
                  trigger!.deviceId,
                )!,
              ),
              const SizedBox(
                height: 10,
              ),
              values(trigger.name!,
                  "${trigger.value.toInt()} ${DeviceType.getSensorUnit(trigger.deviceId)}"),
              const SizedBox(
                height: 10,
              ),
              titles(
                "Action",
                "Delay",
              ),
              const SizedBox(
                height: 10,
              ),
              values(trigger.action!, "${trigger.delay.toInt()} min"),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
