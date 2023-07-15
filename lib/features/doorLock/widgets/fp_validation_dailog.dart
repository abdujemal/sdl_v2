import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/doorLock/door_lock_controller.dart';

import '../../../Models/door_lock.dart';
import '../../../Models/user.dart';
import '../pages/door_lock_page.dart';

class FPVaildationDialog extends ConsumerStatefulWidget {
  final User user;
  const FPVaildationDialog(this.user, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FPVaildationDialogState();
}

class _FPVaildationDialogState extends ConsumerState<FPVaildationDialog> {
  bool isSuccessfull = false;
  DoorLock? doorLock;

  @override
  Widget build(BuildContext context) {
    doorLock = ref.watch(doorLockProvider);

    if (doorLock!.enroll == 4) {
      isSuccessfull = true;
    } else {
      isSuccessfull = false;
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: 100,
        height: 300,
        decoration: BoxDecoration(
          color: Pallete.inputBg,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  ref
                      .read(doorLockNotifierProvider.notifier)
                      .updateDoorLock(doorLock!.copyWith(enroll: 0));

                  if (!isSuccessfull) {
                    ref.read(doorLockNotifierProvider.notifier).updateUser(
                        widget.user.copyWith(fingerPrint: false), context,
                        noPop: true);
                  }

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            if (doorLock!.enroll == 4 || doorLock!.enroll == 5)
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    ref
                        .read(doorLockNotifierProvider.notifier)
                        .updateDoorLock(doorLock!.copyWith(enroll: 1));
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    doorLock!.getEnrollAsset(),
                    height: 100,
                    width: 100,
                    color: doorLock!.enroll == 5
                        ? Colors.red
                        : doorLock!.enroll == 2
                            ? Pallete.primaryColor.withAlpha(100)
                            : Pallete.primaryColor,
                  ),
                  const Spacer(),
                  Text(
                    doorLock!.getEnrollMsg(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const Spacer(),
                  doorLock!.enroll != 4 && doorLock!.enroll != 5
                      ? const Text("Waiting...")
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
