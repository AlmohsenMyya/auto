import 'package:auto/core/resource/assets.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/courses/widgets/cources_card_widget.dart';
import 'package:auto/ui/views/courses_according_to_unit_and_lessons_screen/widgets/cources_according_to_unit_and_lessons_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../shared/colors.dart';
import 'courses_controller.dart';

class Courses extends StatefulWidget {
  Subject subject;

  Courses({super.key, required this.subject});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  FocusNode focusNode = FocusNode();

  ValueNotifier<bool> openTextField = ValueNotifier(false);

  TextEditingController searchController = TextEditingController();
  late CoursesController controller;

  @override
  void initState() {
    controller = Get.put(CoursesController());
    controller.readfile(widget.subject.subject_id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          backGroundColor: context.exOnPrimaryContainer,
          onTap: () => Navigator.of(context).pop(),
          titleText: ' دورات مادة ${widget.subject.name}',
          titleTextStyle: context.exTextTheme.bodyText1!.copyWith(
              color: context.exOnBackground, fontFamily: 'Alexandria')),
      body: Column(children: [
        //todo search

        10.h.verticalSpace,
        Container(
          width: 0.85.sw,
          height: 50.h,
          decoration: BoxDecoration(
              color: context.exOnPrimaryContainer,
              borderRadius: BorderRadius.circular(12.w)),
          child: ValueListenableBuilder(
            valueListenable: openTextField,
            builder: (context, value, child) => Align(
                alignment: Alignment.topRight,
                child: TextField(
                    controller: searchController,
                    onTap: () => openTextField.value = true,
                    onTapOutside: (event) {
                      focusNode.unfocus();
                      if (identical(searchController.text, ''))
                        openTextField.value = false;
                    },
                    focusNode: focusNode,
                    decoration: InputDecoration(
                        label: value
                            ? const SizedBox.shrink()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                    10.horizontalSpace,
                                    SvgPicture.string(Asset.searchSvgIcon),
                                    10.horizontalSpace,
                                    CustomText(
                                      textType: TextStyleType.body,
                                      text: 'ابحث هنا',
                                      textColor: context.exPrimaryContainer,
                                    )
                                  ]),
                        border: InputBorder.none))),
          ),
        ),

        20.h.verticalSpace,
        Obx(() => controller.isLoading.value
            ? SpinKitThreeBounce(
                color: AppColors.blueB4,
                size: 50.0,
              )
            : Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) => CoursesCardWidget(
                          index: index,
                        ),
                    itemCount: controller.courses.length)))
      ]),
    );
  }
}
