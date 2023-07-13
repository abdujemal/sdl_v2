import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sdl_v2/Models/activity.dart';

import '../../../core/constants.dart';
import '../../../core/theme.dart';

class ActivityItem extends ConsumerWidget {
  final Activity activity;
  const ActivityItem({super.key, required this.activity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
              color: Pallete.primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: shadow),
          child: SvgPicture.asset(
            AssetConst.userIcon,
            height: 40,
            width: 40,
            color: Pallete.cardColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (activity.type == 1) Text("User Name"),
            Text("Unlocked using ${activity.getType()}"),
            if (activity.type == 2) Text("code: ${activity.id}"),
            Text(DateFormat("H:mm a").format(DateTime.parse(activity.time)))
          ],
        )
      ],
    );
  }
}
