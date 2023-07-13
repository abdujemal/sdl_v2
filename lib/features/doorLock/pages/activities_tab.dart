import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/features/doorLock/pages/door_lock_page.dart';
import 'package:sdl_v2/features/doorLock/widgets/activity_item.dart';

class ActivitiesTab extends ConsumerStatefulWidget {
  const ActivitiesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActivitiesTabState();
}

class _ActivitiesTabState extends ConsumerState<ActivitiesTab> {
  @override
  Widget build(BuildContext context) {
    final doorLock = ref.watch(doorLockProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Activities"),
      ),
      body: doorLock == null
          ? const Center(
              child: Text("Loading..."),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemCount: doorLock.activities.length,
              itemBuilder: (context, index) {
                return ActivityItem(
                  activity: doorLock.activities[index],
                );
              },
            ),
    );
  }
}
