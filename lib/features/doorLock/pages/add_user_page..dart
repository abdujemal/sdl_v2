import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sdl_v2/Models/door_lock.dart';
import 'package:sdl_v2/core/common/custom_btn.dart';
import 'package:sdl_v2/core/common/custom_input.dart';
import 'package:sdl_v2/core/constants.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/doorLock/door_lock_controller.dart';
import 'package:sdl_v2/features/doorLock/pages/door_lock_page.dart';
import 'package:sdl_v2/features/doorLock/widgets/door_lock_bar.dart';
import 'package:sdl_v2/features/doorLock/widgets/fp_validation_dailog.dart';

import '../../../Models/user.dart';

class AddUserPage extends ConsumerStatefulWidget {
  final User? user;
  const AddUserPage({this.user, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddUserPageState();
}

class _AddUserPageState extends ConsumerState<AddUserPage> {
  TextEditingController nameTc = TextEditingController();

  List<IconTab> keys = [
    IconTab(assetPath: AssetConst.finger, text: "Finger"),
    IconTab(assetPath: AssetConst.rfid, text: "RFID"),
    IconTab(assetPath: AssetConst.codeIcon, text: "Code"),
  ];

  int selectedKey = 0;

  TextEditingController codeTc = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameTc.text = widget.user!.name;
      codeTc.text = widget.user!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Smart Door"),
        leading: IconButton(
          icon: SvgPicture.asset(
            AssetConst.menuIcon,
            height: 15,
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                // height: 300,
                decoration: BoxDecoration(
                    color: Pallete.inputBg,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Pallete.inputBg.withAlpha(165),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AssetConst.userIcon,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInput(
                      title: "Name",
                      hint: "Ousman Habib",
                      controller: nameTc,
                    ),
                    if (selectedKey == 2)
                      CustomInput(
                        title: "Code",
                        hint: "122344",
                        controller: codeTc,
                        keyboardType: TextInputType.number,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Key type",
                  style: TextStyle(
                    color: Pallete.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  keys.length,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedKey = index;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          border: selectedKey == index
                              ? Border.all(color: Pallete.primaryColor)
                              : null,
                          color: Pallete.bgColor,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            keys[index].assetPath,
                            height: 43,
                            color: Pallete.primaryColor,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            keys[index].text,
                            style: const TextStyle(
                              color: Pallete.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Consumer(builder: (context, ref, child) {
                final bool isLoading = ref.watch(userLoadingProvider);
                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomBtn(
                        margin: 25,
                        text: "Next",
                        onTap: () {
                          int numOfUsers = ref.read(usersPrivider).length;
                          if (nameTc.text.isEmpty) {
                            toast("Name is Reequired.", Colors.red);
                            return;
                          }
                          if (codeTc.text.isEmpty && selectedKey == 2) {
                            toast("Code is Required.", Colors.red);
                            return;
                          }
                          if (selectedKey == 0) {
                            //if it is finger print
                            int userId = widget.user != null
                                ? widget.user!.id
                                : numOfUsers;
                            DoorLock? doorLock = ref.read(doorLockProvider);

                            ref
                                .read(doorLockNotifierProvider.notifier)
                                .updateDoorLock(doorLock!
                                    .copyWith(enroll: 1, enrollId: userId));

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => FPVaildationDialog(
                                widget.user != null
                                    ? widget.user!
                                    : User(
                                        name: nameTc.text,
                                        id: numOfUsers,
                                        code:
                                            selectedKey == 2 ? codeTc.text : "",
                                        rfid: selectedKey == 1 ? true : false,
                                        fingerPrint:
                                            selectedKey == 0 ? true : false,
                                      ),
                              ),
                            );
                          }
                          if (widget.user != null) {
                            ref
                                .read(doorLockNotifierProvider.notifier)
                                .updateUser(
                                    widget.user!.copyWith(
                                      name: nameTc.text,
                                      code: selectedKey == 2
                                          ? codeTc.text
                                          : widget.user!.code,
                                      rfid: selectedKey == 1
                                          ? true
                                          : widget.user!.rfid,
                                      fingerPrint: selectedKey == 0
                                          ? true
                                          : widget.user!.fingerPrint,
                                    ),
                                    context,
                                    noPop: selectedKey == 0);
                          } else {
                            ref
                                .read(doorLockNotifierProvider.notifier)
                                .updateUser(
                                    User(
                                      name: nameTc.text,
                                      id: numOfUsers,
                                      code: selectedKey == 2 ? codeTc.text : "",
                                      rfid: selectedKey == 1 ? true : false,
                                      fingerPrint:
                                          selectedKey == 0 ? true : false,
                                    ),
                                    context,
                                    noPop: selectedKey == 0);
                          }
                        },
                      );
              }),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
