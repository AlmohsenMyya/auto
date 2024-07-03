import 'dart:async';
import 'dart:math' as math;

import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../courses_questions_controller.dart';

class TimerListener extends StatefulWidget {
  const TimerListener({Key? key, required void Function() onTimeEnd})
      : super(key: key);

  @override
  _TimerListenerState createState() => _TimerListenerState();
}

class _TimerListenerState extends State<TimerListener> {
  late CoursesQuestionsController controller;
  late Timer _timer;
  double _elapsedSeconds = 0.0;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CoursesQuestionsController>();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (controller.isTimerActive.value) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!controller.isTimerActive.value) {
          controller.isTimerActive.value = true;
          controller.startTimer();
        } else {
          controller.timer?.cancel();
          controller.isTimerActive.value = false;
        }
      },
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: TimerPainter(
                  elapsedSeconds: _elapsedSeconds,
                  totalTime: 600, // 10 minutes
                ),
              ),
              Center(
                child: Obx(
                      () => Text(
                    '${controller.countdown.value ~/ 60}:${(controller.countdown.value % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.exOnBackground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double elapsedSeconds;
  final double totalTime;

  TimerPainter({
    required this.elapsedSeconds,
    required this.totalTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = 6.0;

    final remainingTime = totalTime - elapsedSeconds;
    final sweepAngle = 2 * math.pi * (remainingTime / totalTime);

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      -sweepAngle,
      false,
      progressPaint,
    );

    // Progress line
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;
    final lineLength = radius - strokeWidth / 2;
    final lineEndX =
        center.dx + lineLength * math.cos(-sweepAngle - math.pi / 2);
    final lineEndY =
        center.dy + lineLength * math.sin(-sweepAngle - math.pi / 2);
    canvas.drawLine(center, Offset(lineEndX, lineEndY), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
