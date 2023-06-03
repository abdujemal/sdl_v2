import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants.dart';
import '../../../core/theme.dart';

class Song extends StatelessWidget {
  const Song({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: shadow,
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            AssetConst.musicIcon,
            color: Colors.pink,
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "This is a song",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("by you"),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                AssetConst.prevIcon,
                height: 13,
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                AssetConst.pauseIcon,
                height: 13,
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                AssetConst.forwardIcon,
                height: 13,
              ),
            ],
          )
        ],
      ),
    );
  }
}
