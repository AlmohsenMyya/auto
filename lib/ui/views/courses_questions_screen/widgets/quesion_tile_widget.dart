import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionTileWidget extends StatefulWidget {
  bool open;

  QuestionTileWidget({required this.open, super.key});

  @override
  State<QuestionTileWidget> createState() => _QuestionTileWidgetState();
}

class _QuestionTileWidgetState extends State<QuestionTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(dividerColor: Colors.black,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          widget.open = !widget.open;
        });
      },
      animationDuration: Duration(milliseconds: 500),
      children: [
        ExpansionPanel(backgroundColor: context.exOnPrimaryContainer,
            canTapOnHeader: true,
            isExpanded: widget.open,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return          Container(
                width: 1.sw,
                height: 40.h,
                color: context.exOnPrimaryContainer,
                child: RichText(
                    text: TextSpan(text: 'السؤال الاول :',

                        style:  context.exTextTheme.subtitle1!
                            .copyWith(color: context.exOnBackground),
                        children: [
                          TextSpan(text: 'هذا النص فقط للاختبار',style:  context.exTextTheme.subtitle2!
                              .copyWith(color: context.exPrimaryColor))
                        ])),
              );
            },
            body:

Container(width: 1.sw,
  height: 120.h,
  child:         Column(

  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    RichText(text: TextSpan(text: '-1-',style:  context.exTextTheme.headline3!
        .copyWith(color: context.exOnBackground),children:  [TextSpan(text: '  هذا النص فقط للاختبار',style:

    context.exTextTheme.subtitle2!
        .copyWith(color: context.exPrimaryColor)
    )])),

    10.h.verticalSpace,

  RichText(text: TextSpan(text: '-2-',style:  context.exTextTheme.headline3!
      .copyWith(color: context.exOnBackground),children:  [TextSpan(text: '  هذا النص فقط للاختبار',style:

  context.exTextTheme.subtitle2!
      .copyWith(color: context.exPrimaryColor)
  )])),

    10.h.verticalSpace,

    RichText(text: TextSpan(text: '-3-',style:  context.exTextTheme.headline3!
        .copyWith(color: context.exOnBackground),children:  [TextSpan(text: '  هذا النص فقط للاختبار',style:

    context.exTextTheme.subtitle2!
        .copyWith(color: context.exPrimaryColor)
    )])),




    ],),)
        )
      ],
    );
  }
}
