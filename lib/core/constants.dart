import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AssetConst {
  static const String path = 'assets';
  static const String activityIcon = '$path/activity icon.svg';
  static const String brightnessIcon = '$path/brightness icon.svg';
  static const String cameraIcon = '$path/camera icon.svg';
  static const String codeIcon = '$path/code icon.svg';
  static const String deleteIcon = '$path/delete icon.svg';
  static const String doorLockIcon = '$path/door lock icon.svg';
  static const String editIcon = '$path/edit icon.svg';
  static const String fingerIcon = '$path/finger icon.svg';
  static const String forwardIcon = '$path/forward icon.svg';
  static const String homeIcon = '$path/home icon.svg';
  static const String keyIcon = '$path/key icon.svg';
  static const String lightBulbImg = '$path/light bulb png.png';
  static const String lightIcon = '$path/light icon.svg';
  static const String menuIcon = '$path/menu icon.svg';
  static const String musicIcon = '$path/music icon.svg';
  static const String pauseIcon = '$path/pause icon.svg';
  static const String prevIcon = '$path/prev icon.svg';
  static const String rfid = '$path/rfid icon.svg';
  static const String userIcon = '$path/user icon.svg';
}

final List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(.25),
    offset: const Offset(5, 0),
    spreadRadius: 5,
    blurRadius: 5,
  ),
];

toast(String text, Color color) {
  Fluttertoast.showToast(msg: text, backgroundColor: color);
}
