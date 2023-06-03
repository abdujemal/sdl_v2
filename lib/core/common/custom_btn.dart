import 'package:flutter/material.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double margin;
  final double width;
  const CustomBtn({
    super.key,
    required this.text,
    required this.onTap,
    this.margin = 0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: width,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: margin),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Pallete.primaryColor,
              borderRadius: BorderRadius.circular(13),
              boxShadow: shadow),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }
}
