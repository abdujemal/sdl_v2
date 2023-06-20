import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/core/common/custom_btn.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/home/home_controller.dart';

class AddRoomSheet extends ConsumerStatefulWidget {
  const AddRoomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddRoomSheetState();
}

class _AddRoomSheetState extends ConsumerState<AddRoomSheet> {
  final GlobalKey<FormState> _addRoomKey = GlobalKey<FormState>();

  TextEditingController roomNameTc = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    roomNameTc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = ref.watch(homeLoadingProvider);
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: 200,
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Pallete.cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Form(
          key: _addRoomKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Room",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: roomNameTc,
                decoration: const InputDecoration(hintText: "Room Name"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Pallete.primaryColor,
                      ),
                    )
                  : CustomBtn(
                      text: "Add",
                      onTap: () {
                        if (_addRoomKey.currentState!.validate()) {
                          ref
                              .read(homeNotifierProvider.notifier)
                              .addRoom(roomNameTc.text, context);
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
