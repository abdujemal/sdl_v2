import 'package:flutter/material.dart';

import '../theme.dart';

class CustomInput extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const CustomInput({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Pallete.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 14,
              right: 14,
            ),
            child: TextFormField(
              validator: (v) {
                if (v!.isEmpty) {
                  return "This field is required.";
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 120, 120, 120),
                ),
                contentPadding: const EdgeInsets.only(left: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
