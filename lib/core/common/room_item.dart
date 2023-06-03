import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/main_page.dart';

import '../theme.dart';

class RoomItem extends ConsumerWidget {
  final String name;
  final bool isActive;
  final int index;
  const RoomItem({
    super.key,
    required this.name,
    required this.isActive,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(selectedRoomProvider.notifier).update((state) => index);
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8,),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Pallete.cardColor,
          border: isActive
              ? Border.all(
                  color: Pallete.primaryColor,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
