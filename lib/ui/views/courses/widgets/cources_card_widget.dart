import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:auto/ui/views/login_screen/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/data/models/local_json/all_models.dart';
import '../../../../core/data/repositories/read_all_models.dart';
import '../../courses_questions_screen/courses_questions_controller.dart';
import '../courses_controller.dart';

class CoursesCardWidget extends StatefulWidget {
  final int index;
  final String subjectName;

  CoursesCardWidget({
    Key? key,
    required this.index,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<CoursesCardWidget> createState() => _CoursesCardWidgetState();
}

class _CoursesCardWidgetState extends State<CoursesCardWidget> {
  late CoursesController controller;
  String numberQuestions = "...";
  late Map<String, dynamic> jsonfile;

  late List<Question> questions;

  void getQuestionsNumber() async {
    int id = controller.courses[widget.index].id;
    jsonfile = await JsonReader.loadJsonData();
    questions = JsonReader.extractQuestionsByCourseId(jsonfile, id);
    setState(() {
      numberQuestions = questions.length.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(CoursesController());
    getQuestionsNumber();
  }

  @override
  @override
  Widget build(BuildContext context) {
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
                            controller.courses[widget.index].name,
                            textDirection: TextDirection.ltr,
                            style: context.exTextTheme.titleLarge!
                                .copyWith(color: context.exInversePrimaryColor),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Text(
                            "عدد الاسئلة : $numberQuestions",
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
        if (controller.courses[widget.index].is_public == 0 && token == null) {
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
            builder: (context) =>
                CoursesQuestionsView(
                  id_course_bank_lesson_unite: controller.courses[widget.index]
                      .id,
                  subjectName: widget.subjectName,
                  coursName: controller.courses[widget.index].name,
                  type: "دورة",
                ),
          ));
        }
      }),
    );
  }
}
//
