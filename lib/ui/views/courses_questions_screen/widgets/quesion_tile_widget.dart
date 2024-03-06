import 'package:auto/core/ui/main_button.dart';
import 'package:auto/core/ui/responsive_padding.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extension.dart';
import 'package:auto/ui/shared/custom_widgets/media_view/media_widget/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuestionTileWidget extends StatefulWidget {
  bool open;

  QuestionTileWidget({required this.open, super.key});

  @override
  State<QuestionTileWidget> createState() => _QuestionTileWidgetState();
}

class _QuestionTileWidgetState extends State<QuestionTileWidget> {
TextEditingController questionExplain=TextEditingController(text: 'شرح السؤال');
  var fo =FocusNode();
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      dividerColor: Colors.black,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          widget.open = !widget.open;
        });
      },
      animationDuration: Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
            backgroundColor: context.exOnPrimaryContainer,
            canTapOnHeader: true,
            isExpanded: widget.open,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                width: 1.sw,
                height: 40.h,
                color: context.exOnPrimaryContainer,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(Icons.more_vert,),
                  10.w.horizontalSpace,
                  RichText(
                      text: TextSpan(
                          text: 'السؤال الاول :',
                          style: context.exTextTheme.subtitle1!
                              .copyWith(color: context.exOnBackground),
                          children: [
                        TextSpan(
                            text: 'هذا النص فقط للاختبار',
                            style: context.exTextTheme.subtitle2!
                                .copyWith(color: context.exPrimaryColor))
                      ])),
                ]),
              );
            },
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: '-1-',
                              style: context.exTextTheme.headline3!
                                  .copyWith(color: context.exOnBackground),
                              children: [
                            TextSpan(
                                text: '  هذا النص فقط للاختبار',
                                style: context.exTextTheme.subtitle2!
                                    .copyWith(color: context.exPrimaryColor))
                          ])),
                      Radio(
                        value: '',
                        groupValue: '',
                        onChanged: (value) {},
                      )
                    ],
                  ),
                  10.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: '-2-',
                              style: context.exTextTheme.headline3!
                                  .copyWith(color: context.exOnBackground),
                              children: [
                            TextSpan(
                                text: '  هذا النص فقط للاختبار',
                                style: context.exTextTheme.subtitle2!
                                    .copyWith(color: context.exPrimaryColor))
                          ])),
                      Radio(
                        value: '',
                        groupValue: '',
                        onChanged: (value) {},
                      )
                    ],
                  ),
                  10.h.verticalSpace,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: '-3-',
                                style: context.exTextTheme.headline3!
                                    .copyWith(color: context.exOnBackground),
                                children: [
                              TextSpan(
                                  text: '  هذا النص فقط للاختبار',
                                  style: context.exTextTheme.subtitle2!
                                      .copyWith(color: context.exPrimaryColor))
                            ])),
                        Radio(
                          value: '',
                          groupValue: '',
                          onChanged: (value) {},
                        )
                      ]),
                  10.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(color: context.exOnBackground,
                          onPressed: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                      builder: (context, setState) => Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            width: 0.85.sw,
                                            height: 0.7.sh,
                                            child: CachedNetworkImage(
                                              isPush: true,
                                              imageFit: BoxFit.cover,
                                              hash:
                                                  'LNPjDZ^%-:x__4%K%MIVs7R.IUt5',
                                              url:
                                                  'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                                              width: 100.w,
                                              height: 100.h,
                                            )),
                                      ),
                                    ));
                          },
                          icon: Icon(Icons.camera_alt)),
                      IconButton(color: context.exOnBackground,
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => SizedBox(
                                width: 0.85.sw,
                                height: 0.5.sh,

                                child: Dialog(

                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: SingleChildScrollView(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              20.h.verticalSpace,
                                              Text("شرح السؤال",style: context.exTextTheme.headline3!,),
                                              20.h.verticalSpace,
                                              Padding(padding: HWEdgeInsetsDirectional.only(start: 10.w,end: 10.w), child: TextFormField(
                                                  onTapOutside: (event) => fo.unfocus(),
                                                  focusNode: fo,
                                                  controller: questionExplain,
                                                  enabled: false,
                                                  decoration: InputDecoration(

                                                      focusedBorder: OutlineInputBorder(),
                                                      enabledBorder: OutlineInputBorder(),
                                                      disabledBorder:
                                                      OutlineInputBorder())),),

                                              0.32.sh.verticalSpace,


                                            ]),
                                      ),
                                    )),
                              ).padding(HWEdgeInsetsDirectional.only( top: 120,bottom: 120)),
                            );

                          },
                          icon: Icon(Icons.question_mark_rounded)),
                      IconButton(color: context.exOnBackground,
                          onPressed: () {

                          },
                          icon: Icon(Icons.star_border_purple500_outlined)),
                      IconButton(color: context.exOnBackground,onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => SizedBox(
                            width: 0.85.sw,
                            height: 0.5.sh,

                            child: Dialog(

                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          20.h.verticalSpace,
                                          Text("ادخل ملاحظة",style: context.exTextTheme.headline3!,),
                                          20.h.verticalSpace,
                                          Padding(padding: HWEdgeInsetsDirectional.only(start: 10.w,end: 10.w), child: TextFormField(
                                              onTapOutside: (event) => fo.unfocus(),
                                              focusNode: fo,
                                              decoration: InputDecoration(

                                                  focusedBorder: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(),
                                                  disabledBorder:
                                                  OutlineInputBorder())),),

                                          0.32.sh.verticalSpace,

                                          Align(alignment: Alignment.bottomCenter,child: MainButton(

                                            borderRadius: BorderRadius.circular(10.w),
                                            width: 0.5.sw,
                                            height:20.h,
                                            text: 'تم', color: context.exPrimaryColor, onPressed: () => Get.back(),),)


                                        ]),
                                  ),
                                )),
                          ).padding(HWEdgeInsetsDirectional.only( top: 120,bottom: 120)),
                        );

                      }, icon: Icon(Icons.folder)),
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
}
