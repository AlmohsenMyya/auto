import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../courses_questions_controller.dart';

class TimerWidget extends StatefulWidget {
  TimerWidget({Key? key}) : super(key: key);

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late CoursesQuestionsController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursesQuestionsController>(
        init: controller,
        builder: (controller) {
          return
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: controller.handleTap,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: controller.isRunning
                          ? Colors.greenAccent.withOpacity(0.5)
                          : Colors.blueAccent.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    controller.myformatTime.value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );});
  }

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.timer?.cancel();
    super.dispose();
  }
}
