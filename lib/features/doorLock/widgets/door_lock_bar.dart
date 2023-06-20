import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/features/doorLock/door_loack_page.dart';

import '../../../core/theme.dart';

class DoorLockBar extends ConsumerWidget {
  final List<IconTab> items;
  const DoorLockBar(this.items, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? selectedIndex = ref.watch(doorLockIndexProvider);
    return Container(
      height: 130,
      decoration: BoxDecoration(
        boxShadow: shadow,
        color: Pallete.bgColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  items.length,
                  (index) => InkWell(
                    onTap: () {
                      if(index != 2){
                        ref.read(doorLockIndexProvider.notifier).update((state) => index);
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: selectedIndex == index ? Pallete.primaryColor : Pallete.bgColor,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            items[index].assetPath,
                            height: 43,
                            color: selectedIndex == index ? Pallete.cardColor : Pallete.primaryColor,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            items[index].text,
                            style: TextStyle(
                              color:selectedIndex == index ? Pallete.cardColor : Pallete.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class IconTab {
  final String assetPath;
  final String text;
  IconTab({
    required this.assetPath,
    required this.text,
  });
}
