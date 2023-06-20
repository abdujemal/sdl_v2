import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import 'package:sdl_v2/core/theme.dart';
import 'package:sdl_v2/features/add%20device/add_device_controller.dart';

class EditSchedule extends StatefulWidget {
  final String id;
  final bool isStart;
  final DateTime? time;
  const EditSchedule({
    super.key,
    required this.id,
    required this.isStart,
    required this.time,
  });

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  DateTime _dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    _dateTime = widget.time ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.isStart ? "Start Schedule" : "End Schedule",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TimePickerSpinner(
              is24HourMode: false,
              time: _dateTime,
              normalTextStyle:
                  const TextStyle(fontSize: 24, color: Colors.grey),
              highlightedTextStyle:
                  const TextStyle(fontSize: 24, color: Colors.black),
              spacing: 50,
              itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                _dateTime = time;
              },
            ),
            Consumer(builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  if (widget.isStart) {
                    ref.read(addDeviceNotifierProvider.notifier).editSchedule(
                          widget.id,
                          "scheduleStartTime",
                          "${_dateTime.hour}:${_dateTime.minute}:00",
                          context,
                        );
                  } else {
                    ref.read(addDeviceNotifierProvider.notifier).editSchedule(
                          widget.id,
                          "scheduleEndTime",
                          "${_dateTime.hour}:${_dateTime.minute}:00",
                          context,
                        );
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Pallete.primaryColor,
                    fontSize: 20,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
