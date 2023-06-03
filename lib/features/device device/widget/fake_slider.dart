import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/core/theme.dart';

class FakeSlider extends ConsumerWidget {
  const FakeSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      decoration: BoxDecoration(
          color: Pallete.inputBg, borderRadius: BorderRadius.circular(60)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            height: 70,
            decoration: const BoxDecoration(
              color: Pallete.primaryColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(60),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
