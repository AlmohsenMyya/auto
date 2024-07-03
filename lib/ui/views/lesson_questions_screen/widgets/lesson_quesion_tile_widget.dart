
//////
import 'package:auto/ui/views/lesson_questions_screen/widgets/lesson_answer_line_widget.dart';
import 'package:auto/ui/views/lesson_questions_screen/widgets/title_of_questionslesson.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showcaseview/showcaseview.dart';

import '../lesson_questions_controller.dart';


class QuestionTileLessonWidget extends StatefulWidget {
  final int questionIndex;
  final bool showResults;

  const QuestionTileLessonWidget({
    Key? key,
    required this.questionIndex,
    required this.showResults,
  }) : super(key: key);

  @override
  State<QuestionTileLessonWidget> createState() => _QuestionTileLessonWidgetState();
}

class _QuestionTileLessonWidgetState extends State<QuestionTileLessonWidget> {
  late LessonsQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(LessonsQuestionsController());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LessonsQuestionsController>(
      builder: (controller) {
        if (controller.questions.isEmpty) {
          return Container(); // Handle case where questions list is null or empty
        }

        // Ensure questionIndex is within valid range
        if (widget.questionIndex < 0 ||
            widget.questionIndex >= controller.questions.length) {
          return Container(); // Return an empty container if index is invalid
        }

        final question = controller.questions[widget.questionIndex];
        final questionId = question.id;

        if (question.answers == null || question.answers!.isEmpty) {
          return Container(); // Handle case where answers list is null or empty
        }
        return ShowCaseWidget(
            builder: (context) => Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TitleOfLessonQuestions(
                              question_index: widget.questionIndex),
                        ), IconButton(
                          icon: Icon(
                            Icons.star,
                            color: controller.isFavorite(questionId)
                                ? Colors.yellow
                                : Colors.grey,
                          ),
                          onPressed: () {
                            controller.toggleFavorite(questionId);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.share, color: Colors.blue),
                          onPressed: () {
                            final questionTextWithAnswers =
                            controller.getQuestionTextWithAnswersById(
                                questionId);
                            if (questionTextWithAnswers != null) {
                              Share.share(
                                  'Check out this question: \n$questionTextWithAnswers');
                            } else {
                              // Handle case where questionTextWithAnswers is null
                              // Maybe show a snackbar or handle it in another way
                            }
                          },
                        ),
                      ],
                    ),
                    // Map answers with null check on each answer
                    ...(question.answers!.map((answer) {
                      if (answer == null)
                        return Container(); // Handle null answers if any
                      return AnswerLessonLine(
                        key: Key(answer.id.toString()),
                        // Ensure each AnswerLine has a unique key
                        questionId: questionId,
                        answer: answer,
                        showResults: widget.showResults,
                      ); }).toList()),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        IconButton(
        icon: Icon(Icons.camera_alt, color: Colors.grey),
        onPressed: () {

        },
        ),
        IconButton(
        icon: Icon(Icons.star, color: Colors.grey),
        onPressed: () {

        },
        ),
        IconButton(
        icon: Icon(Icons.help, color: Colors.grey),
        onPressed: () {

        },
        ),
        IconButton(
        icon: Icon(Icons.folder, color: Colors.grey),
        onPressed: () {

        },
        ),
        ],
        ),

                  ],
                ),
              ),
            ));
      },
    );
  }
}
