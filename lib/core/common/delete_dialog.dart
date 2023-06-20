import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/home/home_controller.dart';

import 'custom_btn.dart';

class DeleteDialog extends ConsumerWidget {
  final VoidCallback action;
  final String title;
  const DeleteDialog(
    {
    required this.action,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading  = ref.watch(deleteLoadingProvider);
    return Dialog(
      child: Container(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Text(title, style: const TextStyle(fontSize: 20),),
          isLoading?
          const Center(child: CircularProgressIndicator(color: Pallete.primaryColor),):
          CustomBtn(
            margin: 20,
            onTap: action,
            text: "Delete",
          )
        ],),
      ),
    );
  }
}
