import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text("Camera ")
      ]),
    );
  }
}