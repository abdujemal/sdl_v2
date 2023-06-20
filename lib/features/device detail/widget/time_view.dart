import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/device%20detail/widget/edit_schedule.dart';

class TimeView extends StatefulWidget {
  final DateTime? time;
  final bool isAvailable;
  final bool isStart;
  final String id;
  const TimeView({
    super.key,
    required this.id,
    required this.time,
    required this.isAvailable,
    required this.isStart,
  });

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  String time = '00:00';
  String amPm = '--';

  
  void init() {
    

    if (widget.time != null) {
      final timeAm = DateFormat("h:mm a").format(widget.time!).split(" ");
      time = timeAm[0];
      amPm = timeAm[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return InkWell(
      onTap: () {
        if (!widget.isAvailable) {
          return;
        }
        showDialog(
          context: context,
          builder: (context) => EditSchedule(
            id: widget.id,
            isStart: widget.isStart,
            time: widget.time,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 5, 5, 10),
        decoration: BoxDecoration(
            color: Pallete.inputBg, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.isAvailable ? time : "00:00",
                style: GoogleFonts.antonio(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  color: widget.isAvailable ? Colors.black : Colors.grey,
                ),
              ),
            ),
            Text(
              widget.isAvailable ? amPm : "--",
              style: const TextStyle(
                color: Colors.black,              
              ),
            ),
          ],
        ),
      ),
    );
  }
}
