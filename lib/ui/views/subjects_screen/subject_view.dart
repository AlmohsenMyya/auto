import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/subjects_screen/subject_widget/subject_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: MainAppBar(

  showArrowBack: true,
  onTap:() =>  Get.back(),

    titleText: 'المواد الدراسية',titleTextStyle: TextStyle(color:     Theme.of(context).colorScheme.primary,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Alexandria')
)
      // textStyle: const TextStyle(color: Colors.black)

,
      body: Column(children: [

const SizedBox(height: 10,),
      Expanded(child:   ListView.separated(itemBuilder: (context, index) =>const  SubjectTile(), separatorBuilder: (context, index) => SizedBox(height:10), itemCount: 10))
      ]),

    );
  }
}
