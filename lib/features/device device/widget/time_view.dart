import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdl_v2/core/theme.dart';

class TimeView extends StatelessWidget {
  final String time;
  final String amPm;
  final VoidCallback onTap;
  TimeView(
      {super.key, required this.time, required this.amPm, required this.onTap});

  final GlobalKey _timePicker = GlobalKey(debugLabel: "golang");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            FormFieldState state = _timePicker.currentState as FormFieldState;
            state.
            print("tap");
          },
          icon: Icon(Icons.date_range),
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: Visibility(
            visible: true,
            child: DateTimePicker(
              key: _timePicker,
              decoration: const InputDecoration.collapsed(
                hintText: "",
                fillColor: Pallete.inputBg,
              ),
              initialValue: '',
              use24HourFormat: false,
              inputFormatters: [],
              type: DateTimePickerType.time,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              locale: const Locale('en', 'US'),
              dateLabelText: 'Time',
              onSaved: (val) => print(val),
            ),
          ),
        ),
      ],
    );
    //  InkWell(
    //   onTap: onTap,
    //   child: Ink(
    //     padding: const EdgeInsets.only(
    //       bottom: 10,
    //       left: 20,
    //       right: 5,
    //       top: 5,
    //     ),
    //     decoration: BoxDecoration(
    //         color: Pallete.inputBg, borderRadius: BorderRadius.circular(10)),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 8.0),
    //           child: Text('${time}',
    //               style: GoogleFonts.barlow(
    //                 textStyle: TextStyle(
    //                   fontSize: 25,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               )),
    //         ),
    //         Align(alignment: Alignment.topRight, child: Text('${amPm}'))
    //       ],
    //     ),
    //   ),
    // );
  }
}
