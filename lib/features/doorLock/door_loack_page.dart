import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/features/doorLock/widgets/door_lock_bar.dart';

final doorLockIndexProvider = StateProvider<int?>((ref) {
  return null;
});

class DoorLockPage extends ConsumerStatefulWidget {
  const DoorLockPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoorLockPageState();
}

class _DoorLockPageState extends ConsumerState<DoorLockPage> {
  List<IconTab> items = [
    IconTab(assetPath: AssetConst.activityIcon, text: "Activity"),
    IconTab(assetPath: AssetConst.userIcon, text: "Users"),
    IconTab(assetPath: AssetConst.keyIcon, text: "Keys"),
  ];

  @override
  Widget build(BuildContext context) {
    int? selectedIndex = ref.watch(doorLockIndexProvider);
    return  WillPopScope(
      onWillPop: () async {
        if(selectedIndex != null){
          ref.read(doorLockIndexProvider.notifier).update((state) => null);
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Center(child: Text("Door Loack $selectedIndex")),
          ],
        ),
        bottomNavigationBar: DoorLockBar(items),
      ),
    );
  }
}
