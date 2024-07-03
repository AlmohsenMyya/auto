import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/data/models/local_json/all_models.dart';
import '../courses_questions_controller.dart';

class AnswerLine extends StatelessWidget {
  final int questionId;
  final Answer answer;
  final bool showResults;

  AnswerLine({
    Key? key,
    required this.questionId,
    required this.answer,
    required this.showResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CoursesQuestionsController>();

    return GestureDetector(
      onTap: showResults
          ? null
          : () {
        controller.selectAnswer(questionId, answer.id);
      },
      child: GetBuilder<CoursesQuestionsController>(
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
                Radio<int>(
                  value: answer.id,
                  groupValue: controller.getSelectedAnswer(questionId),
                  onChanged: showResults
                      ? null
                      : (value) {
                    controller.selectAnswer(questionId, value!);
                  },
                  activeColor: Colors.blue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(CoursesQuestionsController controller) {
    if (showResults) {
      if (answer.isCorrect == 1) {
        return Colors.green.withOpacity(0.5); // لون الإجابة الصحيحة
      } else if (controller.getSelectedAnswer(questionId) == answer.id) {
        return Colors.blue.withOpacity(0.5); // لون الإجابة المختارة عند عرض النتائج
      } else {
        return Colors.grey.shade100.withOpacity(0.8); // اللون الافتراضي للخلفية
      }
    } else {
      if (controller.getSelectedAnswer(questionId) == answer.id) {
        return Colors.blue.withOpacity(0.5); // لون الإجابة المختارة قبل التقديم
      } else {
        return Colors.grey.shade100.withOpacity(0.8); // اللون الافتراضي للخلفية
      }
    }
  }
}
