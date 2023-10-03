import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sdl_v2/Models/user.dart';
import 'package:sdl_v2/features/doorLock/door_lock_controller.dart';
import 'package:sdl_v2/features/doorLock/pages/add_user_page..dart';

import '../../../core/constants.dart';
import '../../../core/theme.dart';

class UserItem extends ConsumerWidget {
  final User user;
  const UserItem({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ExpansionTile(
      leading: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Pallete.primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: shadow),
        child: SvgPicture.asset(
          AssetConst.userIcon,
          height: 40,
          width: 40,
          color: Pallete.cardColor,
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        user.getTypes(),
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: 90,
      ),
      children: [
        if (user.fingerPrint)
          KeyType(
            text: "Fingerprint",
            user: user,
            onTap: () {
              ref.read(doorLockNotifierProvider.notifier).updateUser(
                    user.copyWith(
                      fingerPrint: false,
                    ),
                    context,
                    noPop: true,
                  );
            },
          ),
        if (user.rfid)
          KeyType(
            text: "RFId",
            user: user,
            onTap: () {
              ref.read(doorLockNotifierProvider.notifier).updateUser(
                    user.copyWith(
                      rfid: false,
                    ),
                    context,
                    noPop: true,
                  );
            },
          ),
        if (user.code.isNotEmpty)
          KeyType(
            user: user,
            text: "Code",
            onTap: () {
              ref.read(doorLockNotifierProvider.notifier).updateUser(
                  user.copyWith(
                    code: "",
                  ),
                  context,
                  noPop: true);
            },
          ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUserPage(
                  user: user,
                ),
              ),
            );
          },
          child: Ink(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 17,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Add"),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class KeyType extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final User user;

  const KeyType({
    super.key,
    required this.user,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(text),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUserPage(
                    user: user,
                  ),
                ),
              );
            },
            child: Ink(
              child: SvgPicture.asset(
                AssetConst.editIcon,
                color: Colors.green,
                height: 13,
                width: 13,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: onTap,
            child: Ink(
              child: SvgPicture.asset(
                AssetConst.deleteIcon,
                color: Colors.red,
                height: 13,
                width: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
