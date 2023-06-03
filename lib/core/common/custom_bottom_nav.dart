import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';

final currentTabProvider = StateProvider<int>((ref) {
  return 0;
});

class CustomBottomNav extends ConsumerStatefulWidget {
  const CustomBottomNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomBottomNavState();
}

class _CustomBottomNavState extends ConsumerState<CustomBottomNav> {
  final double iconSize = 28;
  final double padding = 25;

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentTabProvider);
    final currentIndexNotifier = ref.read(currentTabProvider.notifier);

    return Container(
      color: Colors.white,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              currentIndexNotifier.update((state) => 0);
            },
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: SvgPicture.asset(
                AssetConst.homeIcon,
                height: iconSize,
                color:
                    currentIndex == 0 ? Pallete.primaryColor : Colors.black54,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              currentIndexNotifier.update((state) => 1);
            },
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: SvgPicture.asset(
                AssetConst.cameraIcon,
                height: iconSize - 1,
                color:
                    currentIndex == 1 ? Pallete.primaryColor : Colors.black54,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              currentIndexNotifier.update((state) => 2);
            },
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: SvgPicture.asset(
                AssetConst.doorLockIcon,
                height: iconSize + 2,
                color:
                    currentIndex == 2 ? Pallete.primaryColor : Colors.black54,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: SvgPicture.asset(
                AssetConst.lightIcon,
                height: iconSize + 2,
                color:
                    currentIndex == 3 ? Pallete.primaryColor : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
