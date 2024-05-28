import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/data/models/local_json/all_models.dart';
import '../courses_questions_controller.dart';

class AnswerLine extends StatefulWidget {
  final int questionId;
  final Answer answer;

  AnswerLine({Key? key, required this.questionId, required this.answer})
      : super(key: key);

  @override
  _AnswerLineState createState() => _AnswerLineState();
}

class _AnswerLineState extends State<AnswerLine> {
  late final CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isChoosing.value
          ? SizedBox()
          : InkWell(
              onTap: () {
                controller.selectAnswer(widget.questionId, widget.answer.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  color: controller.getSelectedAnswer(widget.questionId) ==
                          widget.answer.id
                      ? widget.answer.isCorrect == 1
                          ? Colors.green.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5)
                      : Colors.grey.shade100.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '-1- ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: widget.answer.text,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio(
                      value: widget.answer.id,
                      groupValue:
                          controller.getSelectedAnswer(widget.questionId),
                      onChanged: (value) {
                        controller.selectAnswer(
                            widget.questionId, value as int);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
