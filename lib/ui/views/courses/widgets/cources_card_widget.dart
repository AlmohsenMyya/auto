import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
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

  CoursesCardWidget({Key? key, required this.index}) : super(key: key);

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
    jsonfile = await JsonReader.loadJsonFromAssets('assets/data.json');
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
                                .copyWith(color:  context.exInversePrimaryColor),
                          ),
                          SizedBox(height: 10.w,),
                          Text(
                            "عدد الاسئلة : $numberQuestions",
                            textDirection: TextDirection.ltr,
                            style: context.exTextTheme.titleMedium!
                                .copyWith(color:  context.exInversePrimaryColor),
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
      ).onTap(() async{

        SharedPreferences prefs = await SharedPreferences.getInstance();
       final token = await prefs.getString('access_token');
        // تحقق من is_public قبل السماح بالدخول
        if (controller.courses[widget.index].is_public == 0 && token == null) {
          // عرض مربع الحوار
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController codeController = TextEditingController();
              return AlertDialog(
                title: Text('ادخل الكود : ',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),

                content: TextField(
                  controller: codeController,
                  decoration: InputDecoration(label: Text(" عذراً لايمكنك فتح هذا المحتوى حتى إدخال الكود"),
                      hintText: "أدخل الكود هنا"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('إرسال'),
                    onPressed: () {
                      // التحقق من الكود المدخل
                      if (codeController.text == "your_code") {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CoursesQuestionsView(
                            id_course_bank_lesson_unite: controller.courses[widget.index].id,
                            type: "دورة",
                          ),
                        ));
                      } else {
                        // عرض رسالة خطأ إذا كان الكود غير صحيح
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('الكود غير صحيح.')),
                        );
                      }
                    },
                  ),
                  TextButton(
                    child: Text('إغلاق'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // السماح بالدخول مباشرةً إذا كان is_public ليس 0
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoursesQuestionsView(
              id_course_bank_lesson_unite: controller.courses[widget.index].id,
              type: "دورة",
            ),
          ));
        }
      }),
    );
  }
}
//




