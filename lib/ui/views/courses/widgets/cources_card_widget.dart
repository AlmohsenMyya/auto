import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:auto2/core/utils/extension/widget_extensions.dart';
import 'package:auto2/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:auto2/ui/views/login_screen/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/data/models/local_json/all_models.dart';
import '../../../../core/data/repositories/read_all_models.dart';
import '../../../shared/please_subscrib_botton.dart';
import '../../courses_questions_screen/courses_questions_controller.dart';
import '../courses_controller.dart';

class CoursesCardWidget extends StatefulWidget {
  final int index;
  final String subjectName;
  Branch branch;
  CoursesCardWidget({
    Key? key,
    required this.index,
    required this.branch,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<CoursesCardWidget> createState() => _CoursesCardWidgetState();
}

class _CoursesCardWidgetState extends State<CoursesCardWidget> {
  late CoursesController controller;

  late Map<String, dynamic> jsonfile;

  late List<Question> questions;


  @override
  void initState() {
    super.initState();
    controller = Get.put(CoursesController());
  }

  @override
  @override
  Widget build(BuildContext context) {
    final numberQuestions = controller.getQuestionsCount(widget.index);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: context.exOnPrimaryContainer,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.h.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          Text(
                            controller.filteredcourses[widget.index].name,
                            textDirection: TextDirection.ltr,
                            style: context.exTextTheme.titleLarge!
                                .copyWith(color: context.exInversePrimaryColor),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Text(
                            "عدد الاسئلة : ${controller.courseQuestionsCount[controller.filteredcourses[widget.index].id]}",
                            textDirection: TextDirection.ltr,
                            style: context.exTextTheme.titleMedium!
                                .copyWith(color: context.exInversePrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    15.h.verticalSpace,
                  ],
                ),
                Center(
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ).exBox(height: 40, width: 20)
              ],
            ),
            Divider(
              height: 10.h,
              color: context.exBackground,
            )
          ],
        ),
      ).onTap(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = await prefs.getString('access_token');
        // تحقق من is_public قبل السماح بالدخول
          bool isInMyBranch = await SubscriptionDialog.isMyBranch(
              widget.branch.branchId.toString());
          // تحقق من is_public قبل السماح بالدخول
          if (controller.filteredcourses[widget.index].is_public == 0 && (token == null || !isInMyBranch)) {
            // عرض رسالة بسيطة وزر- الاشتراك
            SubscriptionDialog.showSubscriptionDialog(context);
          }  else {
          // السماح بالدخول مباشرةً إذا كان is_public ليس 0
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CoursesQuestionsView(
                  id_course_bank_lesson_unite: controller.filteredcourses[widget.index]
                      .id,
                  subjectName: widget.subjectName,
                  coursName: controller.filteredcourses[widget.index].name,
                  type: "دورة",
                ),
          ));
        }
      }),
    );
  }
}
//
