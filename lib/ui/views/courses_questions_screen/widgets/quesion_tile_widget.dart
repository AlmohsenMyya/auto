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
  const QuestionTileWidget({super.key});

  @override
  State<QuestionTileWidget> createState() => _QuestionTileWidgetState();
}

class _QuestionTileWidgetState extends State<QuestionTileWidget> {
  TextEditingController questionExplain =
      TextEditingController(text: 'شرح السؤال');
  var fo = FocusNode();
  late CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursesQuestionsController>(builder: (controller) {
      return Obx(() => ExpansionPanelList(
            dividerColor: Colors.black,
            expansionCallback: (panelIndex, isExpanded) {},
            animationDuration: Duration(milliseconds: 500),
            children: [
              controller.openExpand.value
                  ? ExpansionPanel(
                      backgroundColor: context.exOnPrimaryContainer,
                      canTapOnHeader: true,
                      isExpanded: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return TitleOfQuestions() ;

                      },
                      body: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    AnswerLine(),
                            10.h.verticalSpace,
                            AnswerLine(),
                            10.h.verticalSpace,
                            AnswerLine(),
                            10.h.verticalSpace,
                            AnswerLine(),
                          ],
                        ),
                      ))
                  : ExpansionPanel(
                      backgroundColor: context.exOnPrimaryContainer,
                      canTapOnHeader: true,
                      isExpanded: false,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return TitleOfQuestions ();
                      },
                      body: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnswerLine(),
                                  10.h.verticalSpace,
                                  AnswerLine(),
                                  10.h.verticalSpace,
                                  AnswerLine(),
                                  10.h.verticalSpace,
                                  AnswerLine(),
                                ],
                              ),
                            )
                          )
            ],
          ));
    });
  }
}
