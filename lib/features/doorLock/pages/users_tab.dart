import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/doorLock/pages/add_user_page..dart';
import 'package:sdl_v2/features/doorLock/pages/door_lock_page.dart';
import 'package:sdl_v2/features/doorLock/widgets/user_item.dart';

import '../../../Models/door_lock.dart';
import '../../../Models/user.dart';

class UsersTab extends ConsumerStatefulWidget {
  const UsersTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsersTabState();
}

class _UsersTabState extends ConsumerState<UsersTab> {
  @override
  Widget build(BuildContext context) {
    List<User> users = ref.watch(usersPrivider);
    DoorLock? doorLock = ref.read(doorLockProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Users"),
      ),
      body: doorLock != null
          ? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserItem(user: users[index]);
              },
            )
          : const Center(
              child: Text("Loading"),
            ),
      floatingActionButton: doorLock != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddUserPage(),
                  ),
                );
              },
              backgroundColor: Pallete.primaryColor,
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
    );
  }
}
