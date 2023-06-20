import 'package:flutter/material.dart';
import 'package:sdl_v2/core/constants.dart';

import '../../../core/theme.dart';

class CustomProgress extends StatelessWidget {
  final double value;
  const CustomProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: 50,
          decoration: BoxDecoration(
            boxShadow: shadow,
            color: Pallete.cardColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: (value / 50) * constraint.maxWidth,
                decoration: BoxDecoration(
                    color: Pallete.primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: Text(
                  '${value.toString()}\u2103',
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            ],
          ),
        );
      },
    );
  }
}
