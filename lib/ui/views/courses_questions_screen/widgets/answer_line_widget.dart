import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/data/models/local_json/all_models.dart';
import '../courses_questions_controller.dart';

class AnswerLine extends StatelessWidget {
  final int questionIndex;
  final int answerIndex;
  final Answer answer;

  AnswerLine({
    Key? key,
    required this.questionIndex,
    required this.answerIndex,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CoursesQuestionsController>();

    return GestureDetector(
      onTap:() {
        controller.selectAnswer(questionIndex, answerIndex);
      },
      child: GetBuilder<CoursesQuestionsController>(
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: controller.answers_color[questionIndex]?[answerIndex],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      answer.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
