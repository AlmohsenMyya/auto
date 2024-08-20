import 'package:auto/core/resource/consts/image_const.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:auto/ui/views/subject_deails_screen/subject_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/data/models/local_json/all_models.dart';

class SubjectTile extends StatelessWidget {
  Subject subject;
  Branch branch;
  SubjectTile({super.key,required this.branch, required this.subject});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(SubjectDetailsScreen(
        branch: branch,
        subject: subject,
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 80.h,
          width: 100.w,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: context.exOnPrimaryContainer,
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2.w)),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CustomNetworkImage(ImageConst.subjectImageConst,
                boxFit: BoxFit.cover, width: 69.w),
            SizedBox(
              width: 10.w,
            ),
            RichText(
                text: TextSpan(
                    text: 'اسم المادة :  ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        //  fontFamily: 'Alexandria',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: subject.name,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20,
                          // fontFamily: 'Alexandria',
                          fontWeight: FontWeight.w500))
                ])),
            Spacer(),  IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'عرض الأسئلة المفضلة لمادة "${subject.name}"',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(CoursesQuestionsView(
                                      id_course_bank_lesson_unite: -1,
                                      subjectName: "الأسئلة المفضلة :",
                                      coursName: subject.name,
                                      favoriteSubject: subject.subject_id,
                                      type: "",
                                    ));
                                  },
                                  child: Text('انتقال'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('إغلاق'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ),
            SizedBox(
              width: 1,
            ),
            IconButton(
                onPressed: () {
                  Get.to(SubjectDetailsScreen(
                    subject: subject,
                    branch: branch,
                  ));
                },
                icon: const Icon(Icons.arrow_forward))
          ]),
        ),
      ),
    );
  }
}
