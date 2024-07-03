import 'package:auto/core/data/models/local_json/all_models.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../shared/flutter_switch.dart';
import '../lesson_questions_controller.dart';

class TimerListenerLesson extends StatefulWidget {
  const TimerListenerLesson({Key? key, required void Function() onTimeEnd,}) : super(key: key);

  @override
  State<TimerListenerLesson> createState() => _TimerListenerLessonState();
}

class _TimerListenerLessonState extends State<TimerListenerLesson> {
  late LessonsQuestionsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<LessonsQuestionsController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.isTimerActive.value = !controller.isTimerActive.value;

        if (controller.isTimerActive.value) {
          controller.startTimer();
        } else {
          controller.timer?.cancel();
        }
      },
      child: Row(
        children: [
          Obx(() => Icon(
            Icons.timer,
            size: 30,
            color: controller.isTimerActive.value ? Colors.red : Colors.black,
          )),
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
                  '${controller.countdown.value % 60}'.padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: context.exOnBackground,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w), // Spacer
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
                  '${controller.countdown.value ~/ 60}'.padLeft(2, '0'),
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
