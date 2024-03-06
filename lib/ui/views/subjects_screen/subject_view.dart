import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/subjects_screen/subject_widget/subject_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(backGroundColor: context.exOnPrimaryContainer,
          showArrowBack: true,
          onTap: () => Get.back(),
          titleText: 'المواد الدراسية',
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Alexandria'))
      // textStyle: const TextStyle(color: Colors.black)

      ,
      body: Column(children: [
        SizedBox(
          height: 10.h
          ,
        ),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => const SubjectTile(),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: 10))
      ]),
    );
  }
}
