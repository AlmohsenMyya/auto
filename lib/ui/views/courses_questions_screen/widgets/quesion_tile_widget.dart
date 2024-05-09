import 'package:auto/core/ui/main_button.dart';
import 'package:auto/core/ui/responsive_padding.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extension.dart';
import 'package:auto/ui/shared/custom_widgets/media_view/media_widget/cache_network_image.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/answer_line_widget.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/title_of_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../courses_questions_controller.dart';

class QuestionTileWidget extends StatefulWidget {
  final int question_index;

  QuestionTileWidget({Key? key, required this.question_index})
      : super(key: key);

  @override
  State<QuestionTileWidget> createState() => _QuestionTileWidgetState();
}

class _QuestionTileWidgetState extends State<QuestionTileWidget> {
  late CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpansionPanelList(
        dividerColor: Colors.black,
        expansionCallback: (panelIndex, isExpanded) {
          controller.toggleExpand(widget.question_index);
        },
        animationDuration: Duration(milliseconds: 500),
        children: [
          ExpansionPanel(
            backgroundColor: context.exOnPrimaryContainer,
            canTapOnHeader: true,
            isExpanded: controller.isExpanded(widget.question_index),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return TitleOfQuestions(
                question_index: widget.question_index,
              );
            },
            body: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  controller.questions[widget.question_index].answers!.length,
              itemBuilder: (context, index) {
                final answer = controller
                    .questions[widget.question_index].answers![index]!;
                return AnswerLine(
                  questionId: widget.question_index,
                  answer: answer,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
