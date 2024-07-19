import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:auto/ui/views/login_screen/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lesson_screen_controller.dart';

class LessonScreenCardWidget extends StatefulWidget {
  final int index;
  final String subjectName;
  final String type_isCourse;

  LessonScreenCardWidget(
      {super.key,
      required this.index,
      required this.subjectName,
      required this.type_isCourse});

  @override
  State<LessonScreenCardWidget> createState() => _LessonScreenCardWidgetState();
}

class _LessonScreenCardWidgetState extends State<LessonScreenCardWidget> {
  late LessonScreenController controller;

  @override
  void initState() {
    controller = Get.put(LessonScreenController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.lessons.isEmpty) {
        return Center(child: Text("No lessons available."));
      } else {
        return Padding(
          padding: const EdgeInsets.all(10.0),
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
                        Text(
                          controller.lessons[widget.index].name,
                          textDirection: TextDirection.ltr,
                          style: context.exTextTheme.titleMedium!
                              .copyWith(color: context.exInversePrimaryColor),
                        ),
                        15.h.verticalSpace,
                      ],
                    ),
                    Center(
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ).exBox(height: 40, width: 20),
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
            if (controller.lessons[widget.index].isPublic == 0 &&
                token == null) {
              // عرض رسالة بسيطة وزر الاشتراك
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'لا يمكن الدخول',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold , color: context.exPrimaryContainer),
                    ),
                    content: Text('يتطلب الدخول الاشتراك. يرجى الاشتراك للاستمرار.' , style: TextStyle(color: context.exPrimaryContainer),),
                    actions: <Widget>[
                      TextButton(
                        child: Text('اشتراك' , style: TextStyle(color: context.exPrimaryContainer),),
                        onPressed: () {
                          // توجيه المستخدم لصفحة تسجيل الدخول
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginView()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              // السماح بالدخول مباشرةً إذا كان is_public ليس 0
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CoursesQuestionsView(
                    type: widget.type_isCourse,
                    isLesson: true,
                    idLESSON: controller.lessons[widget.index].id,
                    coursName: controller.lessons[widget.index].name,
                    id_course_bank_lesson_unite: -1,
                    subjectName: widget.subjectName,
                  );
                },
              ));
            }
          }),
        );
      }
    });
  }
}