import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../shared/flutter_switch.dart';
import '../courses_questions_controller.dart';

class TimerListener extends StatefulWidget {
  const TimerListener({Key? key}) : super(key: key);

  @override
  State<TimerListener> createState() => _TimerListenerState();
}

class _TimerListenerState extends State<TimerListener> {
  late CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        controller.isTimerActive.value = !controller.isTimerActive.value;

        if (controller.isTimerActive.value) {
          // Start the countdown
          controller.startTimer();
        } else {
          // Stop the countdown if it's active
          controller.mohsen_timer?.cancel();

          controller.countdown = 3.obs;
        }
      },
      child: Row(
        children: [
       Obx(() =>    Icon(
         Icons.timer,
         size: 30,
         color:
         controller.isTimerActive.value ? Colors.red : Colors.black,
       ),),
          // Square for minutes
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Obx(
                    () => Text(
                  '${controller.countdown ~/ 60}'.padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w), // Spacer
          // Square for seconds
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Obx(
                    () => Text(
                  '${controller.countdown % 60}'.padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
