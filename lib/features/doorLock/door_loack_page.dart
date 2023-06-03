import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoorLockPage extends ConsumerStatefulWidget {
  const DoorLockPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoorLockPageState();
}

class _DoorLockPageState extends ConsumerState<DoorLockPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Door Loack"),
        ],
      ),
    );
  }
}
