import 'package:auto/core/resource/consts/image_const.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:auto/ui/views/subject_deails_screen/subject_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubjectTile extends StatelessWidget {
  const SubjectTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => Get.to(SubjectDetailsScreen()),child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 80.h,
        width: 100.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.exOnPrimaryContainer,
            borderRadius: BorderRadius.circular(10.w),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 2.w
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CustomNetworkImage(ImageConst.subjectImageConst,
              boxFit: BoxFit.cover, width: 69.w),
          SizedBox(
            width: 10,
          ),
          RichText(text: TextSpan(
              text: 'اسم المادة :  ',
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground,fontFamily: 'Alexandria',fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: 'رياضيات',style: TextStyle(color: Theme.of(context).colorScheme.onBackground,fontFamily: 'Alexandria',fontWeight: FontWeight.w500))

              ]

          )),
          SizedBox(width: 120,),
          IconButton(onPressed: () {
            Get.to(const SubjectDetailsScreen());
          }, icon:const  Icon(Icons.arrow_forward))
        ]),
      ),
    ),);
  }
}
