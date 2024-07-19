import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/data/models/local_json/all_models.dart';
import '../courses_questions_controller.dart';

class AnswerLine extends StatefulWidget {
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
  State<AnswerLine> createState() => _AnswerLineState();
}

class _AnswerLineState extends State<AnswerLine> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final answerPreview = widget.answer.text.length > 200
        ? widget.answer.text.substring(0, 200) + '...'
        : widget.answer.text;

    final controller = Get.find<CoursesQuestionsController>();

    return GestureDetector(
      onTap:() {
        controller.selectAnswer(widget.questionIndex, widget.answerIndex);
      },
      child: GetBuilder<CoursesQuestionsController>(
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: controller.answers_color[widget.questionIndex]?[widget.answerIndex],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Column(
                      children: [
                        Text(
                          isExpanded ? widget.answer.text : answerPreview,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        if (widget.answer.text.length > 200)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(isExpanded ? 'عرض أقل' : 'عرض المزيد',style: TextStyle(fontSize: 15,color: Colors.black,),),
                              ),
                            ],
                          ),
                      ],
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
