import 'package:auto/ui/views/parts_questions_screen/parts_questions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/data/models/local_json/all_models.dart';


class PartsAnswerLine extends StatelessWidget {
  final int questionId;
  final Answer answer;
  final bool showResults;

  PartsAnswerLine({
    Key? key,
    required this.questionId,
    required this.answer,
    required this.showResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UnitsQuestionsController>();

    return GestureDetector(
      onTap: showResults
          ? null
          : () {
        controller.selectAnswer(questionId, answer.id);
      },
      child: GetBuilder<UnitsQuestionsController>(
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: _getBackgroundColor(controller),
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
                Radio(
                  value: answer.id,
                  groupValue: controller.getSelectedAnswer(questionId),
                  onChanged: showResults
                      ? null
                      : (value) {
                    controller.selectAnswer(questionId, value as int);
                  },
                  activeColor: Colors.blue, // Set active color to blue
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(UnitsQuestionsController controller) {
    if (showResults) {
      if (answer.isCorrect == 1) {
        return Colors.green.withOpacity(0.5); // Correct answer color
      } else if (controller.getSelectedAnswer(questionId) == answer.id) {
        return Colors.blue.withOpacity(0.5); // Selected answer color during results
      } else {
        return Colors.grey.shade100.withOpacity(0.8); // Default background color
      }
    } else {
      if (controller.getSelectedAnswer(questionId) == answer.id) {
        return Colors.blue.withOpacity(0.5); // Selected answer color before submission
      } else {
        return Colors.grey.shade100.withOpacity(0.8); // Default background color
      }
    }
  }
}
