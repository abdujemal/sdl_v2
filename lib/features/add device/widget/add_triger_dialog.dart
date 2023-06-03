import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/Models/trigger.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/main_page.dart';

final trigerProvider = StateProvider<Trigger?>((ref) {
  return null;
});

class AddTrigerDialog extends ConsumerStatefulWidget {
  const AddTrigerDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTrigerDialogState();
}

class _AddTrigerDialogState extends ConsumerState<AddTrigerDialog> {
  @override
  Widget build(BuildContext context) {
    final List<Device> sensors = ref.watch(sensorsProvider);
    final Trigger? trigger = ref.watch(trigerProvider);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          color: Pallete.cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 13,
              ),
              child: Text(
                "Sensor",
                style: TextStyle(
                  color: Pallete.primaryColor,
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pallete.cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 2,
                  )
                ],
              ),
              child: DropdownButton(
                value: trigger != null && trigger.name != null
                    ? sensors
                        .where(
                          (element) => trigger.name == element.name,
                        )
                        .toList()[0]
                    : null,
                items: sensors
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(width: 220, child: Text(e.name)),
                        ),
                      ),
                    )
                    .toList(),
                icon: const Icon(Icons.keyboard_arrow_down),
                underline: const SizedBox(),
                onChanged: (sensor) {
                  ref.read(trigerProvider.notifier).update(
                    (state) {
                      if (state != null) {
                        return state.copyWith(
                          name: sensor!.name,
                          id: sensor.id,
                          deviceId: sensor.deviceId,
                        );
                      } else {
                        return Trigger(
                          action: null,
                          id: sensor!.id!,
                          name: sensor.name,
                          delay: 1,
                          value: 1,
                          deviceId: sensor.deviceId,
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 13,
              ),
              child: Text(
                "Actions",
                style: TextStyle(
                  color: Pallete.primaryColor,
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pallete.cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 2,
                  )
                ],
              ),
              child: DropdownButton(
                value: trigger != null && trigger.action != null
                    ? TrigerActions.list
                        .where(
                          (element) => trigger.action == element,
                        )
                        .toList()
                        .first
                    : null,
                items: TrigerActions.list
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(width: 220, child: Text(e)),
                        ),
                      ),
                    )
                    .toList(),
                icon: const Icon(Icons.keyboard_arrow_down),
                underline: const SizedBox(),
                onChanged: (action) {
                  ref.read(trigerProvider.notifier).update(
                    (state) {
                      if (state != null) {
                        return state.copyWith(action: action);
                      } else {
                        return Trigger(
                          action: action,
                          deviceId: null,
                          id: null,
                          name: null,
                          delay: 1,
                          value: 1,
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 13,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Delay",
                    style: TextStyle(
                      color: Pallete.primaryColor,
                      fontSize: 19,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      "${trigger != null ? trigger.delay.toInt() : 0} min",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Slider(
              min: 1,
              max: 60,
              value: trigger != null ? trigger.delay : 1,
              activeColor: Pallete.primaryColor,
              onChanged: (v) {
                ref.read(trigerProvider.notifier).update(
                  (state) {
                    if (state != null) {
                      return state.copyWith(delay: v.round().toDouble());
                    } else {
                      return Trigger(
                        deviceId: null,
                        action: null,
                        id: null,
                        name: null,
                        delay: v.round().toDouble(),
                        value: 0,
                      );
                    }
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 13,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    trigger != null && trigger.deviceId != null
                        ? DeviceType.getSensorKey(trigger.deviceId)!
                        : "Value",
                    style: const TextStyle(
                      color: Pallete.primaryColor,
                      fontSize: 19,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      "${trigger != null ? trigger.value.toInt() : 0} ${trigger != null && trigger.deviceId != null ? DeviceType.getSensorUnit(trigger.deviceId)! : ""}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Slider(
              min: 1,
              max: 100,
              value: trigger != null ? trigger.value : 1,
              activeColor: Pallete.primaryColor,
              onChanged: (v) {
                ref.read(trigerProvider.notifier).update(
                  (state) {
                    if (state != null) {
                      return state.copyWith(value: v.round().toDouble());
                    } else {
                      return Trigger(
                        deviceId: null,
                        action: null,
                        id: null,
                        name: null,
                        delay: 0,
                        value: v.round().toDouble(),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
